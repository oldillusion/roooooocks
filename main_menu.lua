local buttons = {
    {
        text = "New Game",
        action = "new_game",
        state = "normal",
        enabled = true,
        x1 = 0, y1 = 0, x2 = 0, y2 = 0
    },
    {
        text = "Continue",
        action = "continue",
        state = "normal",
        enabled = false,
        x1 = 0, y1 = 0, x2 = 0, y2 = 0
    },
    {
        text = "Settings",
        action = "settings",
        state = "normal",
        enabled = true,
        x1 = 0, y1 = 0, x2 = 0, y2 = 0
    },
    {
        text = "Exit",
        action = "exit",
        state = "normal",
        enabled = true,
        x1 = 0, y1 = 0, x2 = 0, y2 = 0
    }
}

local _gameState = nil
local _assets = nil

local function load(gameState, assets)
    _gameState = gameState
    _assets = assets
end

local function checkHover(button, x, y)
    if x >= button.x1 and x <= button.x2 and y >= button.y1 and y <= button.y2 then
        return true
    end
    return false
end

local function update()
    local mouseX, mouseY = love.mouse.getPosition()
    for _, button in pairs(buttons) do
        if button.enabled and checkHover(button, mouseX, mouseY) then
            button.state = "hovered"
        else
            button.state = "normal"
        end
    end
end

local function draw()
    local width, height = love.graphics.getDimensions()
    local buttonHeight = 50
    local buttonSpacing = 20
    local startY = (height - (#buttons * buttonHeight + (#buttons - 1) * buttonSpacing)) / 2

    love.graphics.setColor(1, 1, 1, 0.25)
    love.graphics.draw(_assets.getAssetData("menu_bg"), 0, 0)

    for i, button in pairs(buttons) do
        button.x1 = width / 2 - 100
        button.y1 = startY + (tonumber(i) - 1) * (buttonHeight + buttonSpacing)
        button.x2 = button.x1 + 200
        button.y2 = button.y1 + buttonHeight
        if button.state == "hovered" then
            love.graphics.setColor(0.7, 0.7, 0.7)
        elseif not button.enabled then
            love.graphics.setColor(0.4, 0.4, 0.4)
        else
            love.graphics.setColor(1, 1, 1)
        end
        love.graphics.rectangle("line", button.x1, button.y1, 200, buttonHeight)
        love.graphics.printf(
            button.text,
            button.x1,
            button.y1 + buttonHeight / 2 - 12,
            200,
            "center"
        )
    end
end

local function mousereleased(x, y, mouseButton)
    for _, button in pairs(buttons) do
        if button.enabled and mouseButton == 1 and checkHover(button, x, y) then
            if button.action == "new_game" then
                _gameState.currentScene = _SCENE_ENUM.GAME
            elseif button.action == "exit" then
                love.event.quit()
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