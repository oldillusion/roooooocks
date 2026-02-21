local _gameState = nil
local _assets = nil

local _upgrades = {
    {
        {
            slug = "rock_value",
            name = "Rock Value",
            description = "Rocks are worth more when collected.",
            value = 0,
            max = 5,
            hover = false,
            x1 = 0, y1 = 0, x2 = 0, y2 = 0,
            costs = {10, 50, 150, 1000, 5000},
            action = function(gameState)
                gameState.sessionData.rockValue = gameState.sessionData.rockValue + 1
            end
        },
        {
            slug = "rock_num_max",
            name = "Max Rocks",
            description = "Increase the maximum number of rocks that can be spawned at once.",
            value = 0,
            max = 5,
            hover = false,
            x1 = 0, y1 = 0, x2 = 0, y2 = 0,
            costs = {10, 50, 500, 5000, 25000}
        },
        {
            slug = "rock_spawn_rate",
            name = "Rock Spawn Rate",
            description = "Rocks spawn more frequently.",
            value = 0,
            max = 3,
            hover = false,
            x1 = 0, y1 = 0, x2 = 0, y2 = 0,
            costs = {50, 500, 5000}
        }
    },
    {
        {
            slug = "rock_value_2",
            name = "Rock Value+",
            description = "Rocks are worth more when collected",
            value = 0,
            max = 3,
            hover = false,
            x1 = 0, y1 = 0, x2 = 0, y2 = 0,
            costs = {50000, 250000, 1000000}
        },
        {
            slug = "rock_num_max",
            name = "Max Rocks+",
            description = "Increase the maximum number of rocks that can be on screen",
            value = 0,
            max = 5,
            hover = false,
            x1 = 0, y1 = 0, x2 = 0, y2 = 0,
            costs = {50000, 250000, 1000000, 5000000, 2500000}
        },
        {
            slug = "moving_rocks",
            name = "Moving Rocks",
            description = "Rocks move around sometimes",
            value = 0,
            max = 1,
            hover = false,
            x1 = 0, y1 = 0, x2 = 0, y2 = 0,
            costs = {100000}
        },
        {
            slug = "moving_rocks",
            name = "Moving Rocks",
            description = "Rocks move around sometimes",
            value = 0,
            max = 1,
            hover = false,
            x1 = 0, y1 = 0, x2 = 0, y2 = 0,
            costs = {100000}
        },
    },
    {}
}

local function load(gameState, assets)
    _gameState = gameState
    _assets = assets
end

local function update(dt, _dreamer)
    for row_name, row in pairs(_upgrades) do
        for idx, upgrade in ipairs(row) do
            if checkHover(upgrade, _dreamer.x, _dreamer.y) then
                upgrade.hover = true
            else
                upgrade.hover = false
            end
        end
    end
end

local function draw()
    local row_index = 0
    for row_name, row in pairs(_upgrades) do
        for idx, upgrade in ipairs(row) do
            if upgrade.hover then
                love.graphics.setColor(1, 0.2, 0.2, 0.75)
                love.graphics.printf(upgrade.name .. "\n" .. upgrade.description, 50, 700, 400, "left")
            else
                love.graphics.setColor(1, 0.2, 0.2, 1)
            end
            upgrade.x1 = 50 + row_index * 100
            upgrade.y1 = 100 + (idx - 1) * 100
            upgrade.x2 = upgrade.x1 + 50
            upgrade.y2 = upgrade.y1 + 50
            love.graphics.rectangle("line", upgrade.x1, upgrade.y1, 50, 50)
            for i = 1, upgrade.max do
                if i <= upgrade.value then
                    love.graphics.setColor(1, 0.2, 0.2, 1)
                else
                    love.graphics.setColor(1, 0.2, 0.2, 0.25)
                end 
                love.graphics.rectangle("fill", upgrade.x1 + 5 + (i - 1) * 8, upgrade.y2 - 10, 5, 5)
            end
        end
        row_index = row_index + 1
    end
end

local function mousereleased(x, y, mouseButton)
    for row_name, row in pairs(_upgrades) do
        for idx, upgrade in ipairs(row) do
            if mouseButton == 1 and upgrade.hover then
                if upgrade.value < upgrade.max and _gameState.sessionData.lucidityCollected >= upgrade.costs[upgrade.value + 1] then
                    _gameState.sessionData.lucidityCollected = _gameState.sessionData.lucidityCollected - upgrade.costs[upgrade.value + 1]
                    upgrade.value = upgrade.value + 1
                    if upgrade.action then
                        upgrade.action(_gameState)
                    end
                end
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