--[[
礼包界面
]]
local BaseUI = require("game.view.BaseUI")
local GiftView = class("GiftView",BaseUI)

function GiftView:ctor(parm)
    GiftView.super.ctor(self)
    self.isGmae = parm.isGame
    self._id = parm.giftId
    
    local _mask = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    if parm.isGame then
        GameController.pauseGame(true) --游戏暂停
    end

    local config = GiftConfig[self._id]
    if not config then
    	return
    end

    local GiftView = cc.uiloader:load("json/GiftView.json")
    self:addChild(GiftView)

    local RoleBg = cc.uiloader:seekNodeByName(GiftView,"RoleBg")
    RoleBg:setPositionX(display.cx)
    local roleBgX,roleBgY = RoleBg:getPosition()
    RoleBg:setButtonEnabled(false)
    RoleBg:setButtonImage("disabled",config.bg)
    
    if parm.animation == true then
        self:popupLeft(roleBgX,nil,RoleBg)
    end

    local RoleImg=cc.uiloader:seekNodeByName(GiftView,"RoleImg")
    RoleImg:setButtonEnabled(false)
    RoleImg:setButtonImage("disabled",config.roleImg)
    
    local titleImg=cc.uiloader:seekNodeByName(GiftView,"titleImg")
    titleImg:setButtonEnabled(false)
    titleImg:setButtonImage("disabled",config.titleImg)
    
    local frameImg_1=cc.uiloader:seekNodeByName(GiftView,"frameImg_1")
    frameImg_1:setButtonEnabled(false)
    frameImg_1:setButtonImage("disabled",config.frameImg)
    local frameImg_2=cc.uiloader:seekNodeByName(GiftView,"frameImg_2")
    frameImg_2:setButtonEnabled(false)
    frameImg_2:setButtonImage("disabled",config.frameImg)
    local caseImg_1=cc.uiloader:seekNodeByName(GiftView,"caseImg_1")
    caseImg_1:setButtonEnabled(false)
    caseImg_1:setButtonImage("disabled",config.caseImg)
    local caseImg_2=cc.uiloader:seekNodeByName(GiftView,"caseImg_2")
    caseImg_2:setButtonEnabled(false)
    caseImg_2:setButtonImage("disabled",config.caseImg)
    
    local RoleHead=cc.uiloader:seekNodeByName(GiftView,"RoleHead")
    RoleHead:setButtonEnabled(false)
    RoleHead:setButtonImage("disabled",config.roleHead)
    
    local Reward=cc.uiloader:seekNodeByName(GiftView,"Reward")
    Reward:setButtonEnabled(false)
    Reward:setButtonImage("disabled",config.rewardImg)
    
    local RewardLabel_1=cc.uiloader:seekNodeByName(GiftView,"RewardLabel_1")
    RewardLabel_1:setString(RoleConfig[config.roleId].roleName.."x1")
    
    local RewardLabel_2=cc.uiloader:seekNodeByName(GiftView,"RewardLabel_2")
    if config.reward.diamond then
        RewardLabel_2:setString("钻石x"..config.reward.diamond)
    end
    if config.reward.dayDiamond then
        RewardLabel_2:setString("钻石x"..config.reward.dayDiamond)
    end
    
    local PriceLabel=cc.uiloader:seekNodeByName(GiftView,"PriceLabel")
    if config.reward.diamond then
        PriceLabel:setString("信息费"..config.price.."元")
    end
    if config.reward.dayDiamond then
        PriceLabel:setString("信息费"..config.price.."元,购买后可每日领取钻石x"..config.reward.dayDiamond)
    end
    
    
    local RoleDes=cc.uiloader:seekNodeByName(GiftView,"RoleDes")
    RoleDes:setString(config.roleDes)

    local GetBtn=cc.uiloader:seekNodeByName(GiftView,"GetBtn")
    GetBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        local payId = config.payId
        local oId = SDKUtil.getOrderId(payId)
        SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
            if SDKUtil.PayResult.Success == _res then
                GameDataManager.unLockModle(config.roleId)
                if config.reward.diamond then
                    GameDataManager.addDiamond(config.reward.diamond)
                end
                if config.reward.dayDiamond then
                    GameDataManager.buyGift(self._id)
                end
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
                self:toClose(true)
            else
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
            end
        end})
    end)

    local SureBtn=cc.uiloader:seekNodeByName(GiftView,"SureBtn")
    SureBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        local payId = config.payId
        local oId = SDKUtil.getOrderId(payId)
        SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
            if SDKUtil.PayResult.Success == _res then
                GameDataManager.unLockModle(config.roleId)
                if config.reward.diamond then
                    GameDataManager.addDiamond(config.reward.diamond)
                end
                if config.reward.dayDiamond then
                    GameDataManager.buyGift(self._id)
                end
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
                self:toClose(true)
            else
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
            end
        end})
    end)
    
    local CloseBtn=cc.uiloader:seekNodeByName(GiftView,"CloseBtn")
    CloseBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        self:toClose(true)
    end)
    
    --给阴影层加监听
    _mask:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            local payId = config.payId
            local oId = SDKUtil.getOrderId(payId)
            SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
                if SDKUtil.PayResult.Success == _res then
                    GameDataManager.unLockModle(config.roleId)
                    if config.reward.diamond then
                        GameDataManager.addDiamond(config.reward.diamond)
                    end
                    if config.reward.dayDiamond then
                        GameDataManager.buyGift(self._id)
                    end
                    GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
                    self:toClose(true)
                else
                    GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
                end
            end})
            return true
        elseif event.name == "ended" then
        end
    end)

end

--关闭界面调用
function GiftView:toClose(_clean)
    if self.isGmae then
        GameController.resumeGame(true)
    end
    GiftView.super.toClose(self,true)
end

return GiftView