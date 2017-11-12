EnemyManager = {}

require('enemy')

EnemyManager.enemies = display.newGroup()  

function EnemyManager:new(actualLevelData, actualWave, hero, enemies)
    enemy = Enemy:new(actualLevelData, actualWave, hero, enemies)
    EnemyManager.enemies:insert(enemy)
    return enemy
end

function EnemyManager:enterFrame()
    if (EnemyManager.enemies ~= nil) then
        for i = EnemyManager.enemies.numChildren, 1, -1 do
            currentEnemy = EnemyManager.enemies[i]

            for j = currentEnemy.gestures.numChildren, 1, -1 do
                currentEnemy.gestures[j].x = currentEnemy.x
                currentEnemy.gestures[j].y = currentEnemy.y - 65
            end

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
                else
                    EnemyManager.enemies[i] = currentEnemy.hitted()
                end
            end
        end
    end

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