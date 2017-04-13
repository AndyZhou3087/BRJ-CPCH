local SelectUI = require("game.view.Select.SelectUI")

local SelectScene = class("SelectScene", function()
    return display.newScene("SelectScene")
end)

function SelectScene:ctor()
    self.m_SelectUI = SelectUI.new()
    self:addChild(self.m_SelectUI)
end

function SelectScene:onEnter()
    if not tolua.isnull(self.m_SelectUI) then
        self.m_SelectUI:addedToScene()
    end
end

function SelectScene:onExit()

end

return SelectScene
