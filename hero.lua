local Hero = {}
Hero.__index = Hero

local heroSettings = require('heroSettings')
local animacion = require( 'animacion' )
local widget = require( 'widget' )

Hero.hiddleAni = function()
    local animacion = animacion.crear(heroSettings.hiddleAnimation)
    animacion.alpha = 1
    return animacion
end

Hero.energyBar = function(heroAnimado)
    local energyBar = widget.newProgressView(
        {
            left = -(heroAnimado.contentWidth / 2),
            top = -60,
            width = heroAnimado.contentWidth,
            isAnimated = true
        }
    )
    energyBar:setProgress( 1 )
    return energyBar
end

Hero.damageAni = function()
    local damage = display.newImage(heroSettings.damage.imagen)
    damage.alpha = 0
    return damage
end

Hero.attack1Ani = function() 
    local attack = display.newImage(heroSettings.attack.imagen[1])
    attack.alpha = 0
    return attack
end

Hero.attack2Ani = function() 
    local attack = display.newImage(heroSettings.attack.imagen[2])
    attack.alpha = 0
    return attack
end

Hero.spawn = function()
    local hiddleAni = Hero.hiddleAni()
    local attack2Ani = Hero.attack2Ani()
    local heroContainer = display.newContainer(attack2Ani.contentWidth, hiddleAni.contentHeight + 20)
    heroContainer.hiddleAni = hiddleAni
    heroContainer.damageAni = Hero.damageAni(hiddleAni)
    heroContainer.attack1Ani = Hero.attack1Ani()
    heroContainer.attack2Ani = Hero.attack2Ani()
    heroContainer.energyBar = Hero.energyBar(hiddleAni)

    heroContainer.x = display.contentWidth / 2
    heroContainer.y = display.contentHeight / 2
    heroContainer.health = 10
    heroContainer:insert(heroContainer.hiddleAni)
    heroContainer:insert(heroContainer.damageAni)
    heroContainer:insert(heroContainer.attack1Ani)
    heroContainer:insert(heroContainer.attack2Ani)
    heroContainer:insert(heroContainer.energyBar)
    --heroEnergyBar:toFront()
    return heroContainer
end

Hero.hurt = function(obj)
    if (obj ~= nil) then
        hero.health = hero.health - 1
        hero.energyBar:setProgress( 1 / 10 * hero.health )
        hero.damageAni.alpha = 1
        hero.hiddleAni.alpha = 0
        timer.cancel('hurtTimer')
        timer.performWithDelay( 500, function()
            hero.damageAni.alpha = 0
            hero.hiddleAni.alpha = 1
            end, 'hurtTimer' )
        if (hero.health < 5) then
            print ('enemy supposedly dead')
        end
        local angle = math.atan2(obj.y - obj.initialY, obj.x - obj.initialX)
        transition.cancel(obj.transitionId)
        obj.x = obj.x - 125 * math.cos(angle)
        obj.y = obj.y - 125 * math.sin(angle)
        obj.transitionId = transition.to(obj, obj.transitionParams)
    end
end


return Hero
