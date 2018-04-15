local composer = require('composer')
local scene = composer.newScene()
local widget = require('widget')
local utility = require('utility')
local device = require('device')
local uiSettings = require('uiSettings')
local sonidos = require('sonidosSettings')
audio.setVolume( 0.5, { channel=1 } )

local params
local myData = utility.loadSettings()

if device.isAndroid then
    widget.setTheme( 'widget_theme_android_holo_dark' )
end

local function onEffectsSwitchPress(event)
    local switch = event.target
    myData.settings.effectsOn = switch.isOn
    utility.saveSettings(myData)
end

local function onMusicSwitchPress(event)
    local switch = event.target
    myData.settings.musicOn = switch.isOn
    utility.saveSettings(myData)
end

local function goBack( event )
    if ( 'ended' == event.phase ) then
        composer.removeScene('options')
        audio.play(sonidos.effects.ui.menuBack)
        composer.gotoScene('menu', { effect = 'crossFade', time = 333 })
    end
end

local fondo = display.newImage( 'images/scenarios/1.jpg' )
fondoPivotX = fondo.contentWidth / 2
fondoPivotY = fondo.contentHeight / 2
fondo.x = fondoPivotX
fondo.y = -320
transition.to(fondo, {time = 100000, xScale = 1, yScale = 1, x = 455, y = fondoPivotY })

local title = display.newImage(uiSettings.sounds)
title.x = display.contentCenterX
title.y = display.contentCenterY - 100

local musicLabel = display.newImage(uiSettings.music)
musicLabel.x = display.contentCenterX - 75
musicLabel.y = 180

local effectsLabel = display.newImage(uiSettings.effects)
effectsLabel.x = display.contentCenterX - 75
effectsLabel.y = 130

local effectsOnOffSwitch = widget.newSwitch({
    style = 'onOff',
    id = 'effectsOnOffSwitch',
    initialSwitchState = myData.settings.effectsOn,
    onRelease = onEffectsSwitchPress
})
effectsOnOffSwitch.x = display.contentCenterX + 100
effectsOnOffSwitch.y = effectsLabel.y

local musicOnOffSwitch = widget.newSwitch({
    style = 'onOff',
    id = 'musicOnOffSwitch',
    initialSwitchState = myData.settings.musicOn,
    onRelease = onMusicSwitchPress
})
musicOnOffSwitch.x = display.contentCenterX + 100
musicOnOffSwitch.y = musicLabel.y

local done = display.newImage(uiSettings.done)
done.x = display.contentCenterX
done.y = display.contentCenterY + 100

function scene:create( event )
    local sceneGroup = self.view
    params = event.params
    sceneGroup:insert(fondo)
    sceneGroup:insert(title)
    sceneGroup:insert(musicLabel)
    sceneGroup:insert(effectsLabel)
    sceneGroup:insert(effectsOnOffSwitch)
    sceneGroup:insert(musicOnOffSwitch)
    sceneGroup:insert(done)
    done:addEventListener('touch', goBack)
end

function scene:show( event )
    local sceneGroup = self.view
    params = event.params
    if event.phase == 'did' then
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

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )
return scene
