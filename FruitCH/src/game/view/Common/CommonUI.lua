--[[
战斗配置界面
]]
local BaseUI = require("game.view.BaseUI")
local CommonUI = class("FightReadyUI",BaseUI)

local Scheduler = require("framework.scheduler")

function CommonUI:ctor(parm)
    CommonUI.super.ctor(self)
    
    --启用onCleanup函数
    self:setNodeEventEnabled(true)

    self:setScale(display.right/GroupSize.width)

    self.CommonUI = cc.uiloader:load("json/CommonUI.json")
    self:addChild(self.CommonUI)
    
    local backbtn = cc.uiloader:seekNodeByName(self.CommonUI,"Backbtn")
--    backbtn:setPositionX(display.right-60)
    backbtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("-----------返回")
        self:getParent():toClose(true)
    end)
    
    local Image_3 = cc.uiloader:seekNodeByName(self.CommonUI,"Image_3")
--    Image_3:setPositionX(display.right-60-170)
    local Image_2 = cc.uiloader:seekNodeByName(self.CommonUI,"Image_2")
--    Image_2:setPositionX(display.cx+15)
    local Image_1 = cc.uiloader:seekNodeByName(self.CommonUI,"Image_1")
--    Image_1:setPositionX(display.left+190)
    
    local powerbtn = cc.uiloader:seekNodeByName(self.CommonUI,"Powerbtn")
    powerbtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("-----------体力购买")
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP)
    end)
    
    local goldbtn = cc.uiloader:seekNodeByName(self.CommonUI,"Goldbtn")
    goldbtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("-----------金币购买")
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP)
    end)
    
    local diamondbtn = cc.uiloader:seekNodeByName(self.CommonUI,"Diabtn")
    diamondbtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("-----------钻石购买")
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP)
    end)
    
    --若为商城则不显示钻石金币购买按钮
    if parm and parm.isShop then
        powerbtn:setVisible(false)
        goldbtn:setVisible(false)
        diamondbtn:setVisible(false)
    end
    
    self.goldCount = cc.uiloader:seekNodeByName(self.CommonUI,"GoldCount")
    self.goldCount:setString(GameDataManager.getGold())
    
    self.diaCount = cc.uiloader:seekNodeByName(self.CommonUI,"DiaCount")
    self.diaCount:setString(GameDataManager.getDiamond())
    
    self.recoverLab = cc.uiloader:seekNodeByName(self.CommonUI,"recoverLab")
    self.recoverLab:setVisible(false)
    
    for var=1, 5 do
        self["red_"..var] = cc.uiloader:seekNodeByName(self.CommonUI,"red_"..var)
        self["red_"..var]:setVisible(true)
    end
    
    self:showPower()
    
    self.m_timeChange = GameDispatcher:addListener(EventNames.EVENT_NET_TIME_CHANGE,handler(self,self.timeChange))
    GameDispatcher:addListener(EventNames.EVENT_POWER_CHANGE,handler(self,self.powerChanged))
    --金币更新
    GameDispatcher:addListener(EventNames.EVENT_UPDATE_GOLD,handler(self,self.updateGold))
    --钻石更新
    GameDispatcher:addListener(EventNames.EVENT_UPDATE_DIAMOND,handler(self,self.updateDiamond))
end

function CommonUI:updateDiamond(parameters)
    self.diaCount:setString(GameDataManager.getDiamond())
end

function CommonUI:updateGold(parameters)
    self.goldCount:setString(GameDataManager.getGold())
end

function CommonUI:showPower(parameters)
    local powerNow=GameDataManager.getPower()
    Tools.printDebug("00000000 当前体力: ",powerNow)
    if powerNow <= USER_POWER_MAX then
        for var=1, powerNow do
            self["red_"..var]:setVisible(true)
        end
        for var=powerNow+1, 5 do
            self["red_"..var]:setVisible(false)
        end
    end
	self:initPower()
end

--体力改变
function CommonUI:powerChanged(parameters)
    local _power = GameDataManager.getPower()
    Tools.printDebug("------------ 当前体力: ",_power)
    if _power<=USER_POWER_MAX then
        for var=1, _power do
            self["red_"..var]:setVisible(true)
        end
        for var=_power+1, 5 do
            self["red_"..var]:setVisible(false)
        end
    else
        for var=1, 5 do
            self["red_"..var]:setVisible(true)
        end
    end
    if _power < USER_POWER_MAX then
        self:toCheckPower(GameDataManager.getPowerEndTime()-TimeUtil.getTimeStamp())
    else
        if self.m_powerHandle then
            Scheduler.unscheduleGlobal(self.m_powerHandle)
            self.m_powerHandle = nil
        end
        self.recoverLab:setVisible(false)
        if _power > USER_POWER_MAX then
            self.recoverLab:setVisible(true)
            self.recoverLab:setString(_power-USER_POWER_MAX)
            if _power >= 10000 then
                self.recoverLab:setString("10000+")
            end
        end
    end
