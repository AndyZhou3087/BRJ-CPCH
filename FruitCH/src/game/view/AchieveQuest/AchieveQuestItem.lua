--[[
成就任务内容
]]
local AchieveQuestItem = class("AchieveQuestItem",function()
    return display.newNode()
end)

function AchieveQuestItem:ctor(parameters)

    self.m_type = parameters.type
    self.m_con = parameters.shopCon

    if self.m_type == SHOPUI_TYPE.PropUI then

    elseif self.m_type == SHOPUI_TYPE.MoneyUI then

    end

end

--道具
function AchieveQuestItem:initProp(parameters)
    local content = cc.uiloader:load("ui/propListItem.json")
    self:addChild(content)
    content:setPosition(cc.p(0,0))
    --图片
    local bottom = cc.uiloader:seekNodeByName(content,"Button_2")
    bottom:setTouchSwallowEnabled(false)
    bottom:setButtonEnabled(false)
    bottom:setButtonImage("disabled",self.m_con.img)
    --文字
    local label = cc.uiloader:seekNodeByName(content,"Button_3")
    label:setTouchSwallowEnabled(false)
    label:setButtonEnabled(false)
    label:setButtonImage("disabled",self.m_con.labelImage)
    --道具功能描述
    local word = cc.uiloader:seekNodeByName(content,"Label_4")
    word:setString(self.m_con.detail)
    word:setWidth(200)
    word:getContentSize()
    --    local _lable = display.newTTFLabel({
    --        text=self.m_con.detail,
    --        size = 20,
    --        color = cc.c3b(139, 36, 19),
    --        align = cc.TEXT_ALIGNMENT_LEFT,
    --    })
    --    _lable:setAnchorPoint(0,0.5)
    --    _lable:setPosition(cc.p(142,73))
    --    content:addChild(_lable)
    --    _lable:getContentSize()
    --购买价格
    local pcount = cc.uiloader:seekNodeByName(content,"AtlasLabel_7")
    pcount:setString(self.m_con.price)
    --购买按钮
    local btnBuy = cc.uiloader:seekNodeByName(content,"Button_5")
    btnBuy:setTouchSwallowEnabled(false)
    btnBuy:onButtonClicked(function(event)
        if GameDataManager.getGoodsNum(self.m_con.id)<999 then
            if GameDataManager.getDiamond()>=self.m_con.price then
                AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Buy_Sound)
                GameDataManager.costDiamond(self.m_con.price)
                GameDataManager.addGoods(self.m_con.id,1)
                GameDataManager.addPoints(self.m_con.price*Diamond_Points)--花费钻石买道具赠送积分
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text="购买成功"})
            else
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_PROPUI,self.m_con)
            end
        else
            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="道具数量已达上限"})
        end
    end)

end

--金币
function AchieveQuestItem:initMoney(parameters)
    local content = cc.uiloader:load("ui/moneyListItem.json")
    self:addChild(content)
    content:setPosition(cc.p(0,0))
    --图片
    local bottom = cc.uiloader:seekNodeByName(content,"Button_12")
    bottom:setTouchSwallowEnabled(false)
    bottom:setButtonEnabled(false)
    bottom:setButtonImage("disabled",self.m_con.image)
    --所得金币
    local count = cc.uiloader:seekNodeByName(content,"AtlasLabel_6")
    count:setString(self.m_con.quantity)
    --购买价格
    local pcount = cc.uiloader:seekNodeByName(content,"AtlasLabel_10")
    pcount:setString(self.m_con.price)
    --购买按钮
    local btnBuy = cc.uiloader:seekNodeByName(content,"Button_7")
    btnBuy:setTouchSwallowEnabled(false)
    btnBuy:onButtonClicked(function(event)
        if GameDataManager.getDiamond()>=self.m_con.price then
            GameDataManager.costDiamond(self.m_con.price)
            GameDataManager.addGold(self.m_con.quantity)
            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
        else
            app:alert({
                type=Alert_Type.Type_Two,
                content="是否花费"..self.m_con.price.."钻购买"..self.m_con.quantity.."金币？",
                okFunc=function(parameters)
                    if GameDataManager.getDiamond()>=self.m_con.price then
                        GameDataManager.costDiamond(self.m_con.price)
                        GameDataManager.addGold(self.m_con.quantity)
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
                    else
                        GameDispatcher:dispatch(EventNames.EVENT_DIAMOND_LESS)
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="钻石不足，请购买钻石"})
                    end
                end,
                cancleFunc=function(parameters)
                end,
                isClose = true
            })
        end
    end)
end

function AchieveQuestItem:onCleanup(parameters)
    
end

function AchieveQuestItem:toClose(_clean)
    self:removeFromParent(_clean)
end

return AchieveQuestItem