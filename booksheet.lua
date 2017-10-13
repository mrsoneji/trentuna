local composer = require( "composer" )
local widget = require( "widget" )
local json = require( "json" )
local utility = require( "utility" )
local myData = require( "mydata" )
local math = require( "math" )
local animacion = require( "animacion" )
local sonidos = require("sonidosSettings")
local texto = require( "texto" )
local bookSettings = require("bookSettings")
local scene = composer.newScene()

local function goBack( event )
    if ( "ended" == event.phase ) then
        composer.removeScene("bookSheet")
        composer.gotoScene("book", { effect = "flip", time = 333 })
    end
end

function scene:create( event )
    local sceneGroup = self.view
    local currentStiker = bookSettings.darkStickerList[event.params.darkSticker]

    print(event.params.darkSticker)
    local backgroundMusic = audio.play(sonidos.loader.levelBackground[actualLevel], {loops = -1 , channel = sonidos.channels.background} )
    local libro = display.newImage("images/book/openbook.png", display.contentCenterX, display.contentCenterY)
    libro.width = display.contentWidth
    libro.height = display.contentHeight
    sceneGroup:insert(libro)
    libro:addEventListener("touch", goBack)

    local titulo = texto.write(currentStiker.titulo, 180, 50, 300, 35, "darkred")
    sceneGroup:insert(titulo)

    local descripcion = texto.write(currentStiker.descripcion, 150, 120, 200, 15, "black")
    sceneGroup:insert(descripcion)

    local ilustracion = display.newImage(currentStiker.imagenGrande, display.contentCenterX + 130, display.contentCenterY - 10)
    ilustracion:scale(-.8, .8)
    sceneGroup:insert(ilustracion)

end

function scene:show( event )
    local sceneGroup = self.view
    if event.phase == "did" then
    else
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

Runtime:addEventListener( "touch"   , scene )
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