end

function CommonUI:timeChange(parameters)
    self:initPower()
end

function CommonUI:initPower(parameters)
    if self.m_powerHandle then
        Scheduler.unscheduleGlobal(self.m_powerHandle)
        self.m_powerHandle = nil
    end
    local m_power = GameDataManager.getPower()
    if m_power >= USER_POWER_MAX then
        self.recoverLab:setVisible(false)
        if m_power > USER_POWER_MAX then
            self.recoverLab:setVisible(true)
            self.recoverLab:setString(m_power-USER_POWER_MAX)
            if m_power >= 10000 then
                self.recoverLab:setString("10000+")
            end
        end
        return
    end
    local curTime = TimeUtil.getTimeStamp()
    local powerEndT = GameDataManager.getPowerEndTime()
--    printf("initPower 当前体力= %d ",GameDataManager.getPower())
    if curTime >= powerEndT then
        self.recoverLab:setVisible(false)
        if GameDataManager.getPower() < USER_POWER_MAX then
            local _power = GameDataManager.addPower(USER_POWER_MAX-GameDataManager.getPower())
        end
    else
        local _leftTime = powerEndT-curTime
        local _leftPower = math.ceil(_leftTime/POWER_RECOVER_TIME)
        self.m_powerTime = math.fmod(_leftTime,POWER_RECOVER_TIME)
        if (USER_POWER_MAX-_leftPower) == GameDataManager.getPower() then
            self:toCheckPower(_leftTime)
        else
            GameDataManager.addPower(USER_POWER_MAX-_leftPower-GameDataManager.getPower())
        end
    end
end

function CommonUI:toCheckPower(_recoverTime)
    if (not self.m_powerHandle) and _recoverTime>0 then
        self.m_powerTime = math.fmod(_recoverTime,POWER_RECOVER_TIME)
        if self.m_powerTime == 0 then
            self.m_powerTime = POWER_RECOVER_TIME
        end
        self.recoverLab:setString(string.format("%02d:%02d",self.m_powerTime/60,self.m_powerTime%60))
        self.recoverLab:setVisible(true)
        self.m_powerHandle = Scheduler.scheduleGlobal(handler(self,self.updatePower), 1)
    end
end

function CommonUI:updatePower(parameters)
    self.m_powerTime = self.m_powerTime - 1
    if self.m_powerTime <= 0 then
        self.m_powerTime = 0
        Scheduler.unscheduleGlobal(self.m_powerHandle)
        self.m_powerHandle = nil
        GameDataManager.addPower(1)
    end
    self.recoverLab:setString(string.format("%02d:%02d",self.m_powerTime/60,self.m_powerTime%60))
end

--添加到舞台时调用
function CommonUI:addedToScene()
end

function CommonUI:onCleanup(parameters)
    GameDispatcher:removeListenerByHandle(self.m_timeChange)
    GameDispatcher:removeListenerByName(EventNames.EVENT_POWER_CHANGE)
    GameDispatcher:removeListenerByName(EventNames.EVENT_UPDATE_GOLD)
    GameDispatcher:removeListenerByName(EventNames.EVENT_UPDATE_DIAMOND)

    if self.m_powerHandle then
        Scheduler.unscheduleGlobal(self.m_powerHandle)
        self.m_powerHandle = nil
    end
end

--关闭界面调用
function CommonUI:toClose(_clean)
    GameDispatcher:removeListenerByHandle(self.m_timeChange)
    GameDispatcher:removeListenerByName(EventNames.EVENT_POWER_CHANGE)
    GameDispatcher:removeListenerByName(EventNames.EVENT_UPDATE_GOLD)
    GameDispatcher:removeListenerByName(EventNames.EVENT_UPDATE_DIAMOND)
    
    if self.m_powerHandle then
        Scheduler.unscheduleGlobal(self.m_powerHandle)
        self.m_powerHandle = nil
    end
    CommonUI.super.toClose(self,_clean)
end

return CommonUI