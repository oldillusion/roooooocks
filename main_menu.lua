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

local function init(gameState)

end

local function load()

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
            if love.mouse.isDown(1) then
                button.state = "clicked"
                if button.action == "new_game" then
                    print("Starting new game...")
                    _GAME_STATE.currentScene = _SCENE_ENUM.GAME
                elseif button.action == "exit" then
                    print("Exiting game...")
                    love.event.quit()
                end
            end
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

return {
    load = load,
    update = update,
    draw = draw
}