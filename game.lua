local composer = require( 'composer' )
local Gesture = require('lib_gesture')
local widget = require( 'widget' )
local json = require( 'json' )
local utility = require( 'utility' )
local myData = require( 'mydata' )
local math = require( 'math' )
local timer =  require ('classTimerTag')
local animacion = require( 'animacion' )
local sonidos = require('sonidosSettings')
local Hero = require('hero')
local enemysSettings = require('enemysSettings')
local levelsSettings = require('levelsSettings')
local uiSettings = require( 'uiSettings')
local scene = composer.newScene()
local gameState = 'wave'
local levelText             -- will be a display.newText() to let you know what level you're on
local pointsTable = {}
local line
local spawnTimer
local commandBuffer = { }
local actualEnemyInSecuence = 0
local actualLevelEnemySecuenceList
local waveLabel
local sceneGroup
local enemies

local function exit( event )
    if ( 'ended' == event.phase ) then
        audio.stop(sonidos.channels.background)
        composer.removeScene( 'game' )
        composer.gotoScene( 'menu', { effect = 'crossFade', time = 333 } )
    end
end

function gestureLogic(gestureLogic)
    gestureText.text = Gesture.GestureResult()        
    for i = enemies.numChildren, 1, -1 do
        local enemy = enemies[i]
        if (enemy ~= nil) then
            if (enemy.deathSequence[1] == gestureLogic) then
                if (table.getn(enemy.deathSequence) == 1) then
                    killEnemy(enemy)
                else
                    enemies[i] = hitEnemy(enemy)
                end
            end
        end
    end
end

function killEnemy(enemy)
    local killedEffect = animacion.crear(enemysSettings.killedAnimation)
    killedEffect:scale(.5, .5)
    enemy:insert(killedEffect, true)
    timer.performWithDelay( 1000, function() 
        transition.cancel(enemy.transitionId)
        if (killedEffect ~= nil) then
            killedEffect:removeSelf()
            enemy:removeSelf() 
        end
    end )
end

function hitEnemy(enemy)
    local angle = math.atan2(enemy.y - enemy.initialY, enemy.x - enemy.initialX)
    transition.cancel(enemy.transitionId)
    enemy.x = enemy.x - 125 * math.cos(angle)
    enemy.y = enemy.y - 125 * math.sin(angle)
    enemy.transitionId = transition.to(enemy, enemy.transitionParams)
    --enemy.deathSequence[1] = nil
    table.remove(enemy.deathSequence, 1)
    return enemy
end

function spawnEnemy()
    math.randomseed( os.time() )
    --todavía no sé que enemigo voy a spawnear
    local enemyChosen = 0
    if (gameState == 'wave') then
        return nil
    end
    enemies = display.newGroup()
    --avanzo al siguiente enemigo en la secuencia para este nivel
    actualEnemyInSecuence = actualEnemyInSecuence + 1
    --si todavía no acabé la secuencia para este level        
    if actualEnemyInSecuence <= table.getn(actualLevelEnemySecuenceList) then
        enemyChosen = actualLevelEnemySecuenceList[actualEnemyInSecuence]
    else
        if (enemies.numChildren == 0) then
            actualWave = actualWave + 1
            waveLabel = animacion.crear(uiSettings.getWave(actualWave))
            waveLabel.x = display.contentCenterX
            waveLabel.y = display.contentCenterY
            waveLabel.alpha = 1
            gameState = 'wave'
            actualEnemyInSecuence = 0
            actualLevelEnemySecuenceList = actualLevelData.enemySecuences[actualWave]
            timer.performWithDelay( 5000, function() 
                waveLabel.alpha = 0 
                gameState = 'go'
            end )
        end
        return nil
    end
    --animacion enemy
    local enemyData = enemysSettings.list[enemyChosen]
    local enemyAniData = enemyData.animations[1]
    local enemyImage = animacion.crear(enemyAniData)
    enemyImage.x = display.contentWidth / 2
    enemyImage.y = 30
    -- local enemy = display.newContainer( enemyImage.contentWidth, enemyImage.contentHeight + 40 )
    local enemy = display.newContainer( enemysSettings.killedAnimation.width, enemysSettings.killedAnimation.height + 50 )
    ----
    enemy.deathSequence = table.deepCopy(enemyData.deathSequence)
    --ubicación y scala del enemigo/
    local xRandom = math.random(0, display.contentWidth)
    local yRandom = math.random(0, display.contentHeight)
    local xScale = 1
    local yScale = 1
    local pivotX = enemyImage.contentWidth / 2
    local pivotY = enemyImage.contentHeight / 2
    local angle = math.atan2(display.contentCenterY - yRandom, display.contentCenterX - xRandom)
    if (xRandom < display.contentCenterX) then
        xRandom = xRandom - pivotX
    else
        xScale = -xScale
        xRandom = xRandom + pivotX
    end

    if (yRandom > 20) then
        if (xRandom < display.contentCenterX) then
            xRandom = -pivotX
        else
            xRandom = display.contentWidth + pivotX
        end
    end
    yRandom = yRandom + pivotY
    local paramsAnimation = { time = enemyData.speed, x = display.contentCenterX - (80 * math.cos(angle)), y = display.contentCenterY - (80 * math.sin(angle)), onComplete = Hero.hurt }
    --escala y espejado
    if (yRandom < display.contentCenterY) then
        yRandom = yRandom - pivotY
        paramsAnimation = { time = enemyData.speed, x = display.contentCenterX - (80 * math.cos(angle)), y = display.contentCenterY - (80 * math.sin(angle)), xScale = (1 * xScale), yScale = 1, onComplete = Hero.hurt }
        xScale = 0.4 * xScale
        yScale = 0.4
    end
    --spawn fuera de la pantalla
    enemy:scale(xScale, yScale)
    enemy.x = xRandom
    enemy.y = yRandom
    enemy.initialX = xRandom
    enemy.initialY = yRandom
    --/ubicación y scala del enemigo
    enemy:insert(enemyImage, true)    
    for i=table.getn(enemyData.deathSequenceIcons), 1, -1 do
        local gestureIcon = display.newImage(enemyData.deathSequenceIcons[i])
        gestureIcon.x = -((20 * i) - 40)
        gestureIcon.y = -60
        if (xRandom < display.contentCenterX) then
            gestureIcon:scale(.5, .5)
        else
            gestureIcon:scale(-.5, .5)
        end
        enemy:insert(gestureIcon)
    end
    enemy.transitionParams = paramsAnimation
    enemy.transitionId = transition.to(enemy, paramsAnimation)
    enemies:insert(enemy)
    sceneGroup:insert(enemies)
    -- llevar al heroe siempre al frente
    hero:toFront()
    spawnTimer._delay = math.random(1000, 10000)
