local _gameState = nil

local buttons = {
    {
        text = "Done",
        state = "normal",
        x1 = 565, y1 = 630, x2 = 715, y2 = 670,
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
    love.graphics.printf("Effects Volume", width / 2 - 180, height / 2 - 280, 360, "center")
    love.graphics.printf("Music Volume", width / 2 - 180, height / 2 - 100, 360, "center")
    love.graphics.printf("Fullscreen   ", width / 2 - 180, height / 2 + 80, 400, "center")
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

local function mousereleased(x, y, mouseButton)
    for _, button in pairs(buttons) do
        if button.state == "hovered" and mouseButton == 1 then
            if button.action then
                button.action(_gameState)
            end
        end
    end
end

return {
    load = load,
    update = update,
    draw = draw,
    mousereleased = mousereleased
}