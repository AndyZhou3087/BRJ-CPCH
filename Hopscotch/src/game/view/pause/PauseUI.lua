--[[
暂停界面
]]
local BaseUI = require("game.view.BaseUI")
local PauseUI = class("PauseUI",BaseUI)

function PauseUI:ctor(parameters)
    PauseUI.super.ctor(self)
    
    GameController.pauseGame()
    local bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)

    self.m_json = cc.uiloader:load("json/PauseUI.json")
    self:addChild(self.m_json)

    self.Continue = cc.uiloader:seekNodeByName(self.m_json,"Continue")
    self.Image_1 = cc.uiloader:seekNodeByName(self.m_json,"Image_1")
    self.Continue:onButtonPressed(function(_event)    --按下
        self.Image_1:setPositionY(self.Image_1:getPositionY()-10)
    end)
    self.Continue:onButtonRelease(function(_event)    --触摸离开
        self.Image_1:setPositionY(self.Image_1:getPositionY()+10)
    end)
    self.Continue:onButtonClicked(function (event)
        GameController.resumeGame()
        self:toClose(true)
    end)
    
    self.Restart = cc.uiloader:seekNodeByName(self.m_json,"Restart")
    self.Image_2 = cc.uiloader:seekNodeByName(self.m_json,"Image_2")
    self.Restart:onButtonPressed(function(_event)    --按下
        self.Image_2:setPositionY(self.Image_2:getPositionY()-10)
    end)
    self.Restart:onButtonRelease(function(_event)    --触摸离开
        self.Image_2:setPositionY(self.Image_2:getPositionY()+10)
    end)
    self.Restart:onButtonClicked(function (event)
        GameDataManager.generatePlayerVo()  --产生新的角色数据对象
        GameController.resumeGame()
        app:enterLoadScene()
        Tools.delayCallFunc(0.1,function()
            app:enterGameScene()
        end)
    end)
        
    self.Back = cc.uiloader:seekNodeByName(self.m_json,"Back")
    self.Image_3 = cc.uiloader:seekNodeByName(self.m_json,"Image_3")
    self.Back:onButtonPressed(function(_event)    --按下
        self.Image_3:setPositionY(self.Image_3:getPositionY()-10)
    end)
    self.Back:onButtonRelease(function(_event)    --触摸离开
        self.Image_3:setPositionY(self.Image_3:getPositionY()+10)
    end)
    self.Back:onButtonClicked(function (event)
        GameController.resumeGame()
        app:enterMainScene()
    end)

end


--关闭界面调用
function PauseUI:toClose(_clean)
    PauseUI.super.toClose(self,_clean)
end

return PauseUI