end

function spawnEnemies()
    spawnTimer = timer.performWithDelay( 1000, spawnEnemy, -1 )
end

function drawLine()
    if (line and #pointsTable > 2) then
        line:removeSelf()
    end
    local numPoints = #pointsTable
    local nl = {}
    local  j, p
    nl[1] = pointsTable[1]
    j = 2
    p = 1
    for  i = 2, numPoints, 1  do
        nl[j] = pointsTable[i]
        j = j+1
        p = i 
    end
    
    if ( p  < numPoints -1 ) then
        nl[j] = pointsTable[numPoints-1]
    end
    
    if #nl > 2 then
        line = display.newLine(nl[1].x,nl[1].y,nl[2].x,nl[2].y)
        for i = 3, #nl, 1 do 
            line:append( nl[i].x,nl[i].y);
        end
        line:setStrokeColor(255,255,0)
        line.strokeWidth=5
        sceneGroup:insert(line)
    end
end

function scene:touch(event)
    if 'began' == event.phase then
        pointsTable = nil
        pointsTable = {}
        local pt = {}
        pt.x = event.x
        pt.y = event.y
        table.insert(pointsTable,pt)
        drawLine()
    elseif 'moved' == event.phase then
        local pt = {}
        pt.x = event.x
        pt.y = event.y
        table.insert(pointsTable,pt)
        drawLine()
    elseif 'ended' == event.phase or 'cancelled' == event.phase then
        drawLine()
        gestureLogic(Gesture.GestureResult())
        local attackSound = audio.play(sonidos.effects.heroe.attack1)
        local random0or1 = math.floor(math.random()*2)
        if random0or1 == 0 then
            hero.attack1Ani.alpha = 1
        else
            hero.attack2Ani.alpha = 1
        end
        hero.hiddleAni.alpha = 0
        timer.performWithDelay( 500, function()
            hero.attack1Ani.alpha = 0
            hero.attack2Ani.alpha = 0
            hero.hiddleAni.alpha = 1
        end, 'attackTimer' )
    end
end

function scene:create( event )
    sceneGroup = self.view
    local actualLevel = event.params.levelToPlay
    local actualLevelData = levelsSettings.levels[actualLevel]
    local actualWave = 1
    actualLevelEnemySecuenceList = actualLevelData.enemySecuences[actualWave]
    local backgroundMusic = audio.play(sonidos.themes.levelBackground[actualLevel], {loops = -1 , channel = sonidos.channels.background} )
    local fondo = display.newImage(actualLevelData.fondo.imagen)
    fondo.y = actualLevelData.fondo.y
    fondo.x = display.contentCenterX
    fondo.width = display.contentWidth
    sceneGroup:insert(fondo)
    gestureText = display.newText('', 100, 50, native.systemFont, 12)
    gestureText:setTextColor(255, 255, 255)
    sceneGroup:insert(gestureText)
    hero = Hero.spawn()
    sceneGroup:insert(hero)
    spawnEnemies()
    

    levelLabel = display.newImage(uiSettings.getLevel(actualLevel))
    levelLabel.x = display.contentCenterX
    levelLabel.y = display.contentCenterY
    levelLabel.alpha = 1
    local levelLabelSound = audio.play(sonidos.effects.level.init)
    sceneGroup:insert(levelLabel)

    waveLabel = animacion.crear(uiSettings.getWave(actualWave))
    waveLabel.x = display.contentCenterX
    waveLabel.y = display.contentCenterY
    waveLabel.alpha = 0
    sceneGroup:insert(waveLabel)
    --hide level / show wave label
    timer.performWithDelay( 3000, function() 
        levelLabel.alpha = 0
        waveLabel.alpha = 1
    end )
    --hide wave label start
    timer.performWithDelay( 6000, function() 
        waveLabel.alpha = 0 
        gameState = 'go'
        actualLevelEnemySecuenceList = actualLevelData.enemySecuences[actualWave]
    end )

    local exitButton = display.newImage(uiSettings.exit)
    exitButton.x = display.contentWidth - 25
    exitButton.y = 25
    sceneGroup:insert( exitButton )
    exitButton:addEventListener('touch', exit)

end

function scene:show( event )
    local sceneGroup = self.view
    if event.phase == 'did' then
    else
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    if event.phase == 'will' then
    end

end

function scene:destroy( event )
    local sceneGroup = self.view
    
end

function table.deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= 'table' then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

Runtime:addEventListener( 'touch' , scene )
scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )
return scene
