--[[
裁剪（遮罩）
]]
local BaseUI = require("game.view.BaseUI")
local ClippingView = class("ClippingView",BaseUI)

local Scheduler = require("framework.scheduler")

function ClippingView:ctor()
    ClippingView.super.ctor(self)
    --启用onCleanup函数
    self:setNodeEventEnabled(true)

    --阴影层
    local _mask = display.newColorLayer(cc.c4b(0,0,0,230))

    --遮罩形状(模板)
    self.sprite = display.newSprite("ui/ClipNode.png")
    self.sprite:setScale(6)

    --裁剪节点
    local _clip = cc.ClippingNode:create():addTo(self)
    _clip:setInverted(true)                 --设置高亮区(false为反转)
    _clip:setAlphaThreshold(0.5)            --设置裁剪像素
    _clip:setStencil(self.sprite)
    _clip:addChild(_mask)
    
    self.m_timer = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),0.01)

    --给阴影层加监听
    _mask:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if GameController.isWin or GameController.isDead then
            return
        end
        if GameController.isInState(PLAYER_STATE.StartSprint) or GameController.isInState(PLAYER_STATE.DeadSprint) then
            return
        end
        if event.name == "began" then
            GameController.getCurPlayer():toPlay(PLAYER_ACTION.Jump,0)
            GameController.getCurPlayer():toMove()
            return true
        elseif event.name == "ended" then
        end
    end)

end

function ClippingView:onEnterFrame(parameters)
    --设置坐标
    if tolua.isnull(GameController.getCurPlayer()) then
        if self.m_timer then
            Scheduler.unscheduleGlobal(self.m_timer)
            self.m_timer = nil
        end
        return
    end
    local posX,posY = GameController.getCurPlayer():getPosition()
    self.sprite:setPosition(cc.p(posX+100,posY))
end

function ClippingView:onCleanup(parameters)
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
end

--关闭界面调用
function ClippingView:toClose(_clean)
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
    ClippingView.super.toClose(self,_clean)
end

return ClippingView