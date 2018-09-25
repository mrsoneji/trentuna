local composer = require( 'composer' )
local Gesture = require('lib_gesture')
local math = require( 'math' )
local timer =  require ('classTimerTag')
local sonidos = require('sonidosSettings')
require('hero')
require('fondo')
require('enemyManager')
local ui = require('ui')
local levelsSettings = require('levelsSettings')
local beholder = require('beholder')

local scene = composer.newScene()
local gameState = 'wave'
local pointsTable = {}
local line
local spawnTimer
local sceneGroup
local enemy

local actualLevel
local actualLevelData
local actualWave = 1

local function exit( event )
    if ( 'ended' == event.phase ) then    
        Runtime:removeEventListener( 'touch' , scene )
        audio.fade( { channel=0, time=1000, volume=0.0 } )
        composer.removeScene( 'game' )
        composer.gotoScene( 'menu', { effect = 'crossFade', time = 333 } )
    end
end

function gestureLogic(gestureLogic)
    gestureText.text = Gesture.GestureResult()
    EnemyManager:handleEnemyLogic(gestureLogic)
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

function enemiesKilled()
    if (gameState == 'wait') then
        EnemyManager:reset()
        actualWave = actualWave + 1
        setState( { gameState = 'wave' } )
    end
end

function scene:touch(event)
    -- correct RuntimeEventDispatcher CoronaSDK's bug
    if (composer.getSceneName('current') ~= "game") then
        return
    end 
    
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
        audio.play(sonidos.effects.heroe.attack1)
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

function setState( state )
    gameState = state.gameState
    if ( state.gameState == 'wave' ) then
        levelLabel.alpha = 0
        waveLabel = ui.waveLabel(actualWave)
        waveLabel.alpha = 1

        --hide wave label start
        timer.performWithDelay( 2500, function() 
            setState( { gameState = 'go' } )

            actualLevelEnemySecuenceList = actualLevelData.enemySecuences[actualWave]
            timer.resume(spawnTimer)
        end )
    end

    if ( state.gameState == 'go' ) then
        levelLabel.alpha = 0
        waveLabel.alpha = 0
    end
end

function scene:create( event )
    sceneGroup = self.view

    actualLevel = event.params.levelToPlay
    actualLevelData = levelsSettings.levels[actualLevel]

    audio.play(sonidos.themes.level[actualLevel], {loops = -1 , channel = sonidos.channels.background} )
    audio.setVolume( 0.5, { channel = sonidos.channels.background } )

    fondo = Fondo:new(actualLevelData)
    sceneGroup:insert(fondo)

    gestureText = display.newText('', 100, 50, native.systemFont, 12)
    gestureText:setTextColor(255, 255, 255)
    sceneGroup:insert(gestureText)

    hero = Hero:new()
    sceneGroup:insert(hero)
  
    spawnTimer = timer.performWithDelay( 500, function()
        enemy = EnemyManager:new(actualLevelData, actualWave, hero)
        if (enemy == nil) then 
            gameState = 'wait'

            timer.pause(spawnTimer)
        end
    end, -1)
    sceneGroup:insert(EnemyManager.enemies)

    hero:toFront()
    spawnTimer._delay = math.random(500, 1000)

    exitButton = ui.exitButton()
    exitButton:addEventListener('touch', exit)
    sceneGroup:insert( exitButton )

    levelLabel = ui.levelLabel(actualLevel)
    sceneGroup:insert(levelLabel)

    waveLabel = ui.waveLabel(actualWave)
    sceneGroup:insert(waveLabel)

    -- Observer watching EnemyManager event when all enemies were killed.
    -- After ENEMIES_KILLED event is dispatched from EnemyManager
    -- enemiesKilled function is invoked.
    beholder.observe("ENEMIES_KILLED", enemiesKilled)

    --hide level / show wave label
    timer.performWithDelay( 3000, function() 
        setState( { gameState = 'wave', wave = 1 } )
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

function scene:destroy( event )
    local sceneGroup = self.view
end

Runtime:addEventListener( 'touch' , scene )
scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )
return scene
