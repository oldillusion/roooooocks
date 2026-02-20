_SCENE_ENUM = {
    SPLASH = 0,
    MAIN_MENU = 1,
    GAME = 2
}

function checkCollision(x1, y1, r1, x2, y2, r2)
    local dx = x2 - x1
    local dy = y2 - y1
    local distanceSq = dx * dx + dy * dy
    local radiusSum = r1 + r2
    return distanceSq <= radiusSum * radiusSum
end

function checkHover(button, x, y)
    if x >= button.x1 and x <= button.x2 and y >= button.y1 and y <= button.y2 then
        return true
    end
    return false
end