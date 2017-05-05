--[[
战斗配置界面
]]
local BaseUI = require("game.view.BaseUI")
local FightReadyUI = class("FightReadyUI",BaseUI)
local LevelVo = require("game.data.LevelVo")

local CommonUI = require("game.view.Common.CommonUI")
local PropItem = require("game.view.fightReady.PropItem")

function FightReadyUI:ctor(parm)
    FightReadyUI.super.ctor(self)

    --启用监听
    self:setNodeEventEnabled(true)

    self.m_mode = parm
    --阴影层
    local bg = display.newColorLayer(cc.c4b(0,0,0,120)):addTo(self)
    self.m_size_ = bg:getCascadeBoundingBox().size

    self.FightReady = cc.uiloader:load("json/FightReady.json")
    self:addChild(self.FightReady)
    
    local EndlessImg = cc.uiloader:seekNodeByName(self.FightReady,"EndlessImg")
    local LevelImg = cc.uiloader:seekNodeByName(self.FightReady,"LevelImg")
    local LevelCount = cc.uiloader:seekNodeByName(self.FightReady,"AtlasLabel")
    
    local commonui = CommonUI.new():addTo(self)
    commonui:setPosition(cc.p(0,display.top-60))
    
    local _levelCon = 1  --关卡默认值
    if parm == GAME_TYPE.LevelMode then
        EndlessImg:setVisible(false)
        LevelImg:setVisible(true)
        Tools.printDebug("关卡模式")
        --得到当前关卡id与关卡索引
        local _levelId,_levelIdx = GameDataManager.getCurLevelId()
        _levelCon = SelectLevel[_levelId]
        if not _levelCon then
            printf("chjh erro 找不到id=%d的关卡配置数据",_levelId)
            return
        end
        LevelCount:setString(_levelCon._id)
    elseif parm == GAME_TYPE.EndlessMode then
        EndlessImg:setVisible(true)
        LevelImg:setVisible(false)
        Tools.printDebug("无尽模式")
        GameDataManager.resetLevelData()  --重置关卡数据
    else
        Tools.printDebug("readyView no mode!!!")
    end
    
    local Image_19 = cc.uiloader:seekNodeByName(self.FightReady,"Image_19")
    Image_19:setScale(display.right/GroupSize.width)
    local Panel_22 = cc.uiloader:seekNodeByName(self.FightReady,"Panel_22")
    Panel_22:setScale(display.right/GroupSize.width)
    Panel_22:setPositionX(display.right-240*display.right/GroupSize.width)

    local listPanel = cc.uiloader:seekNodeByName(self.FightReady,"Panel_21")
    self.listPanelSize = listPanel:getCascadeBoundingBox().size

    self.listView = cc.ui.UIListView.new {
        bgScale9 = true,
        viewRect = cc.rect(0, 0, self.listPanelSize.width*display.right/GroupSize.width, self.listPanelSize.height*display.right/GroupSize.width),
        direction = cc.ui.UIScrollView.DIRECTION_VERTICAL}
        :onTouch(handler(self, self.touchListener))
        :addTo(listPanel)
    self.listView:setPosition(cc.p(self.listPanelSize.width*(1-display.right/GroupSize.width)*0.5,
        self.listPanelSize.height*(1-display.right/GroupSize.width)*0.5))

    self.m_goods = self:makeGoodsData()
    self:initProp(true)
    
    local rolebtn = cc.uiloader:seekNodeByName(self.FightReady,"Rolebtn")
    rolebtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("-----------角色")
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_ROLEVIEW)
    end)
    self.roleTips = cc.uiloader:seekNodeByName(self.FightReady,"tip1")
    self:checkRoleTip()
    
    local achievebtn = cc.uiloader:seekNodeByName(self.FightReady,"AchieveBtn")
    achievebtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("-----------成就任务")
        GameDispatcher:dispatch(EventNames.EVENT_ACHIEVE_QUEST)
    end)
    self.achTips = cc.uiloader:seekNodeByName(self.FightReady,"tip2")
    self:checkAchieveTip()
    
    local startGame = cc.uiloader:seekNodeByName(self.FightReady,"StartGame")
    startGame:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("-----------开始游戏")
        GameDataManager.generatePlayerVo()  --产生新的角色数据对象
        if parm == GAME_TYPE.LevelMode and GameDataManager.costPower(_levelCon.costPower) then
            for key, var in ipairs(self.m_goods) do
                if var.isSelect then
                    if GameDataManager.getGoodsNum(var.id)<=0 then
                        if var.cost.type == COST_TYPE.Gold then
                            GameDataManager.costGold(var.cost.price)
                        elseif var.cost.type == COST_TYPE.Diamond then
                            GameDataManager.costDiamond(var.cost.price)
                        end
                        GameDataManager.addGoods(var.id,1)
                    end
                    GameController.setStartProp(var.id,var.isSelect)
                end
            end
            GAME_TYPE_CONTROL = GAME_TYPE.LevelMode
            startGame:setButtonEnabled(false)
            app:enterGameScene()
