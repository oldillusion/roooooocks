require "assets"

-- Data on the player chatacter, the "Dreamer"
_DREAMER = {
    x=0,
    y=0
}

-- Track all the rocks in the game
_ROCKS = {
}

_ROCK_DATA = {
    speed = 100,
    spawnInterval = 4,
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
end

function love.draw()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(57, 123, 68)) -- Set background color to green
    love.graphics.setColor(1, 1, 1) -- Set color to white
    love.graphics.circle("line", _DREAMER.x, _DREAMER.y, 25) -- Draw a circle at the mouse position
    for _, rock in ipairs(_ROCKS) do
        love.graphics.draw(getAssetData("stone"), rock.x, rock.y) -- Draw the stone asset at each rock position
    end
end