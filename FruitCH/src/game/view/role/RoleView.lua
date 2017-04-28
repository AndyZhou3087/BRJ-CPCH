--[[
角色界面
]]
local BaseUI = require("game.view.BaseUI")
local RoleView = class("RoleView",BaseUI)

local CommonUI = require("game.view.Common.CommonUI")
local RoleItem = require("game.view.role.RoleItem")

function RoleView:ctor(parameters)
    RoleView.super.ctor(self)

    local bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    self.m_roleUi = cc.uiloader:load("json/RoleView.json")
    self:addChild(self.m_roleUi)

    local commonui = CommonUI.new():addTo(self)
    commonui:setPosition(cc.p(0,display.top-60))
    
    self.RoleUnActSkill = {GoodsConfig[7],GoodsConfig[8],GoodsConfig[9],GoodsConfig[10]}--,GoodsConfig[11]}
    
    self.m_curRole = GameDataManager.getFightRole() -- 当前出战角色
    
    self.roleCount = self.m_curRole
    
    self:initRole()
    self:LoadRole(self.m_curRole)--角色数据初始化

    --启用监听
    self:setNodeEventEnabled(true)
    
    GameDispatcher:addListener(EventNames.EVENT_ROLE_CHANGEDATA,handler(self,self.changeData))

end

function RoleView:changeData(parameters)
    self:LoadRole(parameters.data)
end

function RoleView:initRole(parameters)
    self.listPandel = cc.uiloader:seekNodeByName(self.m_roleUi,"Panel_5")
    
    local Image_2 = cc.uiloader:seekNodeByName(self.m_roleUi,"Image_2")
    Image_2:setScale(display.right/GroupSize.width)
    self.Panel_role = cc.uiloader:seekNodeByName(self.m_roleUi,"Panel_role")
    self.Panel_role:setScale(display.right/GroupSize.width)
    self.Panel_role:setPositionX(display.right-240*display.right/GroupSize.width)

    --图片
    self.RoleImg = cc.uiloader:seekNodeByName(self.m_roleUi,"RoleImg")
    self.RoleImg:setButtonEnabled(false)
    --等级
    self.RoleLV = cc.uiloader:seekNodeByName(self.m_roleUi,"RoleLV")
    self.RoleName = cc.uiloader:seekNodeByName(self.m_roleUi,"RoleName")--名字
    self.RoleDes = cc.uiloader:seekNodeByName(self.m_roleUi,"RoleDes")--描述
    self.Lock = cc.uiloader:seekNodeByName(self.m_roleUi,"Lock")--是否解锁
    
    self.UpgradeBtn = cc.uiloader:seekNodeByName(self.m_roleUi,"UpgradeBtn")--升级按钮
    self.UpgradeBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        self:updateLevelToBuy(self.m_curRole,self.m_roleLv+1)
    end)
    self.UpgradeType = cc.uiloader:seekNodeByName(self.m_roleUi,"UpgradeType")--升级花费的类型
    self.UpgradeType:setButtonEnabled(false)
    self.UpgradeCount = cc.uiloader:seekNodeByName(self.m_roleUi,"UpgradeCount")--升级需要的钱
    self.MaxgradeBtn = cc.uiloader:seekNodeByName(self.m_roleUi,"MaxgradeBtn")--一键满级
    self.MaxgradeBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        local payId = RoleConfig[self.roleCount].payMaxLvId
        local oId = SDKUtil.getOrderId(payId)
        SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
            if SDKUtil.PayResult.Success == _res then
                self:updateRoleLv(self.roleCount,RoleConfig[self.roleCount].lvMax)
                self:LoadRole(self.roleCount)
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
            else
                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
            end
        end})
    end)
    self.MaxgradeCount = cc.uiloader:seekNodeByName(self.m_roleUi,"Label_20")--一键满级花费
    self.buyPrice = cc.uiloader:seekNodeByName(self.m_roleUi,"Label_13")--购买价格
    
    self.LeftBtn = cc.uiloader:seekNodeByName(self.m_roleUi,"LeftBtn")--左按钮
    self.LeftBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        if self.roleCount>1 then
            self.roleCount = self.roleCount - 1
            self:LoadRole(self.roleCount)
        end
    end)
    self.RightBtn = cc.uiloader:seekNodeByName(self.m_roleUi,"RightBtn")--右按钮
    self.RightBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        if self.roleCount<#RoleConfig then
            self.roleCount = self.roleCount + 1
            self:LoadRole(self.roleCount)
        end
    end)
    
    self.RoleBuy = cc.uiloader:seekNodeByName(self.m_roleUi,"RoleBuy")--购买
    self.RoleBuy:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_GIFTROLE,{giftId = RoleConfig[self.roleCount].giftId,animation = true})
