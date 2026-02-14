require "assets"

_DREAMER = {
    x=0,
    y=0
}

_ROCKS = {
    {x=100, y=100},
    {x=200, y=150},
    {x=300, y=200}
}

function love.load()
    loadAssets()
    love.window.setTitle("Rooooocks!")
    -- love.window.setIcon(getAssetData("windowIcon"))
    love.mouse.setVisible(false)
    love.window.setMode(1280, 800, {fullscreen = false, vsync = false})
end

function love.update(dt)
    _DREAMER.x, _DREAMER.y = love.mouse.getPosition()
    print(getAssetData("stone")) -- Print the loaded asset data to the console for verification
end

function love.draw()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(57, 123, 68)) -- Set background color to green
    love.graphics.setColor(1, 1, 1) -- Set color to white
    love.graphics.circle("line", _DREAMER.x, _DREAMER.y, 25) -- Draw a circle at the mouse position
    for _, rock in ipairs(_ROCKS) do
        love.graphics.draw(getAssetData("stone"), rock.x, rock.y) -- Draw the stone asset at each rock position
    end
end