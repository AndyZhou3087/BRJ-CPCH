--[[
礼包界面
]]
local BaseUI = require("game.view.BaseUI")
local GiftView = class("GiftView",BaseUI)

function GiftView:ctor(_id)
    GiftView.super.ctor(self)

    local bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
--    GameController.pauseGame() --游戏暂停

    local ReviveUI = cc.uiloader:load("json/ReviveUI.json")
    self:addChild(ReviveUI)

    local Image_1 = cc.uiloader:seekNodeByName(ReviveUI,"Image_1")
    Image_1:setPositionX(display.cx)

    local RoleImg=cc.uiloader:seekNodeByName(ReviveUI,"RoleImg")
    RoleImg:setButtonEnabled(false)
    RoleImg:setButtonImage("disabled",RoleConfig[GameDataManager.getFightRole()].roleRevive)

    local Close=cc.uiloader:seekNodeByName(ReviveUI,"Close")
    Close:onButtonClicked(function(event)
        self:toClose(true)
        --弹结算界面
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_OVER,{type = GAMEOVER_TYPE.Fail})
    end)

    local SureBtn=cc.uiloader:seekNodeByName(ReviveUI,"SureBtn")
    SureBtn:onButtonClicked(function(event)
        local payId = Payment.Revive
        local oId = SDKUtil.getOrderId(payId)
        SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
            if SDKUtil.PayResult.Success == _res then
                self:toClose(true)
                GameDispatcher:dispatch(EventNames.EVENT_ROLE_REVIVE)
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
            else
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
            end
        end})
    end)

    --启用onCleanup函数
    self:setNodeEventEnabled(true)
end

--关闭界面调用
function GiftView:toClose(_clean)
    GiftView.super.toClose(self,true)
end

--清理数据
function GiftView:onCleanup()

end

return GiftView