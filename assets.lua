local assets = {
    stone = {
        type = "image",
        file = 'simple_stone.png',
        data = nil
    },
    menu_bg = {
        type = "image",
        file = 'menu_back.png',
        data = nil
    },
    font = {
        type = "font",
        file = 'Timeburner-xJB8.ttf',
        size = 24,
        data = nil
    }
}
local basePath = "assets/"

local function loadAssets()
    for key, asset in pairs(assets) do
        if asset.type == "font" then
            assets[key].data = love.graphics.newFont(basePath .. asset.file, asset.size)
        elseif asset.type == "image" then
            assets[key].data = love.graphics.newImage(basePath .. asset.file)
            assets[key].width, assets[key].height = assets[key].data:getDimensions()
            assets[key].data:setFilter("nearest", "nearest") -- Set filter to nearest for pixel art style
        end
    end
end

local function getAssetData(key)
    return assets[key].data
end

local function getAssetRadius(key)
    return math.floor(math.max(assets[key].width, assets[key].height) / 2)
end

return {
    loadAssets = loadAssets,
    getAssetData = getAssetData,
    getAssetRadius = getAssetRadius
}