--                self:toClose(true)
            Tools.delayCallFunc(0.01,function()
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_LOAD,{method=2,})
            end)
        elseif parm == GAME_TYPE.EndlessMode and GameDataManager.costPower(EndlessMode.costPower) then      
            GAME_TYPE_CONTROL = GAME_TYPE.EndlessMode
            for key, var in ipairs(self.m_goods) do
                if var.isSelect then
                    if GameDataManager.getGoodsNum(var.id)<=0 then
                        if var.cost.type == COST_TYPE.Gold then
                            GameDataManager.costGold(var.cost.price)
                        elseif var.cost.type == COST_TYPE.Diamond then
                            GameDataManager.costDiamond(var.cost.price)
                        end
                        GameDataManager.addGoods(var.id,1)
                    end
                    GameController.setStartProp(var.id,var.isSelect)
                end           
            end
            startGame:setButtonEnabled(false)
            app:enterGameScene()
--            self:toClose(true)
            Tools.delayCallFunc(0.01,function()
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_LOAD,{method=2,})
            end)
        else
            Tools.printDebug("体力不足！！",parm == GAME_TYPE.EndlessMode and GameDataManager.costPower(EndlessMode.costPower))
            startGame:setButtonEnabled(true)
            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="体力不足"})
--            GameDispatcher:dispatch(EventNames.EVENT_OPEN_POWER,{})
        end
    end)
    
    self.roleImg = cc.uiloader:seekNodeByName(self.FightReady,"RoleImg")
    self.roleImg:onButtonClicked(function(event)
        if not GameDataManager.getRoleModle(GiftConfig[4].roleId) then
            GameDispatcher:dispatch(EventNames.EVENT_OPEN_GIFTROLE,{giftId = 4,animation = true})
        end
    end)
    self.QuestPrice = cc.uiloader:seekNodeByName(self.FightReady,"QuestPrice")
    self.QuestPrice:setString(RoleConfig[5].rmb.."元")
--    self.roleImg:setButtonEnabled(false)
--    self.roleImg:setButtonImage("disabled",RoleConfig[GameDataManager.getFightRole()].roleImg)
    
    self.GoldLabel = cc.uiloader:seekNodeByName(self.FightReady,"GoldLabel")
    self.GoldLabel:setString("+ "..GameDataManager.getMoneyRate(5,GameDataManager.getRoleLevel(5)).."%")
    self.AbilityLabel = cc.uiloader:seekNodeByName(self.FightReady,"AbilityLabel")
    self.AbilityLabel:setString("+ "..GameDataManager.getScoreRate(5,GameDataManager.getRoleLevel(5)).."%")
    
    GameDispatcher:dispatch(EventNames.EVENT_LOADING_OVER)
    
    GameDispatcher:addListener(EventNames.EVENT_ACHIEVE_UPDATE,handler(self,self.checkAchieveTip))
    GameDispatcher:addListener(EventNames.EVENT_ROLEUPGRADE_UPDATE,handler(self,self.checkRoleTip))

    --弹角色礼包
    Tools.delayCallFunc(0.1,function()
        if not GameDataManager.getRoleModle(GiftConfig[2].roleId) then
            GameDispatcher:dispatch(EventNames.EVENT_OPEN_GIFTROLE,{giftId = 2,animation = true})
        elseif not GameDataManager.getRoleModle(GiftConfig[3].roleId) then
            GameDispatcher:dispatch(EventNames.EVENT_OPEN_GIFTROLE,{giftId = 3,animation = true})
        elseif not GameDataManager.getRoleModle(GiftConfig[4].roleId) then
            GameDispatcher:dispatch(EventNames.EVENT_OPEN_GIFTROLE,{giftId = 4,animation = true})
        end
    end)
