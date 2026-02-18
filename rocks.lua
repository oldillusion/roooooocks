local spawnedRocks = {
}

local rockData = {
    spawnInterval = 1,
    lastSpawnTime = 0,
    maxRocks = 5,
    lifeTime = 0.5
}

local _assets = nil

local _gameState = nil

local function load(gameState, assets)
    _assets = assets
    _gameState = gameState
end

local function getSpawnedRocks()
    return spawnedRocks
end

local function spawnRock()
    table.insert(spawnedRocks, {x = math.random(25, 1265), y = math.random(50, 775), lift = 0})
end

local function updateSpawnedRocks(dt, dreamer)
    local currentTime = love.timer.getTime()
    if #spawnedRocks < rockData.maxRocks and currentTime - rockData.lastSpawnTime >= rockData.spawnInterval then
        spawnRock()
        rockData.lastSpawnTime = currentTime
    end
    if currentTime - rockData.lastSpawnTime >= rockData.spawnInterval and #spawnedRocks < rockData.maxRocks then
        spawnRock()
        rockData.lastSpawnTime = currentTime
    end
    for idx, rock in ipairs(spawnedRocks) do
        rock.collision = checkCollision(
            dreamer.x,
            dreamer.y,
            dreamer.radius,
            rock.x + _assets.getAssetRadius("stone"),
            rock.y + _assets.getAssetRadius("stone"),
            _assets.getAssetRadius("stone")
        )
        if rock.collision then
            rock.lift = rock.lift + dt
            if rock.lift >= rockData.lifeTime then
                table.remove(spawnedRocks, idx)
                _gameState.sessionData.rocksCollected = _gameState.sessionData.rocksCollected + 1
            end
        end
    end
end

return {
    load = load,
    getSpawnedRocks = getSpawnedRocks,
    spawnRock = spawnRock,
    updateSpawnedRocks = updateSpawnedRocks
}