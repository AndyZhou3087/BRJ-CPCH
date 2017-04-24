--[[
新手引导界面
]]
local BaseUI = require("game.view.BaseUI")
local GuideView = class("GuideView",BaseUI)

function GuideView:ctor(parm)
    GuideView.super.ctor(self)


    local _mask = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    GameController.pauseGame()

    local guideBg = display.newSprite("ui/Guide_Tips.png"):addTo(self)
    guideBg:setPosition(cc.p(display.cx,display.cy))
    local roleBgX,roleBgY = guideBg:getPosition()

    if parm.animation == true then
        self:popupLeft(roleBgX,nil,guideBg)
    end

    local function toFunc()
        GameController.resumeGame()
    end

    --给阴影层加监听
    _mask:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            self:closeRight(roleBgX,nil,guideBg,toFunc)
            return true
        elseif event.name == "ended" then
        end
    end)
end

--关闭界面调用
function GuideView:toClose(_clean)
    GuideView.super.toClose(self,true)
end

return GuideView