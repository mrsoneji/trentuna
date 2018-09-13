Hero = {}

local heroSettings = require('heroSettings')
local animacion = require( 'animacion' )
local widget = require( 'widget' )
local sonidos = require('sonidosSettings')

function Hero:new()
    local maxSizeHeroImage = display.newImage(heroSettings.attack.imagen[2])
    maxSizeHeroImage.alpha = 0
    local hero = display.newContainer(maxSizeHeroImage.contentWidth, maxSizeHeroImage.contentHeight + 40)

    hero.hiddleAni = animacion.crear(heroSettings.hiddleAnimation)
    hero.hiddleAni.alpha = 1

    hero.damageAni = display.newImage(heroSettings.damage.imagen)
    hero.damageAni.alpha = 0

    hero.attack1Ani = display.newImage(heroSettings.attack.imagen[1])
    hero.attack1Ani.alpha = 0

    hero.attack2Ani = display.newImage(heroSettings.attack.imagen[2])
    hero.attack2Ani.alpha = 0

    hero.x = display.contentWidth / 2
    hero.y = display.contentHeight / 2

    hero.health = 10

    hero:insert(hero.hiddleAni)
    hero:insert(hero.damageAni)
    hero:insert(hero.attack1Ani)
    hero:insert(hero.attack2Ani)

    hero.energyBar = function()
        local energyBar = widget.newProgressView(
            {
                left = -(maxSizeHeroImage.contentWidth / 2),
                top = -60,
                width = maxSizeHeroImage.contentWidth,
                isAnimated = true
            }
        )
        energyBar:setProgress( 1 )
        return energyBar
    end

    hero.energyBarActive = hero.energyBar()
    hero:insert(hero.energyBarActive)

    hero.hurt = function(obj)
        if (obj ~= nil) then
            local random0or1 = math.floor(math.random()*2)
            if random0or1 == 0 then
                audio.play(sonidos.effects.heroe.hurt1)
            else
                audio.play(sonidos.effects.heroe.hurt2)
            end
            hero.health = hero.health - 1
            hero.energyBarActive:setProgress( 1 / 10 * hero.health )
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
    return hero
end

return Hero
