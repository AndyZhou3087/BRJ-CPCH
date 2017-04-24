--[[
新手引导遮罩
]]
local BaseUI = require("game.view.BaseUI")
local ClipGuideView = class("ClipGuideView",BaseUI)

function ClipGuideView:ctor(parameters)
    ClipGuideView.super.ctor(self)

    --阴影层
    local _mask = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)

    --遮罩形状(模板)
    if parameters.mould ~= nil then
        self.m_mould = display.newSprite(parameters.mould):addTo(self)
    else
        print("not find _mould!")
    end

    local scale1 = cc.ScaleTo:create(1,1.2)
    local scale2 = cc.ScaleTo:create(1,1)
    local seq = cc.Sequence:create(scale1,scale2)
    local repeteFor = cc.RepeatForever:create(seq)
    self.m_mould:runAction(repeteFor)
    

    --裁剪节点
--    local _clip = cc.ClippingNode:create():addTo(self)
--    _clip:setInverted(true)                 --设置高亮区(false为反转)
--    _clip:setAlphaThreshold(0.5)            --设置裁剪像素
--    _clip:setStencil(self.m_mould)
--    _clip:addChild(_mask)

    --设置坐标
    if parameters.pos ~= nil then
        self.m_pos = parameters.pos
        self.m_pos = _mask:convertToNodeSpace(self.m_pos)
        if self.m_mould~=nil then
            self.m_mould:setPosition(self.m_pos)
        end
    end

    --绘制矩形
    local _rectX = self.m_pos.x
    local _rectY = self.m_pos.y
    local _rectW = parameters.width
    local _rectH = parameters.height

    --给阴影层加监听
    _mask:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            return true
        elseif event.name == "ended" then
            if cc.rectContainsPoint(cc.rect(_rectX-_rectW*0.5,_rectY-_rectH*0.5,_rectW,_rectH),cc.p(event.x, event.y)) then
                if parameters.backFunciton ~= nil then
                    parameters.backFunciton()
                end
                self:toClose(true)
            end
            return true
        end
    end)

end
--关闭界面调用
function ClipGuideView:toClose(_clean)
    ClipGuideView.super.toClose(self,_clean)
end

return ClipGuideView