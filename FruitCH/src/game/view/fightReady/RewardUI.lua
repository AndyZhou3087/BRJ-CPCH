
local BaseUI = require("game.view.BaseUI")
local RewardUI = class("RewardUI",BaseUI)

function RewardUI:ctor(goodId)
    RewardUI.super.ctor(self)
    self.goodId = goodId
    
    --启用onCleanup函数
    self:setNodeEventEnabled(true)
    
    --阴影层
    local bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    
    local effect = display.newSprite("ui/RewardEffect.png"):addTo(self)
    effect:setPosition(cc.p(display.cx,display.cy))
    local rotate = cc.RotateBy:create(0.5,180)
    local repeatR = cc.RepeatForever:create(rotate)
    effect:runAction(repeatR)
    
    local prop = display.newSprite(GoodsConfig[goodId].res):addTo(self)
    prop:setPosition(cc.p(display.cx,display.cy))
    
--    bg:setTouchEnabled(true)
--    bg:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    bg:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return self:touchFunc(event)
    end)

end

function RewardUI:touchFunc(event)
    if event.name == "began" or event.name == "added" then
        self:toClose(true)
        return true
    elseif event.name == "ended" then

    elseif event.name == "removed" then

    elseif event.name == "moved" then

    end
    return true
end

function RewardUI:onCleanup(parameters)
    self:removeNodeEventListenersByEvent(cc.NODE_TOUCH_EVENT)
end

function RewardUI:toClose(_clean)
    self:removeNodeEventListenersByEvent(cc.NODE_TOUCH_EVENT)
    RewardUI.super.toClose(self,_clean)
end

return RewardUI