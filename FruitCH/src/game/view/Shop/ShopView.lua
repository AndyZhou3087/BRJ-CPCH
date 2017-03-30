--[[
商店界面
]]
local BaseUI = require("game.view.BaseUI")
local ShopView = class("ShopView",BaseUI)

local ShopItemUI=require("game.view.Shop.ShopItemUI")
local CommonUI = require("game.view.Common.CommonUI")

function ShopView:ctor(isPause)
    ShopView.super.ctor(self)

    self.m_pause = isPause

    local bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    self.m_shopUi = cc.uiloader:load("json/ShopUI.json")
    self:addChild(self.m_shopUi)
    
    local commonui = CommonUI.new({isShop = true}):addTo(self)
    commonui:setPosition(cc.p(10,display.top-60))
    
    local Image_2 = cc.uiloader:seekNodeByName(self.m_shopUi,"Image_2")
    Image_2:setPositionX(display.cx)
    local Image_3 = cc.uiloader:seekNodeByName(self.m_shopUi,"Image_3")
    Image_3:setPositionX(display.cx)
    local Image_4 = cc.uiloader:seekNodeByName(self.m_shopUi,"Image_4")
    Image_4:setPositionX(display.cx)
    local Image_5 = cc.uiloader:seekNodeByName(self.m_shopUi,"Image_5")
    Image_5:setPositionX(display.cx)

    local listContent = cc.uiloader:seekNodeByName(self.m_shopUi,"Panel_List")
    self.m_listSize = listContent:getCascadeBoundingBox().size
    self.lv = cc.ui.UIListView.new {
        bgScale9 = true,
        viewRect = cc.rect(0, 0, self.m_listSize.width, self.m_listSize.height),
        direction = cc.ui.UIScrollView.DIRECTION_VERTICAL}
        :onTouch(handler(self, self.touchListener))
        :addTo(listContent)

    
    self:initPublic(ShopConfig)
    

    --启用监听
    self:setNodeEventEnabled(true)

end

--加载商店内容
function ShopView:initPublic(shopConfig)

    local bgCount
    if #shopConfig % 4 == 0 then
        bgCount = math.floor(#shopConfig / 4)
    else
        bgCount = math.ceil(#shopConfig / 4)
    end
--    Tools.delayCallFunc(0.1,function()
        for i=1,bgCount do
            local item = self.lv:newItem()
            local content = ShopItemUI.new(i)
            content:setTouchEnabled(false)
            content:setContentSize(self.m_listSize.width, 138)
            item:setItemSize(self.m_listSize.width, 138)
            item:addContent(content)
            self.lv:addItem(item)
        end
        self.lv:reload()
--    end)

end

--ListView中item点击事件
function ShopView:touchListener(event)
--
--    if event.name == "clicked" then
--        if self.m_type == SHOPUI_TYPE.PropUI then
--            if GameDataManager.getGoodsNum(self.BuyGrop[event.itemIdx].id)<999 then
--                if GameDataManager.getDiamond()>=self.BuyGrop[event.itemIdx].price then
--                    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Buy_Sound)
--                    GameDataManager.costDiamond(self.BuyGrop[event.itemIdx].price)
--                    GameDataManager.addGoods(self.BuyGrop[event.itemIdx].id,1)
--                    GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text="购买成功"})
--                else
--                    GameDispatcher:dispatch(EventNames.EVENT_OPEN_PROPUI,self.BuyGrop[event.itemIdx])
--                end
--            else
--                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="道具数量已达上限，无法购买"})
--            end
--        elseif self.m_type == SHOPUI_TYPE.MoneyUI then
--            if GameDataManager.getDiamond()>=Buygold[event.itemIdx].price then
--                GameDataManager.costDiamond(Buygold[event.itemIdx].price)
--                GameDataManager.addGold(Buygold[event.itemIdx].quantity)
--                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
--            else
--                app:alert({
--                    type=Alert_Type.Type_Two,
--                    content="是否花费"..Buygold[event.itemIdx].price.."钻购买"..Buygold[event.itemIdx].quantity.."金币？",
--                    okFunc=function(parameters)
--                        if GameDataManager.getDiamond()>=Buygold[event.itemIdx].price then
--                            GameDataManager.costDiamond(Buygold[event.itemIdx].price)
--                            GameDataManager.addGold(Buygold[event.itemIdx].quantity)
--                            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
--                        else
--                            GameDispatcher:dispatch(EventNames.EVENT_DIAMOND_LESS)
--                            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="钻石不足，请购买钻石"})
--                        end
--                    end,
--                    cancleFunc=function(parameters)
--                    end
--                })
--            end
--        elseif self.m_type == SHOPUI_TYPE.DiamondUI then
--            app:alert({
--                type=Alert_Type.Type_Two,
--                content="是否花费"..Buydiamond[event.itemIdx].price.."元购买"..Buydiamond[event.itemIdx].quantity.."钻石？",
--                okFunc=function(parameters)
--                    local payId = Payment["Diamond_"..event.itemIdx]
--                    local oId = SDKUtil.getOrderId(payId)
--                    SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
--                        if SDKUtil.PayResult.Success == _res then
--                            GameDataManager.addDiamond(Buydiamond[event.itemIdx].quantity)
--                            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
--                        else
--                            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
--                        end
--                    end})
--                end,
--                cancleFunc=function(parameters)
--                end
--            })
--        elseif self.m_type == SHOPUI_TYPE.RoleUI then
--            if event.itemIdx<5 then
--                if not GameDataManager.getRoleModle(RoleConfig[event.itemIdx].id) then
--                    if GameDataManager.getDiamond() >= RoleConfig[RoleConfig[event.itemIdx].id].price.rate then
--                        print("钻石足够",GameDataManager.getDiamond())
--                        GameDataManager.costDiamond(RoleConfig[RoleConfig[event.itemIdx].id].price.rate)
--                        GameDataManager.unLockModle(RoleConfig[event.itemIdx].id)
--                        GameDispatcher:dispatch(EventNames.EVENT_ROLE_SELECT,{isFirst=true,id=RoleConfig[event.itemIdx].id})               
--                    else
--                        GameDispatcher:dispatch(EventNames.EVENT_OPEN_ROLE_MSG,{id=RoleConfig[event.itemIdx].id})
--                    end
--                else
--                    GameDispatcher:dispatch(EventNames.EVENT_OPEN_ROLE_MSG,{id=RoleConfig[event.itemIdx].id})
--                end
--            end
--        elseif self.m_type == SHOPUI_TYPE.PetUI then
--            
--        end
--    end

end

--关闭界面调用
function ShopView:toClose(_clean)
    if GameController.isInPause() and not self.m_pause then
        GameController.resumeGame(true)
    end
    ShopView.super.toClose(self,_clean)
end

--清理数据
function ShopView:onCleanup()
    self.lv:removeAllItems()
end

return ShopView