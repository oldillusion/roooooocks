local buttons = {
    {
        text = "New Game",
        action = "new_game",
        state = "normal",
        x1 = 0,
        y1 = 0,
        x2 = 0,
        y2 = 0
    },
    {
        text = "Continue",
        action = "continue",
        state = "normal",
        x1 = 0,
        y1 = 0,
        x2 = 0,
        y2 = 0
    },
    {
        text = "Settings",
        action = "settings",
        state = "normal",
        x1 = 0,
        y1 = 0,
        x2 = 0,
        y2 = 0
    },
    {
        text = "Exit",
        action = "exit",
        state = "normal",
        x1 = 0,
        y1 = 0,
        x2 = 0,
        y2 = 0
    }
}

local function load()

end

local function update()
    -- check for hovered buttons and update their state
    -- check for clicked buttons and trigger their actions
end

local function draw()
    local width, height = love.graphics.getDimensions()
    local buttonHeight = 50
    local buttonSpacing = 20
    local startY = (height - (#buttons * buttonHeight + (#buttons - 1) * buttonSpacing)) / 2

    for i, button in pairs(buttons) do
        love.graphics.rectangle("line", width / 2 - 100, startY + (tonumber(i) - 1) * (buttonHeight + buttonSpacing), 200, buttonHeight)
        love.graphics.printf(
            button.text,
            width / 2 - 100,
            startY + (tonumber(i) - 1) * (buttonHeight + buttonSpacing) + buttonHeight / 2 - 12,
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