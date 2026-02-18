local _upgrades = {
    first = {
        {
            slug = "rock_value",
            name = "Rock Value",
            description = "Rocks are worth more when collected.",
            level = 0
        },
        {
            slug = "rock_num_max",
            name = "Max Rocks",
            description = "Increase the maximum number of rocks that can be on present.",
            level = 0
        },
        {
            slug = "rock_spawn_rate",
            name = "Rock Spawn Rate",
            description = "Rocks spawn more frequently.",
            level = 0
        }
    },
    second = {},
    third = {}
}

local function draw()
    for row_name, row in pairs(_upgrades) do
        for idx, upgrade in ipairs(row) do
            love.graphics.print(upgrade.name .. " (Level " .. upgrade.level .. ")", 10 + (idx - 1) * 200, 60)
            love.graphics.print(upgrade.description, 10 + (idx - 1) * 200, 80)
        end
    end
end

return {
    draw = draw
}