local MainUI = require("game.view.main.MainUI")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self:initData()
    self.m_mainUI = MainUI.new()
    self:addChild(self.m_mainUI)
    
--    self:setKeypadEnabled(true)
--    self:addNodeEventListener(cc.KEYPAD_EVENT, function (event)
--        if event.key == "back" then
--            app:alert({
--                type=Alert_Type.Type_Two,
--                content="是否确定要退出游戏？",
--                isClose = true,
--                okFunc=function(parameters)
--                    SDKUtil.exitGame()
--                end
--            })
--        end
--    end)

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
    AudioManager.playGroundMusic(AudioManager.Ground_Music_Type.Main_Bg,true)
    if not tolua.isnull(self.m_mainUI) then
        self.m_mainUI:addedToScene()
    end
end

function MainScene:onExit()
end

return MainScene
