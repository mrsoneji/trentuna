Enemy = {}
--Enemy.__index = Enemy
local enemysSettings = require('enemysSettings')
local sonidos = require('sonidosSettings')
local animacion = require('animacion')
local widget = require('widget')
local actualEnemyInSecuence = 0
local actualLevelEnemySecuenceList

function Enemy:new(actualLevelData, actualWave, hero, enemies)
    actualLevelEnemySecuenceList = actualLevelData.enemySecuences[actualWave]
    math.randomseed( os.time() )
    --todavía no sé que enemigo voy a spawnear
    local enemyChosen = 0
    if (gameState == 'wave') then
        return nil
    end
    --avanzo al siguiente enemigo en la secuencia para este nivel
    actualEnemyInSecuence = actualEnemyInSecuence + 1
    --si todavía no acabé la secuencia para este level        
    if actualEnemyInSecuence <= table.getn(actualLevelEnemySecuenceList) then
        enemyChosen = actualLevelEnemySecuenceList[actualEnemyInSecuence]
    else
        return nil
    end
    --animacion enemy
    local enemyData = enemysSettings.list[enemyChosen]
    local enemyAniData = enemyData.animations[1]
    local enemyImage = animacion.crear(enemyAniData)
    enemyImage.x = display.contentWidth / 2
    enemyImage.y = 30
    local enemy = display.newContainer( enemysSettings.killedAnimation.width, enemysSettings.killedAnimation.height )
    enemy.gestureIcons = {}
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
    local paramsAnimation = { 
        time = enemyData.speed, 
        x = display.contentCenterX - (80 * math.cos(angle)), 
        y = display.contentCenterY - (80 * math.sin(angle)), 
        onComplete = hero.hurt
    }
    --escala y espejado
    if (yRandom < display.contentCenterY) then
        yRandom = yRandom - pivotY
        paramsAnimation = { time = enemyData.speed, x = display.contentCenterX - (80 * math.cos(angle)), y = display.contentCenterY - (80 * math.sin(angle)), xScale = (1 * xScale), yScale = 1, onComplete = hero.hurt }
        xScale = 0.4 * xScale
        yScale = 0.4
    end
    --spawn fuera de la pantalla
    enemy.status = "alive"
    enemy:scale(xScale, yScale)
    enemy.x = xRandom
    enemy.y = yRandom
    enemy.initialX = xRandom
    enemy.initialY = yRandom
    --/ubicación y scala del enemigo
    enemy:insert(enemyImage, true)    
    enemy.gestures = display.newGroup()
    for i=table.getn(enemyData.deathSequenceIcons), 1, -1 do
        local gestureIcon = display.newImage(enemyData.deathSequenceIcons[i])
        gestureIcon.x = -((20 * i) - 40)
        gestureIcon.y = -60
        if (xRandom < display.contentCenterX) then
            gestureIcon:scale(.5, .5)
        else
            gestureIcon:scale(-.5, .5)
        end
        table.insert(enemy.gestureIcons, gestureIcon)
    end
    enemy.transitionParams = paramsAnimation
    enemy.transitionId = transition.to(enemy, paramsAnimation)
    if (enemyData.code) then
        audio.play(sonidos.effects.enemys[enemyData.code].spawn, { channel = sonidos.channels.enemys })
    end

    enemy.killed = function()
        killedEffect = animacion.crear(enemysSettings.killedAnimation)
        killedEffect:scale(.5, .5)
        audio.play(sonidos.effects.enemys[enemyData.code].dead, { channel = sonidos.channels.enemys })
        enemy:insert(killedEffect, true)
        timer.performWithDelay( 500, function() 
            transition.cancel(enemy.transitionId)
            if (killedEffect ~= nil) then
                for i = table.getn(enemy.gestureIcons), 1, -1 do
                    currentGesture = enemy.gestureIcons[i]
                    if (currentGesture ~= nil) then
                        currentGesture:removeSelf()
                    end
                end
                enemy:removeSelf() 

                for j = enemy.gestures.numChildren, 1, -1 do
                    enemy.gestures[j]:removeSelf()
                end

                enemy.status = "killed"
            end
        end )
    end

    enemy.hited = function()
        local angle = math.atan2(enemy.y - enemy.initialY, enemy.x - enemy.initialX)
        transition.cancel(enemy.transitionId)
        enemy.x = enemy.x - 125 * math.cos(angle)
        enemy.y = enemy.y - 125 * math.sin(angle)
        enemy.transitionId = transition.to(enemy, enemy.transitionParams)
        table.remove(enemy.deathSequence, 1)
    end

    enemy.enterFrame = function ()
        for i = table.getn(enemy.gestureIcons), 1, -1 do
            currentGesture = enemy.gestureIcons[i]
            if (currentGesture ~= nil) then
                currentGesture.x = enemy.x - (25 * (i - 1))
                currentGesture.y = enemy.y - 65
            end
        end
    end

    return enemy
end

function Enemy:reset() 
    actualEnemyInSecuence = 0
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

return Enemy
