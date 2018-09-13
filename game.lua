local composer = require( 'composer' )
local Gesture = require('lib_gesture')
local myData = require( 'mydata' )
local math = require( 'math' )
local timer =  require ('classTimerTag')
local sonidos = require('sonidosSettings')
require('hero')
require('fondo')
require('enemy')
local ui = require('ui')
local levelsSettings = require('levelsSettings')

local scene = composer.newScene()
local gameState = 'wave'
local pointsTable = {}
local line
local spawnTimer
local sceneGroup
local enemy
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
        currentEnemy = enemies[i]
        if (currentEnemy ~= nil) then
            if (currentEnemy.deathSequence[1] == gestureLogic) then
                if (table.getn(currentEnemy.deathSequence) == 1) then
                    currentEnemy.killed()
                else
                    enemies[i] = currentEnemy.hitted()
                end
            end
        end
    end
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
    local backgroundMusic = audio.play(sonidos.themes.levelBackground[actualLevel], {loops = -1 , channel = sonidos.channels.background} )

    fondo = Fondo:new(actualLevelData)
    sceneGroup:insert(fondo)

    gestureText = display.newText('', 100, 50, native.systemFont, 12)
    gestureText:setTextColor(255, 255, 255)
    sceneGroup:insert(gestureText)

    hero = Hero:new()
    sceneGroup:insert(hero)

    enemies = display.newGroup()    
    spawnTimer = timer.performWithDelay( 1000, function()
        enemy = Enemy:new(actualLevelData, actualLevel, hero)
        enemies:insert(enemy)
        sceneGroup:insert(enemies)
    end, -1)

    hero:toFront()
    spawnTimer._delay = math.random(1000, 10000)

    exitButton = ui.exitButton()
    exitButton:addEventListener('touch', exit)
    sceneGroup:insert( exitButton )

    levelLabel = ui.levelLabel(actualLevel)
    sceneGroup:insert(levelLabel)

    waveLabel = ui.waveLabel(actualWave)
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

function scene:enterFrame( event )
    local sceneGroup = self.view
    for i = enemies.numChildren, 1, -1 do
        currentEnemy = enemies[i]
        if (currentEnemy ~= nil) then
            currentEnemy.enterFrame()
        end
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
end

Runtime:addEventListener( "enterFrame", scene )
Runtime:addEventListener( 'touch' , scene )
scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )
return scene
