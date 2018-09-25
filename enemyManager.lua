EnemyManager = {}

local beholder = require('beholder')
require('enemy')

EnemyManager.enemies = display.newGroup()  

function EnemyManager:new(actualLevelData, actualWave, hero, enemies)
    enemy = Enemy:new(actualLevelData, actualWave, hero, enemies)
    if (enemy ~= nil) then EnemyManager.enemies:insert(enemy) end
    return enemy
end

function EnemyManager:reset()
    Enemy:reset()
end

function EnemyManager:enterFrame()
    if (EnemyManager.enemies ~= nil) then
        for i = EnemyManager.enemies.numChildren, 1, -1 do
            currentEnemy = EnemyManager.enemies[i]

            currentEnemy.enterFrame()

            if (currentEnemy.status == "killed") then
                table.remove(EnemyManager.remove, i)
            end 
        end
    end
end

function EnemyManager:handleEnemyLogic(gesture)
    for i = EnemyManager.enemies.numChildren, 1, -1 do
        currentEnemy = EnemyManager.enemies[i]
        if (currentEnemy ~= nil) then
            if (currentEnemy.deathSequence[1] == gesture) then
                if (table.getn(currentEnemy.deathSequence) == 1) then
                    currentEnemy.killed()
                    beholder.trigger("ENEMY_KILLED") 
                else
                    EnemyManager.enemies[i] = currentEnemy.hitted()
                end
            end
        end
    end
    timer.performWithDelay( 1500, function() 
        if (EnemyManager.enemies.numChildren == 0) then 
            beholder.trigger("ENEMIES_KILLED") 
        end
    end)
end

function table.deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= 'table' then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

Runtime:addEventListener( "enterFrame", EnemyManager )

return EnemyManager