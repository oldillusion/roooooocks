local _rocks = nil
local _gameState = nil
local _assets = nil
local _shaders = nil

local _dreamer = {
    x = 400,
    y = 400,
    radius = 16
}

local buttons = {
    upgrade = {
        action = "upgrade",
        text = "Upgrade...",
        x1 = 300, y1 = 10, x2 = 400, y2 = 40
    },
    settings = {
        action = "settings",
        text = "Settings",
        x1 = 410, y1 = 10, x2 = 510, y2 = 40
    }
}

local displayUpgradePath = false

local function checkHover(button, x, y)
    if x >= button.x1 and x <= button.x2 and y >= button.y1 and y <= button.y2 then
        return true
    end
    return false
end

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
    for _, button in pairs(buttons) do
        if checkHover(button, _dreamer.x, _dreamer.y) then
            button.state = "hovered" -- Not used yet, but could be used to change button appearance
        else
            button.state = "normal"
        end
    end
end

local function draw()
    love.mouse.setVisible(false)
    love.graphics.setBackgroundColor(love.math.colorFromBytes(57, 123, 68))
    for _, rock in ipairs(_rocks.getSpawnedRocks()) do
        love.graphics.setColor(0.25, 0.25, 0.25, 0.5 - rock.lift / 10)
        love.graphics.ellipse("fill", rock.x + _assets.getAssetRadius("stone"), rock.y + _assets.getAssetRadius("stone") * 2, _assets.getAssetRadius("stone"), _assets.getAssetRadius("stone") / 5)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(_assets.getAssetData("stone"), rock.x, rock.y - (rock.lift *rock.lift * 10))
    end
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 1280, 50)
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", _dreamer.x, _dreamer.y, _dreamer.radius)
    love.graphics.print("Rocks collected: " .. _gameState.sessionData.rocksCollected, 10, 10)
    for _, button in pairs(buttons) do
        love.graphics.setColor(1, 1, 1, 0.25)
        love.graphics.rectangle("fill", button.x1, button.y1, button.x2 - button.x1, button.y2 - button.y1)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", button.x1, button.y1, button.x2 - button.x1, button.y2 - button.y1)
        love.graphics.print(button.text, button.x1 + 10, button.y1 + 2)
    end
    if displayUpgradePath then
        love.graphics.setColor(0, 0, 0, 0.65)
        love.graphics.rectangle("fill", 0, 50, 1280, 800)
    end
end

local function mousereleased(x, y, mouseButton)
    for _, button in pairs(buttons) do
        if mouseButton == 1 and checkHover(button, x, y) then
            if button.action == "upgrade" then
                displayUpgradePath = not displayUpgradePath
            elseif button.action == "settings" then
                print("Opening settings...")
            end
        end
    end
end

return {
    init = init,
    load = load,
    update = update,
    draw = draw,
    mousereleased = mousereleased
}