--        local payId = RoleConfig[self.roleCount].payId
--        local oId = SDKUtil.getOrderId(payId)
--        SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
--            if SDKUtil.PayResult.Success == _res then
--                GameDataManager.unLockModle(self.roleCount)
--                self:LoadRole(self.roleCount)
--                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
--            else
--                GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
--            end
--        end})
    end)
    
    for var=1, #RoleConfig do
        self["roleDot"..var] = display.newDrawNode():addTo(self.Panel_role)
        self["roleDot"..var]:drawDot(cc.p((var-1)*48,-30),
            6, cc.c4f(64/255, 20/255, 153/255, 1))
    end
    
    --创建listview
    self.m_listSize = self.listPandel:getCascadeBoundingBox().size
    self.lv = cc.ui.UIListView.new {
        bgScale9 = true,
        viewRect = cc.rect(0, 0, self.m_listSize.width*display.right/GroupSize.width, self.m_listSize.height*display.right/GroupSize.width),
        direction = cc.ui.UIScrollView.DIRECTION_VERTICAL}
        :onTouch(handler(self, self.touchListener))
        :addTo(self.listPandel)
    self.lv:setPosition(cc.p(self.m_listSize.width*(1-display.right/GroupSize.width)*0.5,
        self.m_listSize.height*(1-display.right/GroupSize.width)*0.5))
    
    self.m_skill = {}
    Tools.delayCallFunc(0.01,function()
        for var=1, #self.RoleUnActSkill do
            local item = self.lv:newItem()
            local content = RoleItem.new(self.RoleUnActSkill[var])
            self.m_skill[var] = content
            content:setTouchEnabled(false)
            content:setContentSize(self.m_listSize.width*display.right/GroupSize.width, 85*display.right/GroupSize.width)--*display.right/GroupSize.width
            item:setItemSize(self.m_listSize.width*display.right/GroupSize.width, 85*display.right/GroupSize.width)
            item:addContent(content)
            self.lv:addItem(item)
        end
        self.lv:reload()
    end)
end

function RoleView:LoadRole(id)
    local roleCon = RoleConfig[id]
    if not roleCon then
    	return
    end
    self.m_roleHave = GameDataManager.getRoleModle(id)   --是否拥有当前角色
    if self.m_roleHave then
    	self.Lock:setVisible(false)
        self.UpgradeBtn:setVisible(true)
        self.MaxgradeBtn:setVisible(true)
        self.RoleBuy:setVisible(false)
        GameDataManager.changeRole(id)
--        GameDataManager.setCurFightRole(id)
        self.m_curRole = id
    else
        self.Lock:setVisible(true)
        self.UpgradeBtn:setVisible(false)
        self.MaxgradeBtn:setVisible(false)
        self.RoleBuy:setVisible(true)
    end
    self.RoleImg:setButtonImage("disabled",roleCon.roleImg)
    self.RoleName:setString(roleCon.roleName)
    self.RoleDes:setString(roleCon.roleDes)
    self.MaxgradeCount:setString(roleCon.quickMaxPrice.."元")
    self.buyPrice:setString(roleCon.rmb.."元")
    self.m_roleLv = GameDataManager.getRoleLevel(id)
    
    for var=1, #RoleConfig do
        self["roleDot"..var]:drawDot(cc.p((var-1)*48,-30),
            6, cc.c4f(64/255, 20/255, 153/255, 1))
    end

    self["roleDot"..roleCon.id]:drawDot(cc.p((id-1)*48,-30),
        6, cc.c4f(1, 1, 1, 1))
    
    self:updateRoleLv(id,self.m_roleLv)
