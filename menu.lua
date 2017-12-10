local composer = require( 'composer' )
local scene = composer.newScene()
local uiSettings = require( 'uiSettings' )
local utility = require('utility')
local animacion = require( 'animacion' )
local sonidos = require('sonidosSettings')
audio.setVolume(0.5)

local myData = utility.loadSettings()
local function PlayEvent( event )
    if ( "ended" == event.phase ) then
        audio.play(sonidos.effects.ui.menuSelect)
        audio.stop(sonidos.channels.background)
        composer.removeScene( "levelselect", false )
        composer.gotoScene("levelselect", { effect = "crossFade", time = 333 })
    end
end

local function OptionsEvent( event )
    if ( "ended" == event.phase ) then
        audio.play(sonidos.effects.ui.menuSelect)
        audio.stop(sonidos.channels.background)
        composer.gotoScene("options", { effect = "crossFade", time = 333 })
    end
end

local function BookEvent( event )
    if ( "ended" == event.phase ) then
        audio.play(sonidos.effects.ui.menuSelect)
        audio.stop(sonidos.channels.background)
        composer.gotoScene("book", { effect = "crossFade", time = 333 })
    end
end

local title = animacion.crear(uiSettings.title)
title.x = display.contentCenterX
title.y = 70
audio.play(sonidos.themes.menu, {loops = -1 , channel = sonidos.channels.background} )

local play = display.newImage(uiSettings.play)
play.x = display.contentCenterX
play.y = display.contentCenterY + 20
play:addEventListener('touch', PlayEvent)

local options = display.newImage(uiSettings.options)
options.x = display.contentCenterX
options.y = display.contentCenterY + 70
options:addEventListener('touch', OptionsEvent)

local book = display.newImage(uiSettings.stickerbook)
book.x = display.contentCenterX + 170
book.y = display.contentCenterY + 70
book.alpha = 0
book:addEventListener('touch', BookEvent)

local bookBlocked = display.newImage(uiSettings.stickerbookblocked)
bookBlocked.x = display.contentCenterX + 170
bookBlocked.y = display.contentCenterY + 70
bookBlocked.alpha = 0

local fondo = display.newImage( 'images/scenarios/1.jpg' )
fondoPivotX = fondo.contentWidth / 2
fondoPivotY = fondo.contentHeight / 2
fondo.y = fondoPivotY
fondo.x = fondoPivotX
transition.to(fondo, {time = 100000, xScale = 1, yScale = 1, y = -320, x = 455 })

function scene:create( event )
    local sceneGroup = self.view
    sceneGroup:insert(fondo)
    sceneGroup:insert( title )
    sceneGroup:insert( play )
    sceneGroup:insert( options )
    sceneGroup:insert( book )
    sceneGroup:insert( bookBlocked )
end

function scene:show( event )
    local sceneGroup = self.view
    if event.phase == 'did' then
        composer.removeScene( 'game' ) 
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
