
function __G__TRACKBACK__(errorMessage)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end

-- 控制游戏是加载加密包还是原始文件 true加密包 false代码文件
GAME_RELEASE = false

local fileUtils = cc.FileUtils:getInstance()
fileUtils:setPopupNotify(false)
-- 清除fileCached 避免无法加载新的资源。
fileUtils:purgeCachedEntries()

if GAME_RELEASE then
    local udpPath = fileUtils:getWritablePath() .. "upd/";
    fileUtils:addSearchPath(udpPath)
end

fileUtils:addSearchPath("res/")
fileUtils:addSearchPath("src/")  

if GAME_RELEASE then
    cc.LuaLoadChunksFromZIP("lib/launcher.zip")
end

package.loaded["launcher.launcher"] = nil
require("launcher.launcher")
