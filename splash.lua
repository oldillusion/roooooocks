local splashData = {
    timer = 0,
    alpha = 0,
    fadein = 3,
    display = 3,
    fadeout = 6
}

local _gameState = nil

local function load(gameState)
    _gameState = gameState
end

local function update(dt)
    splashData.timer = splashData.timer + dt
    if 0 < splashData.timer and splashData.timer < splashData.fadein then 
        splashData.alpha = splashData.timer / splashData.fadein  
    end
    if splashData.fadein < splashData.timer and splashData.timer < splashData.display then 
        splashData.alpha = 1  
    end
    if splashData.display < splashData.timer and splashData.timer < splashData.fadeout then 
        splashData.alpha = 1 - ((splashData.timer - splashData.display) / (splashData.fadeout - splashData.display))
    end
    if splashData.timer > (splashData.fadein + splashData.fadeout - 2) then
        _gameState.currentScene = _SCENE_ENUM.MAIN_MENU
    end

end

local function draw()
    love.graphics.setColor(1, 1, 1, splashData.alpha)
    local width, height = love.graphics.getDimensions()
    love.graphics.printf(
        "old illusion presents",
        width / 2 - 125,
        height / 2 - 12,
        250,
        "center"
    )
end

return {
    load = load,
    update = update,
    draw = draw
}