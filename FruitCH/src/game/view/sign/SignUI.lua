--[[
签到界面
]]
local BaseUI = require("game.view.BaseUI")
local SignUI = class("SignUI",BaseUI)

local SignItem = require("game.view.sign.SignItem")

function SignUI:ctor(parameters)
    SignUI.super.ctor(self)

    local bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    --加载json
    self.content = cc.uiloader:load("json/SignUI.json")
    self:addChild(self.content)
    
    local Image_2 = cc.uiloader:seekNodeByName(self.content,"Image_2")
    Image_2:setScale(display.right/GroupSize.width)
    Image_2:setPositionX(display.cx)
    
    local getRewardBtn = cc.uiloader:seekNodeByName(self.content,"GetBtn")
    getRewardBtn:setPosition(cc.p(display.cx,display.bottom+50))
    getRewardBtn:onButtonClicked(function(_event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("--------领取奖励")
        self:getReward()
    end)
    
    local CloseBtn = cc.uiloader:seekNodeByName(self.content,"CloseBtn")
    CloseBtn:onButtonClicked(function(_event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        self:toClose(true)
    end)
    
    if GameDataManager.getSignCount()==7 then
        GameDataManager.resetSign()
    end
    local rewardCon = GameDataManager.getReward()
    for var=1, 7 do
        local item = SignItem.new(var):addTo(Image_2)
        item:setPosition(rewardCon[var].pos)
    end
   
end

function SignUI:getReward(parameters)
	local signCon = GameDataManager.getReward()[GameDataManager.getSignCount()+1]
    if signCon.type == SIGNREWARD_TYPE.Gold then
        GameDataManager.addGold(signCon.reward)
    elseif signCon.type == SIGNREWARD_TYPE.Diamond then
        GameDataManager.addDiamond(signCon.reward)
    elseif signCon.type == SIGNREWARD_TYPE.Prop then
        GameDataManager.addGoods(signCon.reward.goodsId,signCon.reward.count)
	end
    GameDataManager.updateSign()
    self:toClose(true)
end


--关闭界面调用
function SignUI:toClose(_clean)
    SignUI.super.toClose(self,_clean)
end

return SignUI