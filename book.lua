local composer = require( "composer" )
local widget = require( "widget" )
local json = require( "json" )
local utility = require( "utility" )
local myData = require( "mydata" )
local math = require( "math" )
local sonidos = require("sonidosSettings")
local texto = require("texto")
local bookSettings = require("bookSettings")
local scene = composer.newScene()

local function goBack( event )
    if ( "ended" == event.phase ) then
        audio.stop(sonidos.channels.background)
        composer.removeScene( "book" )
        composer.gotoScene("menu", { effect = "crossFade", time = 333 })
    end
end

function scene:create( event )
    local sceneGroup = self.view
    local backgroundMusic = audio.play(sonidos.loader.stickerBookBackground, {loops = -1 , channel = sonidos.channels.background} )
    local libro = display.newImage("images/book/openbook.png", display.contentCenterX, display.contentCenterY)
    libro.width = display.contentWidth
    libro.height = display.contentHeight
    sceneGroup:insert(libro)
    libro:addEventListener("touch", goBack)

    local titulo = texto.write("Dark Stickers", display.contentCenterX - 100, display.contentCenterY - 120, 300, 30, "black")
    sceneGroup:insert(titulo)

    local nextDarkSticker = 1
    function setToDarkSticker(i)
        nextDarkSticker = i
    end

    local goToDarkSticker = function( event )
        local options = {
            effect = "flip",
            time = 300,
            params = { darkSticker = nextDarkSticker }
        }
        composer.removeScene("book")
        composer.gotoScene( "bookSheet", options)
    end

    for i = 1 , table.getn(bookSettings.darkStickerList) do
        local currentStiker = bookSettings.darkStickerList[i]
        if currentStiker.active == 1 then
            _G["darkSticker_n_".. i] = widget.newButton
            {
                defaultFile = currentStiker.imagen,
                overFile = currentStiker.imagen,
                emboss = true,
                x = currentStiker.x,
                y = currentStiker.y,
                onPress = function() setToDarkSticker(i) end,
                onRelease = goToDarkSticker
            }
            sceneGroup:insert(_G["darkSticker_n_"..i])
        else 
            _G["darkSticker_n_".. i] = widget.newButton
            {
                defaultFile = currentStiker.imagenOscura,
                overFile = currentStiker.imagenOscura,
                emboss = true,
                x = currentStiker.x,
                y = currentStiker.y                
            }
            sceneGroup:insert(_G["darkSticker_n_"..i])
        end
        _G["darkSticker_n_"..i]:scale(currentStiker.xScale, 1)
    end
  

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
