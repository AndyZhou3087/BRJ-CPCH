
local PropItem = class("PropItem",function()
    return display.newNode()
end)

function PropItem:ctor(parameters)
    self.propCon = parameters

    self.propUI = cc.uiloader:load("json/PropItem.json")
    self:addChild(self.propUI)
    self.propUI:setPosition(cc.p(-14,0))
    
    self:initPropData()
end

function PropItem:initPropData()
    local PropImg = cc.uiloader:seekNodeByName(self.propUI,"PropImg")
    PropImg:setTouchSwallowEnabled(false)
    PropImg:setButtonEnabled(false)
    PropImg:setButtonImage("disabled",self.propCon.res)
    --道具名称
    local title = cc.uiloader:seekNodeByName(self.propUI,"Title")
    title:setString(self.propCon.discrebe)
    --道具名称
    local word = cc.uiloader:seekNodeByName(self.propUI,"Describe")
    word:setString(self.propCon.msg)
    word:setWidth(230)
    word:getContentSize()
    --购买类型
    local buy = cc.uiloader:seekNodeByName(self.propUI,"Button_19")
    buy:setTouchSwallowEnabled(false)
    buy:setButtonEnabled(false)
    --购买价格
    local pcount = cc.uiloader:seekNodeByName(self.propUI,"Price")
    if self.propCon.cost.type == COST_TYPE.Gold then
        buy:setButtonImage("disabled","Common/Common_gold.png")
--        buy:setSize(cc.size(30,30))
    elseif self.propCon.cost.type == COST_TYPE.Diamond then
        buy:setButtonImage("disabled","Common/Common_diamond.png")
--        buy:setSize(cc.size(33,30))
    end
    pcount:setString(self.propCon.cost.price)
    
    --使用按钮
    local useBtn = cc.uiloader:seekNodeByName(self.propUI,"Buybtn")
    useBtn:setTouchSwallowEnabled(false)
    useBtn:onButtonClicked(function(event)
        if not self.propCon.isSelect then
            if GameDataManager.getGoodsNum(self.propCon.id)>0 then
                self.propCon.isSelect = true
                Tools.printDebug("----已使用道具")
            else
                if self.propCon.cost.type == COST_TYPE.Gold then
                    if GameDataManager.getGold()>=self.propCon.cost.price then
--                        GameDataManager.costGold(self.propCon.cost.price)
                        self.propCon.isSelect = true
                        Tools.printDebug("----已使用道具")
                    else
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="金币不足"})
                    end
                elseif self.propCon.cost.type == COST_TYPE.Diamond then
                    if GameDataManager.getDiamond()>=self.propCon.cost.price then
--                        GameDataManager.costDiamond(self.propCon.cost.price)
                        self.propCon.isSelect = true
                        Tools.printDebug("----已使用道具")
                    else
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="钻石不足"})
                    end
                end
            end
        else
            self.propCon.isSelect = false
            Tools.printDebug("----已放弃使用道具")
        end
    end)
end

function PropItem:onCleanup(parameters)

end

function PropItem:dispose(_clean)
    self:removeFromParent(_clean)
end

return PropItem