require "assets"
require "utilities"

-- Data on the player chatacter, the "Dreamer"
_DREAMER = {
    x=0,
    y=0,
    radius=15
}

-- Track all the rocks in the game
_ROCKS = {
}

_ROCK_DATA = {
    speed = 100,
    spawnInterval = 2,
    lastSpawnTime = 0,
    maxRocks = 10
}

function love.load()
    loadAssets()
    love.window.setTitle("Rooooocks!")
    -- love.window.setIcon(getAssetData("windowIcon"))
    love.mouse.setVisible(false)
    love.window.setMode(1280, 800, {fullscreen = false, vsync = false})
    _ROCK_DATA.lastSpawnTime = love.timer.getTime()
end

function love.update(dt)
    _DREAMER.x, _DREAMER.y = love.mouse.getPosition()
    local currentTime = love.timer.getTime()
    if currentTime - _ROCK_DATA.lastSpawnTime >= _ROCK_DATA.spawnInterval and #_ROCKS < _ROCK_DATA.maxRocks then
        table.insert(_ROCKS, {x = math.random(0, 1280), y = math.random(0, 800)})
        _ROCK_DATA.lastSpawnTime = currentTime
    end
    for _, rock in ipairs(_ROCKS) do
        rock.collision = checkCollision(_DREAMER.x, _DREAMER.y, _DREAMER.radius, rock.x + getAssetRadius("stone"), rock.y + getAssetRadius("stone"), getAssetRadius("stone"))
    end
end

function love.draw()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(57, 123, 68))
    for _, rock in ipairs(_ROCKS) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(getAssetData("stone"), rock.x, rock.y)
        local radius = getAssetRadius("stone")
        if rock.collision then
            love.graphics.setColor(1, 0, 0)
        else
            love.graphics.setColor(1, 1, 1)
        end
        love.graphics.circle("line", rock.x + radius, rock.y + radius, radius)
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", _DREAMER.x, _DREAMER.y, _DREAMER.radius)
end