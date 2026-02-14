function checkCollision(x1, y1, r1, x2, y2, r2)
    -- local dx = x2 - x1
    -- local dy = y2 - y1
    -- local distance = math.sqrt(dx * dx + dy * dy)
    -- return distance < (r1 + r2)
    local dx = x2 - x1
    local dy = y2 - y1
    local distanceSq = dx * dx + dy * dy
    local radiusSum = r1 + r2
    return distanceSq <= radiusSum * radiusSum

end