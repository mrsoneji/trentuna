local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local myData = require( "mydata" )
local utility = require( "utility" ) 
local device = require( "device" )
local uiSettings = require( "uiSettings" )
local sonidos = require('sonidosSettings')
audio.setVolume( 0.5, { channel=1 } )

local params
if device.isAndroid then
    widget.setTheme( "widget_theme_android_holo_dark" )
end

local function onSoundSwitchPress( event )
    local switch = event.target
    if switch.isOn then
        myData.settings.soundOn = true
    else
        myData.settings.soundOn = false
    end
    utility.saveTable(myData.settings, "settings.json")
end

local function onMusicSwitchPress( event )
    local switch = event.target
    if switch.isOn then
        myData.settings.musicOn = true
    else
        myData.settings.musicOn = false
    end
    utility.saveTable(myData.settings, "settings.json")
end

local function goBack( event )
    if ( "ended" == event.phase ) then
        local selectSound = audio.play(sonidos.effects.ui.menuBack)
        composer.gotoScene("menu", { effect = "crossFade", time = 333 })
    end
end

function scene:create( event )
    local sceneGroup = self.view
    params = event.params

    local fondo = display.newImage( "images/scenarios/1.jpg" )
    fondoPivotX = fondo.contentWidth / 2
    fondoPivotY = fondo.contentHeight / 2
    fondo.x = fondoPivotX
    fondo.y = -320
    transition.to(fondo, {time = 100000, xScale = 1, yScale = 1, x = 455, y = fondoPivotY })
    sceneGroup:insert(fondo)

    local title = display.newImage(uiSettings.sounds)
    title.x = display.contentCenterX
    title.y = display.contentCenterY - 100
    sceneGroup:insert( title )

    local musicLabel = display.newImage(uiSettings.music)
    musicLabel.x = display.contentCenterX - 75
    musicLabel.y = 180
    sceneGroup:insert( musicLabel )

    local soundLabel = display.newImage(uiSettings.effects)
    soundLabel.x = display.contentCenterX - 75
    soundLabel.y = 130
    sceneGroup:insert( soundLabel )

    local soundOnOffSwitch = widget.newSwitch({
        style = "onOff",
        id = "soundOnOffSwitch",
        initialSwitchState = myData.settings.soundOn,
        onPress = onSoundSwitchPress
    })
    soundOnOffSwitch.x = display.contentCenterX + 100
    soundOnOffSwitch.y = soundLabel.y
    sceneGroup:insert( soundOnOffSwitch )

    local musicOnOffSwitch = widget.newSwitch({
        style = "onOff",
        id = "musicOnOffSwitch",
        initialSwitchState = myData.settings.musicOn,
        onPress = onMusicSwitchPress
    })
    musicOnOffSwitch.x = display.contentCenterX + 100
    musicOnOffSwitch.y = musicLabel.y
    sceneGroup:insert( musicOnOffSwitch )

    local done = display.newImage(uiSettings.done)
    done.x = display.contentCenterX
    done.y = display.contentCenterY + 100
    sceneGroup:insert( done )
    done:addEventListener("touch", goBack)

end

function scene:show( event )
    local sceneGroup = self.view
    params = event.params
    if event.phase == "did" then
    end
end

function scene:hide( event )
    local sceneGroup = self.view    
    if event.phase == "will" then
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
    
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
