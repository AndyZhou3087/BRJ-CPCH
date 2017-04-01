--[[
签到内容
]]
local SignItem = class("SignItem",function()
    return display.newNode()
end)

function SignItem:ctor(dayId)

    --启用onCleanup函数
    self:setNodeEventEnabled(true)
    
    self.m_day = dayId
    
    self.content = cc.uiloader:load("json/SignItem.json")
    self:addChild(self.content)
    
    self.signCon = GameDataManager.getReward()[dayId]
    
    self:initSignUI()
end

function SignItem:initSignUI(parameters)
    local Image_11 = cc.uiloader:seekNodeByName(self.content,"Image_11")
    local AtlasLabel_1 = cc.uiloader:seekNodeByName(self.content,"AtlasLabel_1")
    AtlasLabel_1:setVisible(true)
    local AtlasLabel_2 = cc.uiloader:seekNodeByName(self.content,"AtlasLabel_2")
    AtlasLabel_2:setVisible(false)
    local AtlasLabel_3 = cc.uiloader:seekNodeByName(self.content,"AtlasLabel_3")
    AtlasLabel_3:setVisible(false)
    if self.signCon.type == SIGNREWARD_TYPE.Prop then
        AtlasLabel_1:setString(self.signCon.reward.count)
        AtlasLabel_2:setString(self.signCon.reward.count)
    else
        AtlasLabel_1:setString(self.signCon.reward)
        AtlasLabel_2:setString(self.signCon.reward)
    end
    
    local xx = cc.uiloader:seekNodeByName(self.content,"xx")
    xx:setButtonEnabled(false)
    xx:setButtonImage("disabled","Common/x1.png")
	local Signbg = cc.uiloader:seekNodeByName(self.content,"Signbg")
    Signbg:setButtonEnabled(false)
    Signbg:setButtonImage("disabled","ui/Sign_2.png")
    if self.m_day == (GameDataManager.getSignCount()+1) then
        Signbg:setButtonImage("disabled","ui/Sign_3.png")
        xx:setButtonImage("disabled","Common/x2.png")
        AtlasLabel_1:setVisible(false)
        AtlasLabel_2:setVisible(true)
	end
	
    local SignReward = cc.uiloader:seekNodeByName(self.content,"SignReward")
    SignReward:setButtonEnabled(false)
    SignReward:setButtonImage("disabled",self.signCon.res)
    local DayCount = cc.uiloader:seekNodeByName(self.content,"DayCount")
    DayCount:setString(self.m_day)
    
    if self.m_day <= GameDataManager.getSignCount() then
        Signbg:setButtonImage("disabled","ui/Sign_4.png")
        AtlasLabel_1:setVisible(false)
        AtlasLabel_2:setVisible(false)
        AtlasLabel_3:setVisible(true)
        xx:setButtonImage("disabled","Common/x3.png")
        Image_11:setVisible(false)
    end
end

function SignItem:onCleanup(parameters)
end

function SignItem:dispose(_clean)
    self:removeFromParent(_clean)
end

return SignItem