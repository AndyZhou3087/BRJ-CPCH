--[[
设置界面
]]
local BaseUI = require("game.view.BaseUI")
local SetUI = class("SetUI",BaseUI)

function SetUI:ctor(parameters)
    SetUI.super.ctor(self)

    local bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    
    self.m_json = cc.uiloader:load("json/SetUI.json")
    self:addChild(self.m_json)
    
    
    local img = cc.uiloader:seekNodeByName(self.m_json,"Image_1")
    local BgX,BgY = img:getPosition()
    if parameters.animation == true then
        self:popupLeft(BgX,BgY,img)
    end
    
    self.Button_4 = cc.uiloader:seekNodeByName(self.m_json,"closeBtn")
    self.Button_4:setButtonEnabled(false)
    self.closeBtn = cc.uiloader:seekNodeByName(self.m_json,"Button_4")
    --关闭按钮
    self.closeBtn:onButtonPressed(function(_event)    --按下
        self.Button_4:setButtonImage("disabled","common/close_2.png")
    end)
    self.closeBtn:onButtonRelease(function(_event)    --触摸离开
        self.Button_4:setButtonImage("disabled","common/close_1.png")
    end)
    self.closeBtn:onButtonClicked(function (event)
        if parameters.animation == true then
            self:closeRight(BgX,BgY,img)
        end
    end)
    
    self.Sound = cc.uiloader:seekNodeByName(self.m_json,"Sound")
    self.Sound:onButtonClicked(function (event)
        self:setSound()
    end)
    
    self.eye = cc.uiloader:seekNodeByName(self.m_json,"eye")
    self.eye:onButtonClicked(function (event)
        Tools.printDebug("brj chij 视觉效果")
        if Game_Visible then
            Game_Visible = false
        else
            Game_Visible = true
        end
        GameController.setGameVisible(Game_Visible)
    end)
    
end

function SetUI:setSound()
    if GameDataManager.isMusicOpen() then
        AudioManager.stop()
        Tools.printDebug("音乐关")
        self.Sound:setButtonImage("normal","set/NoSound.png")
        return
    else
        Tools.printDebug("音乐开")
        AudioManager.open()
        self.Sound:setButtonImage("normal","set/music.png")
        return
    end
end


--关闭界面调用
function SetUI:toClose(_clean)
    SetUI.super.toClose(self,_clean)
end

return SetUI