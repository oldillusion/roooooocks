local buttons = {
    {
        text = "New Game",
        action = "new_game",
        state = nil
    },
    {
        text = "Continue",
        action = "continue",
        state = nil
    },
    {
        text = "Settings",
        action = "settings",
        state = nil
    },
    {
        text = "Exit",
        action = "exit",
        state = nil
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
            startY + (tonumber(i) - 1) * (buttonHeight + buttonSpacing) + buttonHeight / 2 - 6,
            200,
            "center"
        )
    end
end

local function mousepressed(x, y, button)
    if button == 1 then
        local width, height = love.graphics.getDimensions()
        local buttonHeight = 50
        local buttonSpacing = 20
        local startY = (height - (#buttons * buttonHeight + (#buttons - 1) * buttonSpacing)) / 2

        for i, btn in pairs(buttons) do
            local btnX = width / 2 - 100
            local btnY = startY + (tonumber(i) - 1) * (buttonHeight + buttonSpacing)
            if x >= btnX and x <= btnX + 200 and y >= btnY and y <= btnY + buttonHeight then
                print("Button clicked: " .. btn.action)

return {
    load = load,
    update = update,
    draw = draw
}