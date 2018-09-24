local composer = require( "composer" )
local scene = composer.newScene()
local levelsSettings = require("levelsSettings")
local widget = require( "widget" )
local utility = require( "utility" )

local params
local myData = utility.loadSettings()


local function goBack( event )
    if ( "ended" == event.phase ) then
        composer.removeScene( "menu", false )
        composer.gotoScene( "menu", { effect = "crossFade", time = 333 } )
    end
end

local nextLevel = 1
function setNextLevel(i)
    nextLevel = i
end

local goToLevel = function( event )
    if ( "ended" == event.phase ) then
        local options = {
            effect = "crossFade",   
            time = 300,
            params = { levelToPlay = nextLevel }
        }
        composer.removeScene( "levelselect", false )
        composer.gotoScene( "game", options)
    end
end

function scene:create( event )
    local sceneGroup = self.view
    params = event.params
    local mapa = display.newImage("images/mapa/mapa.png", display.contentCenterX, display.contentCenterY)
    mapa.width = display.contentWidth
    mapa.height = display.contentHeight
    sceneGroup:insert(mapa)
    mapa:addEventListener("touch", goBack)

    for i = 1 , table.getn(levelsSettings.levels) do
        levelActive = true
         if i > 1 then
            levelActive = myData.levelDone[i - 1]
        end 
        local item = levelsSettings.levels[i]
        if levelActive then
            _G["level_n_".. i] = widget.newButton
            {
                defaultFile = item.mapItems.imagen,
                emboss = true,
                x = item.mapItems.x,
                y = item.mapItems.y,
                onPress = function() setNextLevel(i) end,
                onRelease = goToLevel
            }
            sceneGroup:insert(_G["level_n_"..i])
        else 
            _G["level_n_".. i] = widget.newButton
            {
                defaultFile = item.mapItems.imagenOscura,
                emboss = true,
                x = item.mapItems.x,
                y = item.mapItems.y
            }
            sceneGroup:insert(_G["level_n_"..i])
        end

        if myData.levelDone[i] then
            _G["level_done_".. i] = display.newImage("images/mapa/hero.png", item.mapItems.x, item.mapItems.y)
            sceneGroup:insert(_G["level_done_".. i])
        end

    end

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
