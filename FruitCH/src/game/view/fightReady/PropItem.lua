
local PropItem = class("PropItem",function()
    return display.newNode()
end)

function PropItem:ctor(parameters)
    self.propCon = parameters

    self.propUI = cc.uiloader:load("json/PropItem.json")
    self.propUI:setScale(display.right/GroupSize.width)
    self:addChild(self.propUI)
    self.propUI:setPosition(cc.p(0,0))
    
    self:initPropData()
    
    --启用onCleanup函数
    self:setNodeEventEnabled(true)
    
    self.updateHandler = GameDispatcher:addListener(EventNames.EVENT_PROP_UPDATE,handler(self,self.updateProp))
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
        buy:setButtonImage("disabled","Common/Common_gold_small.png")
    elseif self.propCon.cost.type == COST_TYPE.Diamond then
        buy:setButtonImage("disabled","Common/Common_diamond_small.png")
    end
    pcount:setString(self.propCon.cost.price)
    
    --使用图标
    local useLabel = cc.uiloader:seekNodeByName(self.propUI,"UseBtn")
    useLabel:setTouchSwallowEnabled(false)
    useLabel:setButtonEnabled(false)
    if self.propCon.id~=5 and self.propCon.id~=6 then
        useLabel:setButtonImage("disabled","ui/UseLabel.png")
    else
        useLabel:setButtonImage("disabled","ui/buy_label.png")
    end
    
    self.PropCount = cc.uiloader:seekNodeByName(self.propUI,"PropCount")
    self.PropCount:setVisible(false)
    self.CountLabel = cc.uiloader:seekNodeByName(self.propUI,"CountLabel")
    if GameDataManager.getGoodsNum(self.propCon.id)>0 then
        self.PropCount:setVisible(true)
        self.CountLabel:setString(GameDataManager.getGoodsNum(self.propCon.id))
    end
    
    --使用按钮
    local useBtn = cc.uiloader:seekNodeByName(self.propUI,"Buybtn")
    useBtn:setTouchSwallowEnabled(false)
    useBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        if self.propCon.id~=5 and self.propCon.id~=6 then
            if not self.propCon.isSelect then
                if GameDataManager.getGoodsNum(self.propCon.id)>0 then
                    self.propCon.isSelect = true
                    useLabel:setButtonImage("disabled","ui/CancelLabel.png")
                    Tools.printDebug("----已使用道具",self.propCon.id)
                else
                    if self.propCon.cost.type == COST_TYPE.Gold then
                        if GameDataManager.getGold()>=self.propCon.cost.price then
                            --                        GameDataManager.costGold(self.propCon.cost.price)
                            self.propCon.isSelect = true
                            useLabel:setButtonImage("disabled","ui/CancelLabel.png")
                            Tools.printDebug("----已使用道具",self.propCon.id)
                        else
                            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="金币不足"})
                        end
                    elseif self.propCon.cost.type == COST_TYPE.Diamond then
                        if GameDataManager.getDiamond()>=self.propCon.cost.price then
                            --                        GameDataManager.costDiamond(self.propCon.cost.price)
                            self.propCon.isSelect = true
                            useLabel:setButtonImage("disabled","ui/CancelLabel.png")
                            Tools.printDebug("----已使用道具",self.propCon.id)
                        else
                            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="钻石不足"})
                        end
                    end
                end
            else
                self.propCon.isSelect = false
                useLabel:setButtonImage("disabled","ui/UseLabel.png")
                Tools.printDebug("----已放弃使用道具",self.propCon.id)
            end
        else
            if GameDataManager.getGoodsNum(self.propCon.id)>0 then
                GameDataManager.useGoods(self.propCon.id)
                if self.propCon.id == 5 then
                    --控制随机数种子
                    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
                    local id = math.random(1,4)
                    GameDataManager.addGoods(id,1)
                    GameDispatcher:dispatch(EventNames.EVENT_OPEN_REWARDPROP,id)
                else
                    for var=1, #self.propCon.content do
                        local arr = self.propCon.content[var]
                        GameDataManager.addGoods(arr.id,arr.count)
                    end
                end
            else
                if self.propCon.cost.type == COST_TYPE.Gold then
                    if GameDataManager.getGold()>=self.propCon.cost.price then
                        GameDataManager.costGold(self.propCon.cost.price)
                        if self.propCon.id == 5 then
                            --控制随机数种子
                            math.randomseed(tostring(os.time()):reverse():sub(1, 6))
                            local id = math.random(1,4)
                            GameDataManager.addGoods(id,1)
                            GameDispatcher:dispatch(EventNames.EVENT_OPEN_REWARDPROP,id)
                        else
                            for var=1, #self.propCon.content do
                                local arr = self.propCon.content[var]
                                GameDataManager.addGoods(arr.id,arr.count)
                            end
                        end
                    else
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="金币不足"})
                    end
                elseif self.propCon.cost.type == COST_TYPE.Diamond then
                    if GameDataManager.getDiamond()>=self.propCon.cost.price then
                        GameDataManager.costDiamond(self.propCon.cost.price)
                        if self.propCon.id == 5 then
                            --控制随机数种子
                            math.randomseed(tostring(os.time()):reverse():sub(1, 6))
                            local id = math.random(1,4)
                            GameDataManager.addGoods(id,1)
                            GameDispatcher:dispatch(EventNames.EVENT_OPEN_REWARDPROP,id)
                        else
                            for var=1, #self.propCon.content do
                                local arr = self.propCon.content[var]
                                GameDataManager.addGoods(arr.id,arr.count)
                            end
                        end
                    else
                        GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="钻石不足"})
                    end
                end
            end
        end
    end)
end

function PropItem:updateProp(parameters)
	local id = parameters.data.goodsId
--	Tools.printDebug("-------------道具更新",id)
    if self.propCon.id == id then
		if GameDataManager.getGoodsNum(id)<=0 then
            self.PropCount:setVisible(false)
	    else
            self.PropCount:setVisible(true)
            self.CountLabel:setString(GameDataManager.getGoodsNum(self.propCon.id))
		end
	end
end

function PropItem:onCleanup(parameters)
    GameDispatcher:removeListenerByHandle(self.updateHandler)
end

function PropItem:dispose(_clean)
    GameDispatcher:removeListenerByHandle(self.updateHandler)
    self:removeFromParent(_clean)
end

return PropItem