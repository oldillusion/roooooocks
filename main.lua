require "utilities"

local assets = require "assets"
local main_menu = require "main_menu"
local shaders = require "shaders"
local rocks = require "rocks"
local game = require "game"
local splash = require "splash"
local settings = require "settings"

local _GAME_STATE = {
    currentScene = _SCENE_ENUM.SPLASH,
    settingsVisible = false,
    sessionData = {
        rocksCollected = 0,
        lucidityCollected = 0,
        insightsCollected = 0,
        restarts = 0,
        rockValue = 1
    }
}

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Rooooocks!")
    -- TODO: Set the window icon to the stone sprite
    math.randomseed(os.time())
    assets.loadAssets()
    rocks.load(_GAME_STATE, assets)
    splash.load(_GAME_STATE)
    main_menu.load(_GAME_STATE, assets, settings)
    game.load(_GAME_STATE, rocks, assets, shaders, settings)
    love.graphics.setFont(assets.getAssetData("font"))
    love.window.setMode(1280, 800, {fullscreen = false, vsync = false})
end

function love.update(dt)
    if _GAME_STATE.currentScene == _SCENE_ENUM.SPLASH then
        splash.update(dt)
    elseif _GAME_STATE.currentScene == _SCENE_ENUM.MAIN_MENU then
        main_menu.update(dt)
    elseif _GAME_STATE.currentScene == _SCENE_ENUM.GAME then
        game.update(dt)
    end
    if _GAME_STATE.settingsVisible then
        settings.update(dt)
    end
end

function love.draw()
    -- love.graphics.scale(2, 2)
    if _GAME_STATE.currentScene == _SCENE_ENUM.SPLASH then
        splash.draw()
    elseif _GAME_STATE.currentScene == _SCENE_ENUM.MAIN_MENU then
        main_menu.draw()
    elseif _GAME_STATE.currentScene == _SCENE_ENUM.GAME then
        game.draw()
    end
    if _GAME_STATE.settingsVisible then
        settings.draw()
    end
end

function love.mousereleased(x, y, button)
    if _GAME_STATE.currentScene == _SCENE_ENUM.MAIN_MENU then
        main_menu.mousereleased(x, y, button)
    elseif _GAME_STATE.currentScene == _SCENE_ENUM.GAME then
        game.mousereleased(x, y, button)
    end
end