end

function RoleView:updateRoleLv(id,level)
    local roleLvCon = RoleLvs[id][level]
    if not roleLvCon then
        self.UpgradeBtn:setVisible(false)
        self.MaxgradeBtn:setVisible(false)
        self.RoleBuy:setVisible(false)
        return
    end
    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Player_Up_Lv)
    if level >= #RoleLvs[id] then
        self.UpgradeBtn:setVisible(false)
        self.MaxgradeBtn:setVisible(false)
        self.RoleBuy:setVisible(false)
    end
    GameDataManager.updateUserLv(id,level)
    if roleLvCon.upgrade.type == UPGRADE_TYPE.Gold then
        self.UpgradeType:setButtonImage("disabled","Common/Common_gold_small.png")
	elseif roleLvCon.upgrade.type == UPGRADE_TYPE.Dimond then
        self.UpgradeType:setButtonImage("disabled","Common/Common_diamond_small.png")
	end
    self.m_roleLv = GameDataManager.getRoleLevel(id)
    local upgradeGoldNum = roleLvCon.upgrade.Num
    if RoleLvs[id][level+1] then
        upgradeGoldNum = RoleLvs[id][level+1].upgrade.Num
    end
    self.UpgradeCount:setString(upgradeGoldNum)
    self.RoleLV:setString("LV."..self.m_roleLv)
    
    Tools.delayCallFunc(0.2,function()
        for var=1, #self.RoleUnActSkill do
            local basic = GameDataManager.getUnActSkillTime(id,level,self.RoleUnActSkill[var].type)
            local total = GameDataManager.getUnActSkillTime(id,#RoleLvs[id],self.RoleUnActSkill[var].type)
            self.m_skill[var]:updateProcess(basic/total)
            self.m_skill[var]:updateData(self.RoleUnActSkill[var])
        end
    end)
end

function RoleView:updateLevelToBuy(id,level)
    Tools.printDebug("-----当前角色和等级：",id,level)
    local roleLvCon = RoleLvs[id][level]
    if not roleLvCon then
        self.UpgradeBtn:setVisible(false)
        self.MaxgradeBtn:setVisible(false)
        self.RoleBuy:setVisible(false)
        return
    end
    if roleLvCon.upgrade.type == UPGRADE_TYPE.Gold then
        if GameDataManager.getGold()>=roleLvCon.upgrade.Num then
            GameDataManager.costGold(roleLvCon.upgrade.Num)
            self:updateRoleLv(id,level)
        else
            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="金币不足"})
        end
    elseif roleLvCon.upgrade.type == UPGRADE_TYPE.Dimond then
        if GameDataManager.getDiamond()>=roleLvCon.upgrade.Num then
            GameDataManager.costDiamond(roleLvCon.upgrade.Num)
            self:updateRoleLv(id,level)
        else
            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="钻石不足"})
        end
    end
end

function RoleView:touchListener(event)
	
end

--关闭界面调用
function RoleView:toClose(_clean)
    RoleView.super.toClose(self,_clean)
end

--清理数据
function RoleView:onCleanup()
    GameDispatcher:removeListenerByName(EventNames.EVENT_ROLE_CHANGEDATA)
    for key, var in pairs(self.m_skill) do
        if not tolua.isnull(var) then
            var:removeFromParent()
        end
    end
    self.m_skill = {}
    self.RoleUnActSkill = {}
    
end

return RoleView