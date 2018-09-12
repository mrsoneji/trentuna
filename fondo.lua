Fondo = {}
function Fondo:new(actualLevelData)
  local fondo = display.newImage(actualLevelData.fondo.imagen)
  fondo.y = actualLevelData.fondo.y
  fondo.x = display.contentCenterX
  fondo.width = display.contentWidth
  fondo.fill.effect = "filter.blurGaussian"
 
  fondo.fill.effect.horizontal.blurSize = 20
  fondo.fill.effect.horizontal.sigma = 140
  fondo.fill.effect.vertical.blurSize = 20
  fondo.fill.effect.vertical.sigma = 140


  return fondo
end
return Fondo
