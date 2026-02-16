local _rocks = nil
local _gameState = nil
local _assets = nil
local _shaders = nil

local _dreamer = {
    x = 0,
    y = 0,
    radius = 16
}

local function load(gameState, rocks, assets, shaders)
    _rocks = rocks
    _gameState = gameState
    _assets = assets
    _shaders = shaders
end

local function update(dt)
    _dreamer.x, _dreamer.y = love.mouse.getPosition()
    local currentTime = love.timer.getTime()
    _rocks.updateSpawnedRocks(dt, _dreamer)
end

local function draw()
    love.mouse.setVisible(false)
    love.graphics.setBackgroundColor(love.math.colorFromBytes(57, 123, 68))
    for _, rock in ipairs(_rocks.getSpawnedRocks()) do
        if rock.collision then
            love.graphics.setShader(_shaders.redRockShader)
        end
        love.graphics.draw(_assets.getAssetData("stone"), rock.x, rock.y)
        love.graphics.setShader()
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", _dreamer.x, _dreamer.y, _dreamer.radius)
    love.graphics.print("Rocks collected: " .. _gameState.sessionData.rocksCollected, 10, 10)
    end

return {
    init = init,
    load = load,
    update = update,
    draw = draw
}