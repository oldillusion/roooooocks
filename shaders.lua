local redRockShader = love.graphics.newShader[[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        vec4 pixel = Texel(texture, texture_coords);
        float gray = (pixel.r + pixel.g + pixel.b) / 3.0;
        return vec4(gray * 1.5, gray * 0.5, gray * 0.5, pixel.a) * color;
    }
]]

return {
    redRockShader = redRockShader
}