
local animacion = {}
animacion.__index = animacion

function animacion.crear(aniObjeto)
    local sprite = graphics.newImageSheet(aniObjeto.spriteSheet, {
        width = aniObjeto.width, 
        height = aniObjeto.height, 
        numFrames = aniObjeto.numFrames 
    } )
    local settings = {{ 
        name = aniObjeto.name, 
        start = aniObjeto.start, 
        count = aniObjeto.numFrames, 
        time = aniObjeto.time, 
        loopCount = aniObjeto.loopCount, 
        loopDirection = aniObjeto.loopDirection 
    }}
    local animado = display.newSprite(sprite, settings)
    animado:play()
    return animado
end

return animacion
