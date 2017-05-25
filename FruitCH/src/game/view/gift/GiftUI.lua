--[[
礼包界面
]]
local BaseUI = require("game.view.BaseUI")
local GiftUI = class("GiftUI",BaseUI)

local GiftUIItem = require("game.view.gift.GiftUIItem")

function GiftUI:ctor(parm)
    GiftUI.super.ctor(self)
    self.isGmae = parm.isGame
    self._id = parm.giftId
    
    local config = GiftConfig[self._id]
    if not config then
        self:toClose(true)
        return
    end

    local _mask = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    if parm.isGame then
        GameController.pauseGame(true) --游戏暂停
    end

    SDKUtil.umentOnEvent(SDKUtil.EventId.GiftPop..self._id)

    local GiftUI = cc.uiloader:load("json/GiftUI.json")
    self:addChild(GiftUI)

    local Image_1 = cc.uiloader:seekNodeByName(GiftUI,"Image_1")
    Image_1:setPositionX(display.cx)
    local roleBgX,roleBgY = Image_1:getPosition()

    if parm.animation == true then
        self:popupLeft(roleBgX,nil,Image_1)
    end

    local Title=cc.uiloader:seekNodeByName(GiftUI,"Title")
    Title:setButtonEnabled(false)
    Title:setButtonImage("disabled",config.title)

    local Label_46=cc.uiloader:seekNodeByName(GiftUI,"Label_46")
    Label_46:setOpacity(63)

    --物品奖励
    if config.type == GIFT_TYPE.Vip then
        Label_46:setString("获得"..config.des.."！信息费"..config.price.."元，需发送1条短信，"..config.price.."元/条（不含通信费）点击即可购买，客服电话：022-59086970")
        local item = GiftUIItem.new({count = config.dayDiamond,res = "gift/ShopDiamond_2.png"}):addTo(Image_1)
        item:setPosition(cc.p(290,105))
    else
        Label_46:setString("您将通过短信购买此礼包。信息费"..config.price.."元/月。退订后次月不计费，奖励停止发放。客服电话022-59086970")
        local count = 0
        local arr = {}
        if config.goods then
            local initCount = count
            count = count + #config.goods
            for var=initCount+1, count do
                local info = config.goods[var-initCount]
                local item = GiftUIItem.new({count = info.count,res = GoodsConfig[info.id].small}):addTo(Image_1)
                arr[#arr+1] = item
--                item:setPosition(cc.p(174+(var-1)*58,105))
            end
        end
        if config.gold then
            count = count + 1
            local item = GiftUIItem.new({count = config.gold,res = "gift/ShopGold_2.png"}):addTo(Image_1)
            arr[#arr+1] = item
--            item:setPosition(cc.p(174+(count-1)*58,105))
        end
        if config.diamond then
            count = count + 1
            local item = GiftUIItem.new({count = config.diamond,res = "gift/ShopDiamond_2.png"}):addTo(Image_1)
            arr[#arr+1] = item
--            item:setPosition(cc.p(174+(count-1)*58,105))
        end
        if count == 1 then
            arr[#arr]:setPosition(cc.p(290,105))
        elseif count > 1 and count <4 then
            for var=1, count do
            	arr[var]:setPosition(cc.p(232+(var-1)*58,105))
            end
        else
            for var=1, count do
                arr[var]:setPosition(cc.p(174+(var-1)*58,105))
            end
        end
    end



    local BuyBtn=cc.uiloader:seekNodeByName(GiftUI,"BuyBtn")
    BuyBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        local payId = config.payId
        if parm.isGame then
            payId = config.payCode
        end
        local oId = SDKUtil.getOrderId(payId)
        SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
            if SDKUtil.PayResult.Success == _res then
                if config.gold then
                    GameDataManager.addGold(config.gold)
                end
                if config.diamond then
                    GameDataManager.addDiamond(config.diamond)
                end
                if config.goods then
                    for var=1, #config.goods do
                        local info = config.goods[var]
                        GameDataManager.addGoods(info.id,info.count)
                	end
                end
                if config.dayDiamond then
                    GameDataManager.buyVipGift(self._id)
                end
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
                SDKUtil.umentOnEvent(SDKUtil.EventId.GiftBuy..self._id)
                self:toClose(true)
            else
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
            end
        end})
    end)
    local BuyGet=cc.uiloader:seekNodeByName(GiftUI,"buyget")
    BuyGet:setButtonEnabled(false) 
    BuyGet:setButtonImage("disabled","ui/Mode_"..GameController.buyOrReceive..".png")


    local CloseBtn=cc.uiloader:seekNodeByName(GiftUI,"Closebtn")
    CloseBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        self:toClose(true)
    end)

    --给阴影层加监听
    local Panel_10 = cc.uiloader:seekNodeByName(GiftUI,"Panel_10")
    Panel_10:setTouchEnabled(true)
    Panel_10:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            local payId = config.payId
            if parm.isGame then
                payId = config.payCode
            end
            local oId = SDKUtil.getOrderId(payId)
            SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
                if SDKUtil.PayResult.Success == _res then
                    if config.gold then
                        GameDataManager.addGold(config.gold)
                    end
                    if config.diamond then
                        GameDataManager.addDiamond(config.diamond)
                    end
                    if config.goods then
                        for var=1, #config.goods do
                            local info = config.goods[var]
                            GameDataManager.addGoods(info.id,info.count)
                        end
                    end
                    if config.dayDiamond then
                        GameDataManager.buyVipGift(self._id)
                    end
                    GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
                    SDKUtil.umentOnEvent(SDKUtil.EventId.GiftBuy..self._id)
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
function GiftUI:toClose(_clean)
    if self.isGmae then
        GameController.resumeGame(true)
    end
    GiftUI.super.toClose(self,true)
end

return GiftUI