local colors = require("colors")


local texto = {}
texto.__index = texto

texto.write = function (texto, x, y, ancho, size, color)
  local options = 
  {
      text = texto,     
      x = x,
      y = y,
      width = ancho,
      font = "PressGutenberg.ttf", 
      fontSize = size,
      align = "left"
  }

    local result = display.newText(options)
    colorTable = colors.RGB(color)
    result:setTextColor(colorTable[1]/255, colorTable[2]/255, colorTable[3]/255)
    return result
end


return texto