local MainUI = require("game.view.main.MainUI")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self:initData()
    self.m_mainUI = MainUI.new()
    self:addChild(self.m_mainUI)

end

--数据初始化
function MainScene:initData()
    GameDataManager.init()
    GameDataManager.SaveData()
    TimeUtil.init()
end

function MainScene:onEnter()
    if GameDataManager.isMusicOpen()==false then
        AudioManager.open(1)
    end
    if GameDataManager.isSoundOpen()==false then
        AudioManager.open(2)
    end
    AudioManager.playGroundMusic(AudioManager.Ground_Music_Type.Music_Bg,true)
    if not tolua.isnull(self.m_mainUI) then
        self.m_mainUI:addedToScene()
    end
end

function MainScene:onExit()
end

return MainScene
