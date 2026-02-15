require "utilities"

assets = require "assets"
shaders = require "shaders"
rocks = require "rocks"

-- Data on the player chatacter, the "Dreamer"
_DREAMER = {
    x=0,
    y=0,
    radius=15
}

function love.load()
    math.randomseed(os.time())
    loadAssets()
    love.window.setTitle("Rooooocks!")
    -- TODO: Set the window icon to the stone sprite
    love.mouse.setVisible(false)
    love.window.setMode(1280, 800, {fullscreen = false, vsync = false})
end

function love.update(dt)
    _DREAMER.x, _DREAMER.y = love.mouse.getPosition()
    local currentTime = love.timer.getTime()
    rocks.updateSpawnedRocks(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(57, 123, 68))
    for _, rock in ipairs(rocks.getSpawnedRocks()) do
        if rock.collision then
            love.graphics.setShader(shaders.redRockShader)
        end
        love.graphics.draw(assets.getAssetData("stone"), rock.x, rock.y)
        love.graphics.setShader()
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", _DREAMER.x, _DREAMER.y, _DREAMER.radius)
end