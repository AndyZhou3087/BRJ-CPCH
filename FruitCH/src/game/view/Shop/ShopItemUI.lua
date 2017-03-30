--[[
商店内容
]]
local ShopItemUI = class("ShopItemUI",function()
    return display.newNode()
end)

function ShopItemUI:ctor(shopId)

    --启用onCleanup函数
    self:setNodeEventEnabled(true)

    for var=1, 4 do
        if ShopConfig[(shopId-1)*4+var] then
            self:initContent(ShopConfig[(shopId-1)*4+var],cc.p(-8+220*(var-1),0))
        end
    end

end

--加载商城item
function ShopItemUI:initContent(shopConfig,pos)
    local content = cc.uiloader:load("json/ShopItem.json")
    self:addChild(content)
    content:setPosition(pos)
    --钻石金币
    local panelDG = cc.uiloader:seekNodeByName(content,"Panel_diagold")
    panelDG:setVisible(false)
    --体力
    local panelP = cc.uiloader:seekNodeByName(content,"Panel_power")
    panelP:setVisible(false)
    --钻石购买时的小图标
    local diaImg = cc.uiloader:seekNodeByName(content,"DiamondBuy")
    diaImg:setVisible(false)
    --是否有原价
    local Line2 = cc.uiloader:seekNodeByName(content,"Line2")
    Line2:setVisible(false)
    local initPrice = cc.uiloader:seekNodeByName(content,"InitPrice")
    if shopConfig.initPrice then
        Line2:setVisible(true)
        initPrice:setString("原价:"..shopConfig.initPrice)
    end
    --标题背景
    local ItemFrame = cc.uiloader:seekNodeByName(content,"ItemFrame")
    ItemFrame:setTouchSwallowEnabled(false)
    ItemFrame:setButtonEnabled(false)
    ItemFrame:setButtonImage("disabled",shopConfig.titleBg)
    --标题文字
    local Item_Title = cc.uiloader:seekNodeByName(content,"Item_Title")
    Item_Title:setTouchSwallowEnabled(false)
    Item_Title:setButtonEnabled(false)
    Item_Title:setButtonImage("disabled",shopConfig.titleRes)
    --物品资源
    local ItemImg = cc.uiloader:seekNodeByName(content,"ItemImg")
    ItemImg:setTouchSwallowEnabled(false)
    ItemImg:setButtonEnabled(false)
    ItemImg:setButtonImage("disabled",shopConfig.res)

    --道具功能描述
    local Describe = cc.uiloader:seekNodeByName(content,"Describe")
    Describe:setString(shopConfig.describe)
    Describe:setWidth(116)
    Describe:setHeight(50)
    Describe:getContentSize()

    --购买价格
    local pcount = cc.uiloader:seekNodeByName(content,"PriceLabel")
    if shopConfig.price.type == SHOPITEM_BUY.RMB then
        pcount:setString(shopConfig.price.rate.."元")
    elseif shopConfig.price.type == SHOPITEM_BUY.Diamond then
        diaImg:setVisible(true)
        pcount:setString(shopConfig.price.rate)
    end
    
    --金币或钻石文字
    local LabelDes = cc.uiloader:seekNodeByName(content,"LabelDes")
    local Label_24 = cc.uiloader:seekNodeByName(content,"Label_24")
    --体力文字
    local Label_24_0 = cc.uiloader:seekNodeByName(content,"Label_24_0")
    
    if shopConfig.type == SHOPITEM_TYPE.Gold or shopConfig.type == SHOPITEM_TYPE.Diamond then
        panelDG:setVisible(true)
        Describe:setVisible(false)
        panelP:setVisible(false)
        Label_24:setString(shopConfig.content)
        LabelDes:setString(shopConfig.describe)
    elseif shopConfig.type == SHOPITEM_TYPE.Gift then
        panelDG:setVisible(false)
        panelP:setVisible(false)
        Describe:setVisible(true)
    elseif shopConfig.type == SHOPITEM_TYPE.Power then
        panelDG:setVisible(false)
        Describe:setVisible(false)
        panelP:setVisible(true)
        if shopConfig.content>10000 then
            Label_24_0:setString("无限")
        else
            Label_24_0:setString(shopConfig.content.."点")
        end
    end
    
--    --购买按钮
    local btnBuy = cc.uiloader:seekNodeByName(content,"Button")
    btnBuy:setTouchSwallowEnabled(false)
    btnBuy:onButtonClicked(function(event)
        Tools.printDebug("-----------购买类型:",shopConfig.type)
        if shopConfig.type == SHOPITEM_TYPE.Gold then
        	if shopConfig.price.type == SHOPITEM_BUY.Diamond then
                if GameDataManager.getDiamond() >= shopConfig.price.rate then
                    GameDataManager.costDiamond(shopConfig.price.rate)
                    GameDataManager.addGold(shopConfig.content)
                else
                    GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text="钻石不足"})
        		end
        	end
        elseif shopConfig.type == SHOPITEM_TYPE.Diamond then
            if shopConfig.price.type == SHOPITEM_BUY.RMB then
                local payId = shopConfig.price.payId
                local oId = SDKUtil.getOrderId(payId)
                SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
                    if SDKUtil.PayResult.Success == _res then
                        GameDataManager.addDiamond(shopConfig.content)
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
                    else
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
                    end
                end})
            end
        elseif shopConfig.type == SHOPITEM_TYPE.Gift then
            if shopConfig.price.type == SHOPITEM_BUY.RMB then
                local payId = shopConfig.price.payId
                local oId = SDKUtil.getOrderId(payId)
                SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
                    if SDKUtil.PayResult.Success == _res then
                        if shopConfig.content.gold then
                        	GameDataManager.addGold(shopConfig.content.gold)
                        end
                        if shopConfig.content.diamond then
                            GameDataManager.addDiamond(shopConfig.content.diamond)
                        end
                        if shopConfig.content.prop then
                            for var=1, shopConfig.content.prop do
                                local arr = shopConfig.content.prop[var]
                                GameDataManager.addGoods(arr.id,arr.count)
                            end
                        end
                        if shopConfig.content.role then
                            GameDataManager.unLockModle(shopConfig.content.role.id)
                            --可每日领取奖励
                            
                        end
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
                    else
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
                    end
                end})
            end
        elseif shopConfig.type == SHOPITEM_TYPE.Power then
            if shopConfig.price.type == SHOPITEM_BUY.RMB then
                local payId = shopConfig.price.payId
                local oId = SDKUtil.getOrderId(payId)
                SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
                    if SDKUtil.PayResult.Success == _res then
                        GameDataManager.addPower(shopConfig.content)
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
                    else
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
                    end
                end})
            end
        end
    end)

end


function ShopItemUI:onCleanup(parameters)
end

function ShopItemUI:toClose(_clean)
    self:removeFromParent(_clean)
end

return ShopItemUI