end

function FightReadyUI:checkRoleTip()
    self.roleTips:setVisible(false)
	local roleLv = GameDataManager.getRoleLevel(GameDataManager.getFightRole())
    if roleLv < #RoleLvs[GameDataManager.getFightRole()] then
        local Num = RoleLvs[GameDataManager.getFightRole()][roleLv+1].upgrade.Num
        local typ = RoleLvs[GameDataManager.getFightRole()][roleLv+1].upgrade.type
        if typ == UPGRADE_TYPE.Gold then
            if GameDataManager.getGold()>=Num then
                self.roleTips:setVisible(true)
            end
        elseif typ == UPGRADE_TYPE.Dimond then
            if GameDataManager.getDiamond()>=Num then
                self.roleTips:setVisible(true)
            end
        end
    end
end

function FightReadyUI:checkAchieveTip()
	if GameDataManager.isHaveReciveState() then
        self.achTips:setVisible(true)
    else
        self.achTips:setVisible(false)
    end
end

function FightReadyUI:touchListener(event)
	
end

function FightReadyUI:changeRole(parameters)
--    self.roleImg:setButtonImage("disabled",RoleConfig[GameDataManager.getFightRole()].roleImg)
    self.GoldLabel:setString("+ "..GameDataManager.getMoneyRate(5,
        GameDataManager.getRoleLevel(5)).."%")
    self.AbilityLabel:setString("+ "..GameDataManager.getScoreRate(5,
        GameDataManager.getRoleLevel(5)).."%")
end

function FightReadyUI:initProp(par)
    self.m_maxNum = #self.m_goods
    if self.m_maxNum > 5 then
        self.m_maxNum = 5
    end

    self.listView:removeAllItems()
--    Tools.delayCallFunc(0.1,function()
        for var = 1,self.m_maxNum do
        --显示每关配置的选用道具
            local _goodsCon = self.m_goods[var]

            if _goodsCon then
                local item = self.listView:newItem()
                local content = PropItem.new(_goodsCon)
                content:setTouchEnabled(false)
                content:setContentSize(self.listPanelSize.width*display.right/GroupSize.width, 78*display.right/GroupSize.width)--*display.right/GroupSize.width
                item:setItemSize(self.listPanelSize.width*display.right/GroupSize.width, 78*display.right/GroupSize.width)
                item:addContent(content)
                self.listView:addItem(item)
               
            else
                Tools.printDebug("hc 开局道具配置错误")
            end
        end
        self.listView:reload()
--    end)
end

--获取道具数据
function FightReadyUI:makeGoodsData(parameters)
    local _dataList = {}
    if self.m_mode == GAME_TYPE.LevelMode then
        local _levelCon = SelectLevel[GameDataManager.getCurLevelId()] 
        if _levelCon then
            Tools.printDebug("关卡模式道具配置")
            local _curGoodsArr = _levelCon.startGoods
            for key, var in ipairs(_curGoodsArr) do
                local _goodsCon = clone(GoodsConfig[var])
                if _goodsCon then
                    _goodsCon.isSelect = false
                    table.insert(_dataList,_goodsCon)
                else
                    Tools.printDebug("not exist")
                end
            end
        end
    else
        Tools.printDebug("无尽模式道具配置")
        local _curGoodsArr = EndlessMode.goods
        for key, var in ipairs(_curGoodsArr) do
            local _goodsCon = clone(GoodsConfig[var])
            if _goodsCon then
                _goodsCon.isSelect = false
                table.insert(_dataList,_goodsCon)
            else
                Tools.printDebug("not exist")
            end
        end
    end

    return _dataList
end


--添加到舞台时调用
function FightReadyUI:addedToScene()
end

--清理数据
function FightReadyUI:onCleanup()
    GameDispatcher:removeListenerByName(EventNames.EVENT_ACHIEVE_UPDATE)
    GameDispatcher:removeListenerByName(EventNames.EVENT_ROLEUPGRADE_UPDATE)
end

--关闭界面调用
function FightReadyUI:toClose(_clean)

    GameDispatcher:removeListenerByName(EventNames.EVENT_ACHIEVE_UPDATE)
    GameDispatcher:removeListenerByName(EventNames.EVENT_ROLEUPGRADE_UPDATE)

    FightReadyUI.super.toClose(self,_clean)

end

return FightReadyUI