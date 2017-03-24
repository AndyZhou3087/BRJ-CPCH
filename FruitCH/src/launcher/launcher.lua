package.loaded["launcher.init"] = nil
require("launcher.init")

local function enter_game()
    Launcher.performWithDelayGlobal(function()
        if GAME_RELEASE then
            cc.LuaLoadChunksFromZIP("lib/game.zip")
        end
        require("game.GameApp").new():run()
    end, 0.1)
end

local LauncherScene = lcher_class("LauncherScene", function()
    local scene = cc.Scene:create()
    scene.name = "LauncherScene"
    return scene
end)

function LauncherScene:ctor()
        Launcher.performWithDelayGlobal(function()
            enter_game()
        end, 0.1)
end

local lchr = LauncherScene.new()
Launcher.runWithScene(lchr)