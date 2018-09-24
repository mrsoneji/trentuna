local composer = require( 'composer' )
local widget = require( 'widget' )
local ads = require( 'ads' )
local store = require( 'store' )
local gameNetwork = require('gameNetwork')
local utility = require( 'utility' )
local device = require( 'device' )

display.setStatusBar( display.HiddenStatusBar )

math.randomseed( os.time() )

if device.isAndroid then
	widget.setTheme( 'widget_theme_android_holo_light' )
    store = require('plugin.google.iap.v3')
end

--
-- Load saved in settings
--

local myData = utility.loadSettings()
if (myData == nil) then
    myData = {
        effectsOn = true,
        musicOn = true,
        levelDone = { false, false, false, false, false }
    }
	utility.saveTable(myData, 'myData.json')
end

--
-- Initialize ads
--

--
-- Put your Ad listener and init code here
--

--
-- Initialize in app purchases
--

--
-- Put your IAP code here
--


--
-- Initialize gameNetwork
--

--
-- Put your gameNetwork login handling code here
--

--
-- Load your global sounds here
-- Load scene specific sounds in the scene
--
-- myData.splatSound = audio.load('audio/splat.wav')
--

--
-- Other system events
--
local function onKeyEvent( event )

    local phase = event.phase
    local keyName = event.keyName

    if ( 'back' == keyName and phase == 'up' ) then
        if ( composer.getSceneName('current') == 'menu' ) then
            native.requestExit()
        elseif (composer.getSceneName('current') == 'bookSheet') then
            composer.gotoScene( 'book', { effect='flip', time=300 } )
        else
            composer.gotoScene( 'menu', { effect='crossFade', time=500 } )
        end
        return true
    end
    return false
end

--add the key callback
if device.isAndroid then
    Runtime:addEventListener( 'key', onKeyEvent )
end

--
-- handle system events
--
local function systemEvents(event)
    if event.type == 'applicationSuspend' then
    elseif event.type == 'applicationResume' then
        -- 
        -- login to gameNetwork code here
        --
    elseif event.type == 'applicationExit' then
        -- ??
    elseif event.type == 'applicationStart' then
        --
        -- Login to gameNetwork code here
        --
        --
        -- Go to the menu
        --
        composer.gotoScene( 'menu', { time = 250, effect = 'fade' } )
    end
    return true
end
Runtime:addEventListener('system', systemEvents)
