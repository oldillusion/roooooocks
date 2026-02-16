local rocksModule = nil

-- _DREAMER = {
--     x=0,
--     y=0,
--     radius=15
-- }

local function init(rocks)
    rocksModule = rocks
end

local function load()
    love.mouse.setVisible(false)
end

local function update()

end

local function draw()

end

return {
    init = init,
    load = load,
    update = update,
    draw = draw
}