require "assets"
require "utilities"

shaders = require "shaders"

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
    maxRocks = 5,
    initialHealth = 2.0
}

function love.load()
    math.randomseed(os.time())
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
        table.insert(_ROCKS, {x = math.random(0, 1280), y = math.random(0, 800), health = _ROCK_DATA.initialHealth})
        _ROCK_DATA.lastSpawnTime = currentTime
    end
    for idx, rock in ipairs(_ROCKS) do
        rock.collision = checkCollision(
            _DREAMER.x,
            _DREAMER.y,
            _DREAMER.radius,
            rock.x + getAssetRadius("stone"),
            rock.y + getAssetRadius("stone"),
            getAssetRadius("stone")
        )
        if rock.collision then
            rock.health = rock.health - dt
            if rock.health <= 0 then
                table.remove(_ROCKS, idx)
            end
        end
    end
end

function love.draw()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(57, 123, 68))
    for _, rock in ipairs(_ROCKS) do
        if rock.collision then
            love.graphics.setShader(shaders.redRockShader)
        end
        love.graphics.draw(getAssetData("stone"), rock.x, rock.y)
        love.graphics.setShader()
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", _DREAMER.x, _DREAMER.y, _DREAMER.radius)
end