local SelectUI = require("game.view.Select.SelectUI")

local SelectScene = class("SelectScene", function()
    return display.newScene("SelectScene")
end)

function SelectScene:ctor()
    self.m_SelectUI = SelectUI.new()
    self:addChild(self.m_SelectUI)
end

function SelectScene:onEnter()
    AudioManager.playGroundMusic(AudioManager.Ground_Music_Type.Main_Bg,true)
    if not tolua.isnull(self.m_SelectUI) then
        self.m_SelectUI:addedToScene()
    end
end

function SelectScene:onExit()
    
end

--场景销毁
function SelectScene:onCleanup()
    GameDataManager.SaveData()
end

return SelectScene
