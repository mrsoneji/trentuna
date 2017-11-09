local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local utility = require( "utility" )
local ads = require( "ads" )
local uiSettings = require( "uiSettings" )
local animacion = require( "animacion" )
local sonidos = require('sonidosSettings')
local myData = require( "mydata" )
local params
audio.setVolume( 0.5, { channel=1 } )

local function PlayEvent( event )
    if ( "ended" == event.phase ) then
        local selectSound = audio.play(sonidos.effects.ui.menuSelect)
        composer.removeScene( "levelselect", false )
        composer.gotoScene("levelselect", { effect = "crossFade", time = 333 })
    end
end

local function OptionsEvent( event )
    if ( "ended" == event.phase ) then
        local selectSound = audio.play(sonidos.effects.ui.menuSelect)
        composer.gotoScene("options", { effect = "crossFade", time = 333 })
    end
end

local function BookEvent( event )
    if ( "ended" == event.phase ) then
        local selectSound = audio.play(sonidos.effects.ui.menuSelect)
        composer.gotoScene("book", { effect = "crossFade", time = 333 })
    end
end

function scene:create( event )
    local sceneGroup = self.view

    params = event.params

    fondo = display.newImage( "images/scenarios/1.jpg" )
    fondoPivotX = fondo.contentWidth / 2
    fondoPivotY = fondo.contentHeight / 2
    fondo.y = fondoPivotY
    fondo.x = fondoPivotX
    transition.to(fondo, {time = 100000, xScale = 1, yScale = 1, y = -320, x = 455 })
    sceneGroup:insert(fondo)

    local title = animacion.crear(uiSettings.title)
    title.x = display.contentCenterX
    title.y = 70
    sceneGroup:insert( title )

    local play = display.newImage(uiSettings.play)
    play.x = display.contentCenterX
    play.y = display.contentCenterY + 20
    play:addEventListener("touch", PlayEvent)
    sceneGroup:insert( play )

    local options = display.newImage(uiSettings.options)
    options.x = display.contentCenterX
    options.y = display.contentCenterY + 70
    options:addEventListener("touch", OptionsEvent)
    sceneGroup:insert( options )

    local book = display.newImage(uiSettings.stickerbookblocked)
    book.x = display.contentCenterX + 170
    book.y = display.contentCenterY + 70
    book:addEventListener("touch", BookEvent)
    sceneGroup:insert( book )
end

function scene:show( event )
    local sceneGroup = self.view
    if event.phase == "did" then
        composer.removeScene( "game" ) 
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
