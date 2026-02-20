local _gameState = nil

local buttons = {
    {
        text = "OK",
        state = "normal",
        x1 = 480, y1 = 550, x2 = 630, y2 = 590,
        action = function(gameState)
            -- Save the settings
            gameState.settingsVisible = false
        end
    },
    {
        text = "Cancel",
        state = "normal",
        x1 = 650, y1 = 550, x2 = 800, y2 = 590,
        action = function(gameState)
            gameState.settingsVisible = false
        end
    }
}

local function load(gameState)
    _gameState = gameState
end

local function update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    for _, button in pairs(buttons) do
        if checkHover(button, mouseX, mouseY) then
            button.state = "hovered"
        else
            button.state = "normal"
        end
    end
end

local function checkHover(button, x, y)
    if x >= button.x1 and x <= button.x2 and y >= button.y1 and y <= button.y2 then
        return true
    end
    return false
end

local function draw()
    love.graphics.setColor(0, 0, 0, 0.5)
    local width, height = love.graphics.getDimensions()
    love.graphics.rectangle("fill", 0, 0, width, height)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", width / 2 - 200, height / 2 - 300, 400, 600)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", width / 2 - 200, height / 2 - 300, 400, 600)
    for _, button in pairs(buttons) do
        if button.state == "hovered" then
            love.graphics.setColor(1, 1, 1, 0.5)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
        love.graphics.rectangle("line", button.x1, button.y1, button.x2 - button.x1, button.y2 - button.y1)
        love.graphics.printf(button.text, button.x1, button.y1 + 8, button.x2 - button.x1, "center")
    end
end

local function mouseReleased(x, y, button)
    if button == 1 then
    end
end

return {
    load = load,
    update = update,
    draw = draw
}