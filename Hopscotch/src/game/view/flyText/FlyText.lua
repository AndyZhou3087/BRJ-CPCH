--[[
飘字
]]
local BaseUI = require("game.view.BaseUI")
local FlyText = class("FlyText",BaseUI)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

function FlyText:ctor(parameters)
    FlyText.super.ctor(self)

    local successfulLab=display.newTTFLabel({text=parameters.text,size = 42,color=cc.c3b(255,255,255)}):addTo(self,2)
    successfulLab:setPosition(display.cx,display.cy)
    local _textSize = successfulLab:getCascadeBoundingBox().size

    local _flyBg =  display.newSprite("ui/pz_bg.png"):addTo(self)
    _flyBg:setPosition(display.cx,display.cy)

    self.m_handles = Tools.delayCallFunc(0.5,function()
        local spawn=cc.Spawn:create(cc.MoveBy:create(0.3,cc.p(0,20)),cc.FadeOut:create(0.4))
        local seq=cc.Sequence:create(spawn,cc.CallFunc:create(function()
            self:toClose(true)
        end))

        local spawn2=cc.Spawn:create(cc.MoveBy:create(0.3,cc.p(0,20)),cc.FadeOut:create(0.4))
        local seq2=cc.Sequence:create(spawn2,cc.CallFunc:create(function()
            end))
        _flyBg:runAction(seq)
        successfulLab:runAction(seq2)
    end)
    
    --启用onCleanup函数
    self:setNodeEventEnabled(true)
end


--关闭界面调用
function FlyText:toClose(_clean)
    FlyText.super.toClose(self,_clean)
end

--清理数据
function FlyText:onCleanup()
    if self.m_handles then
        scheduler.unscheduleGlobal(self.m_handles)
        self.m_handles  = nil
    end
end

return FlyText