Fondo = {}
function Fondo:new(actualLevelData)
  local fondo = display.newImage(actualLevelData.fondo.imagen)
  fondo.y = actualLevelData.fondo.y
  fondo.x = display.contentCenterX
  fondo.width = display.contentWidth
  return fondo
end
return Fondo
