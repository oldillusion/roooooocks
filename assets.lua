local assets = {
    stone = {
        file = 'simple_stone.png',
        data = nil
    }
}
local basePath = "assets/"

function loadAssets()
    for key, asset in pairs(assets) do
        assets[key].data = love.graphics.newImage(basePath .. asset.file)
        print(assets[key].data) -- Print the loaded asset data to the console for verification
    end
end

function getAssetData(key)
    return assets[key].data
end