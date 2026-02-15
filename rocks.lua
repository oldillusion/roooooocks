local spawnedRocks = {
}

local rockData = {
    spawnInterval = 2,
    lastSpawnTime = 0,
    maxRocks = 5,
    initialHealth = 2.0
}

local assetModule = nil

local function init(assets)
    assetModule = assets
end

local function getSpawnedRocks()
    return spawnedRocks
end

local function spawnRock()
    table.insert(spawnedRocks, {x = math.random(0, 1280), y = math.random(0, 800), health = rockData.initialHealth})
end

local function updateSpawnedRocks(dt)
    local currentTime = love.timer.getTime()
    if #spawnedRocks < rockData.maxRocks and currentTime - rockData.lastSpawnTime >= rockData.spawnInterval then
        spawnRock()
        rockData.lastSpawnTime = currentTime
    end
    if currentTime - rockData.lastSpawnTime >= rockData.spawnInterval and #spawnedRocks < rockData.maxRocks then
        table.insert(spawnedRocks, {x = math.random(0, 1280), y = math.random(0, 800), health = rockData.initialHealth})
        rockData.lastSpawnTime = currentTime
    end
    for idx, rock in ipairs(spawnedRocks) do
        rock.collision = checkCollision(
            _DREAMER.x,
            _DREAMER.y,
            _DREAMER.radius,
            rock.x + assetModule.getAssetRadius("stone"),
            rock.y + assetModule.getAssetRadius("stone"),
            assetModule.getAssetRadius("stone")
        )
        if rock.collision then
            rock.health = rock.health - dt
            if rock.health <= 0 then
                table.remove(spawnedRocks, idx)
            end
        end
    end
end

return {
    init = init,
    getSpawnedRocks = getSpawnedRocks,
    spawnRock = spawnRock,
    updateSpawnedRocks = updateSpawnedRocks
}