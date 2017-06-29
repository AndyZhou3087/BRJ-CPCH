
local LoadingView = require("game.view.loading.LoadingView")

local LoadScene = class("LoadScene", function()
    return display.newScene("LoadScene")
end)

function LoadScene:ctor()
    self.loading = LoadingView.new({method = 1})
    self:addChild(self.loading)
end

function LoadScene:onEnter()

end

function LoadScene:onExit()
end

--场景销毁
function LoadScene:onCleanup()
    GameDataManager.saveGameData()
end

return LoadScene
