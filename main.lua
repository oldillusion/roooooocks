require "utilities"

local assets = require "assets"
local main_menu = require "main_menu"
local shaders = require "shaders"
local rocks = require "rocks"
local game = require "game"

_SCENE_ENUM = {
    MAIN_MENU = 1,
    GAME = 2
}

_GAME_STATE = {
    currentScene = _SCENE_ENUM.MAIN_MENU
}

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Rooooocks!")
    -- TODO: Set the window icon to the stone sprite
    math.randomseed(os.time())
    assets.loadAssets()
    rocks.init(assets)
    game.init(rocks)
    love.graphics.setFont(assets.getAssetData("font"))
    love.window.setMode(1280, 800, {fullscreen = false, vsync = false})
end

function love.update(dt)
    -- _DREAMER.x, _DREAMER.y = love.mouse.getPosition()
    -- local currentTime = love.timer.getTime()
    -- rocks.updateSpawnedRocks(dt)
    if _GAME_STATE.currentScene == _SCENE_ENUM.MAIN_MENU then
        main_menu.update()
    elseif _GAME_STATE.currentScene == _SCENE_ENUM.GAME then
        -- rocks.updateSpawnedRocks(dt)
    end
end

function love.draw()
    -- love.graphics.scale(2, 2)
    if _GAME_STATE.currentScene == _SCENE_ENUM.MAIN_MENU then
        main_menu.draw()
    elseif _GAME_STATE.currentScene == _SCENE_ENUM.GAME then
        -- will get to this
    end
    -- love.graphics.setBackgroundColor(love.math.colorFromBytes(57, 123, 68))
    -- for _, rock in ipairs(rocks.getSpawnedRocks()) do
    --     if rock.collision then
    --         love.graphics.setShader(shaders.redRockShader)
    --     end
    --     love.graphics.draw(assets.getAssetData("stone"), rock.x, rock.y)
    --     love.graphics.setShader()
    -- end
    -- love.graphics.setColor(1, 1, 1)
    -- love.graphics.circle("line", _DREAMER.x, _DREAMER.y, _DREAMER.radius)
end