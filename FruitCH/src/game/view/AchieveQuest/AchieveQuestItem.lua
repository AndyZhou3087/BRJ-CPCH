--[[
成就任务内容
]]
local AchieveQuestItem = class("AchieveQuestItem",function()
    return display.newNode()
end)

function AchieveQuestItem:ctor(parameters)

    self.m_type = parameters.type
    self.m_con = parameters.config

    self:initCotent(self.m_type)
    
    --启用onCleanup函数
    self:setNodeEventEnabled(true)
    GameDispatcher:addListener(EventNames.EVENT_GET_ACHIEVE,handler(self,self.changeState))
end

--成就任务
function AchieveQuestItem:initCotent(_type)
    local content = cc.uiloader:load("json/QuestAchieveItem.json")
    self:addChild(content)
    content:setPosition(cc.p(0,0))
    --图片
    local img = cc.uiloader:seekNodeByName(content,"img")
    img:setTouchSwallowEnabled(false)
    img:setButtonEnabled(false)
    img:setButtonImage("disabled",self.m_con.res)
    --文字
    local Title = cc.uiloader:seekNodeByName(content,"Title")
    Title:setString(self.m_con.title)
    --道具功能描述
    local Des = cc.uiloader:seekNodeByName(content,"Des")
    Des:setString(self.m_con.des)
    --购买价格
    local RewardImg = cc.uiloader:seekNodeByName(content,"RewardImg")
    RewardImg:setTouchSwallowEnabled(false)
    RewardImg:setButtonEnabled(false)
    local Count = cc.uiloader:seekNodeByName(content,"Count")
    if self.m_con.rewardType == REWARD_TYPE.Gold then
        RewardImg:setButtonImage("disabled","Common/Common_gold.png")
        Count:setString(self.m_con.reward)
    elseif self.m_con.rewardType == REWARD_TYPE.Diamond then
        RewardImg:setButtonImage("disabled","Common/Common_diamond.png")
        Count:setString(self.m_con.reward)
    else
        local id = self.m_con.reward.goodsId
        RewardImg:setButtonImage("disabled",GoodsConfig[id].res)
        Count:setString(self.m_con.reward.count)
    end
    
    --领取按钮
    self.Finished = cc.uiloader:seekNodeByName(content,"Finished")
    self.Finished:setTouchSwallowEnabled(false)
    self.Finished:onButtonClicked(function(event)
        if self.m_con.rewardType == REWARD_TYPE.Gold then
            GameDataManager.addGold(self.m_con.reward)
        elseif self.m_con.rewardType == REWARD_TYPE.Diamond then
            GameDataManager.addDiamond(self.m_con.reward)
        else
            GameDataManager.addGoods(self.m_con.reward.goodsId,self.m_con.reward.count)
        end
        if self.m_type == 1 then
            GameDataManager.setFinishTaskData(self.m_con.id,ACHIEVE_STATE.Receive)
        else
            GameDataManager.setFinishAchieveData(self.m_con.id,ACHIEVE_STATE.Receive)
        end
    end)
    self.Unfinished = cc.uiloader:seekNodeByName(content,"Unfinished")
    if _type == 2 then
        if GameDataManager.getAchieveState(self.m_con.id) == ACHIEVE_STATE.Unfinished then
            self.Unfinished:setVisible(true)
            self.Finished:setVisible(false)
        elseif GameDataManager.getAchieveState(self.m_con.id) == ACHIEVE_STATE.Finished then
            self.Unfinished:setVisible(false)
            self.Finished:setVisible(true)
        else
            self.Unfinished:setVisible(false)
            self.Finished:setVisible(false)
        end
    elseif _type == 1 then
        if GameDataManager.getTaskState(self.m_con.id) == ACHIEVE_STATE.Unfinished then
            self.Unfinished:setVisible(true)
            self.Finished:setVisible(false)
        elseif GameDataManager.getTaskState(self.m_con.id) == ACHIEVE_STATE.Finished then
            self.Unfinished:setVisible(false)
            self.Finished:setVisible(true)
        else
            self.Unfinished:setVisible(false)
            self.Finished:setVisible(false)
        end
    end
    
end

function AchieveQuestItem:changeState(parameters)
    if self.m_con.id == parameters.id then
        if parameters.state == ACHIEVE_STATE.Unfinished then
            self.Unfinished:setVisible(true)
            self.Finished:setVisible(false)
        elseif parameters.state == ACHIEVE_STATE.Finished then
            self.Unfinished:setVisible(false)
            self.Finished:setVisible(true)
        else
            self.Unfinished:setVisible(false)
            self.Finished:setVisible(false)
        end
	end
end

function AchieveQuestItem:onCleanup(parameters)
    GameDispatcher:removeListenerByName(EventNames.EVENT_GET_ACHIEVE)
end

function AchieveQuestItem:toClose(_clean)
    GameDispatcher:removeListenerByName(EventNames.EVENT_GET_ACHIEVE)
    self:removeFromParent(_clean)
end

return AchieveQuestItem