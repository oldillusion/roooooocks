local _rocks = nil

local _gameState = nil

-- _DREAMER = {
--     x=0,
--     y=0,
--     radius=15
-- }

local function load(gameState, rocks)
    _rocks = rocks
    _gameState = gameState
end

local function update()

end

local function draw()
    love.mouse.setVisible(false)
end

return {
    init = init,
    load = load,
    update = update,
    draw = draw
}