--[[
复活界面
]]
local BaseUI = require("game.view.BaseUI")
local ReviveUI = class("ReviveUI",BaseUI)

local Scheduler = require("framework.scheduler")

function ReviveUI:ctor(parm)
    ReviveUI.super.ctor(self)
    
    local bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    GameController.pauseGame() --游戏暂停

    local ReviveUI = cc.uiloader:load("json/ReviveUI.json")
    self:addChild(ReviveUI)

    local Image_1 = cc.uiloader:seekNodeByName(ReviveUI,"Image_1")
    Image_1:setPositionX(display.cx)

    local RoleImg=cc.uiloader:seekNodeByName(ReviveUI,"RoleImg")
    RoleImg:setButtonEnabled(false)
    RoleImg:setButtonImage("disabled",RoleConfig[GameDataManager.getFightRole()].roleRevive)

    local Close=cc.uiloader:seekNodeByName(ReviveUI,"Close")
    Close:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        self:toClose(true)
        --弹结算界面
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_OVER,{type = GAMEOVER_TYPE.Fail})
    end)
    
    local SureBtn=cc.uiloader:seekNodeByName(ReviveUI,"SureBtn")
    SureBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        self:stopTimer()
        local payId = Payment.Revive
        local oId = SDKUtil.getOrderId(payId)
        SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
            if SDKUtil.PayResult.Success == _res then
                self:toClose(true)
                GameDispatcher:dispatch(EventNames.EVENT_ROLE_REVIVE)
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
            else
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
                self:recoverTimer()
            end
        end})
    end)
    
    self.BackCount = cc.uiloader:seekNodeByName(ReviveUI,"BackCount")
    self.BackCount:setButtonEnabled(false)
    self.BackCount:setButtonImage("disabled","ui/Revive_3.png")

    self.count = 3
    self.m_timer = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),1)

    --启用onCleanup函数
    self:setNodeEventEnabled(true)
end

function ReviveUI:onEnterFrame(parameters)
    self.count = self.count - 1
    if self.count > 0 then
        self.BackCount:setButtonImage("disabled","ui/Revive_"..self.count..".png")
    end
    if self.count<=0 then
    	self:toClose(true)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_OVER,{type = GAMEOVER_TYPE.Fail})
    end
end

function ReviveUI:stopTimer(parameters)
    Tools.printDebug("停止倒计时")
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
end

function ReviveUI:recoverTimer(parameters)
    Tools.printDebug("启动倒计时")
    if not self.m_timer then
        self.m_timer = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),1)
    end

end

--关闭界面调用
function ReviveUI:toClose(_clean)
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
    ReviveUI.super.toClose(self,true)
end

--清理数据
function ReviveUI:onCleanup()
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
end

return ReviveUI