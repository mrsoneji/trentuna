Ui = {}
local uiSettings = require( 'uiSettings')
local animacion = require( 'animacion')
local sonidos = require( 'sonidosSettings')

Ui.levelLabel = function(actualLevel)
    local levelLabel = display.newImage(uiSettings.getLevel(actualLevel))
    levelLabel.x = display.contentCenterX
    levelLabel.y = display.contentCenterY
    levelLabel.alpha = 1
    audio.play(sonidos.effects.level.init)
    return levelLabel
end

Ui.waveLabel = function(actualWave)
    local waveLabel = animacion.crear(uiSettings.getWave(actualWave))
    waveLabel.x = display.contentCenterX
    waveLabel.y = display.contentCenterY
    waveLabel.alpha = 0
    return waveLabel
end

Ui.exitButton = function()
    local exitButton = display.newImage(uiSettings.exit)
    exitButton.x = display.contentWidth - 25
    exitButton.y = 25
    return exitButton
end

return Ui
