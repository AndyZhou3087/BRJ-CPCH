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
    
    local commonui = CommonUI.new():addTo(self)
    commonui:setPosition(cc.p(0,display.top-60))
    
    local _levelCon = 1  --关卡默认值
    if parm == GAME_TYPE.LevelMode then
        Tools.printDebug("关卡模式")
        --得到当前关卡id与关卡索引
        local _levelId,_levelIdx = GameDataManager.getCurLevelId()
        _levelCon = SelectLevel[_levelId]
        if not _levelCon then
            printf("chjh erro 找不到id=%d的关卡配置数据",_levelId)
            return
        end
    elseif parm == GAME_TYPE.EndlessMode then
        Tools.printDebug("无尽模式")
        GameDataManager.resetLevelData()  --重置关卡数据
    else
        Tools.printDebug("readyView no mode!!!")
    end

    local listPanel = cc.uiloader:seekNodeByName(self.FightReady,"Panel_21")
    self.listPanelSize = listPanel:getCascadeBoundingBox().size
    
    self.listView = cc.ui.UIListView.new {
        bgScale9 = true,
        viewRect = cc.rect(0, 0, self.listPanelSize.width, self.listPanelSize.height),
        direction = cc.ui.UIScrollView.DIRECTION_VERTICAL}
        :onTouch(handler(self, self.touchListener))
        :addTo(listPanel)
    self.m_goods = self:makeGoodsData()
    self:initProp(true)
    
    local rolebtn = cc.uiloader:seekNodeByName(self.FightReady,"Rolebtn")
    rolebtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("-----------角色")
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_ROLEVIEW)
    end)
    
    local achievebtn = cc.uiloader:seekNodeByName(self.FightReady,"AchieveBtn")
    achievebtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("-----------成就任务")
        GameDispatcher:dispatch(EventNames.EVENT_ACHIEVE_QUEST)
    end)
    
    local startGame = cc.uiloader:seekNodeByName(self.FightReady,"StartGame")
    startGame:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        Tools.printDebug("-----------开始游戏")
        GameDataManager.generatePlayerVo()  --产生新的角色数据对象
        if parm == GAME_TYPE.LevelMode and GameDataManager.costPower(_levelCon.costPower) then
                for key, var in ipairs(self.m_goods) do
                    if var.isSelect then
                        GameDataManager.useGoods(var.id)
                        if var.cost.type == COST_TYPE.Gold then
                            GameDataManager.costGold(var.cost.price)
                        elseif var.cost.type == COST_TYPE.Diamond then
                            GameDataManager.costDiamond(var.cost.price)
                        end
                        GameDataManager.addGoods(var.id,1)
                        GameController.setStartProp(var.id,var.isSelect)
                    end
                end
                GAME_TYPE_CONTROL = GAME_TYPE.LevelMode
                app:enterGameScene()
                self:toClose(true)
            Tools.delayCallFunc(0.01,function()
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_LOAD,{method=2,})
            end)
        elseif parm == GAME_TYPE.EndlessMode and GameDataManager.costPower(EndlessMode.costPower) then      
            GAME_TYPE_CONTROL = GAME_TYPE.EndlessMode
            for key, var in ipairs(self.m_goods) do
                if var.isSelect then
                    GameDataManager.useGoods(var.id)
                    if var.cost.type == COST_TYPE.Gold then
                        GameDataManager.costGold(var.cost.price)
                    elseif var.cost.type == COST_TYPE.Diamond then
                        GameDataManager.costDiamond(var.cost.price)
                    end
                    GameDataManager.addGoods(var.id,1)
                    GameController.setStartProp(var.id,var.isSelect)
                end           
            end
            startGame:setButtonEnabled(false)
            app:enterGameScene()
            self:toClose(true)
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
            GameDispatcher:dispatch(EventNames.EVENT_OPEN_GIFTROLE,{giftId = 4})
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
    
--    GameDispatcher:addListener(EventNames.EVENT_ROLE_CHANGE,handler(self,self.changeRole))
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
                content:setContentSize(self.listPanelSize.width, 78)
                item:setItemSize(self.listPanelSize.width, 78)
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
--    GameDispatcher:removeListenerByName(EventNames.EVENT_ROLE_CHANGE)
end

--关闭界面调用
function FightReadyUI:toClose(_clean)

--    GameDispatcher:removeListenerByName(EventNames.EVENT_ROLE_CHANGE)

    FightReadyUI.super.toClose(self,_clean)

end

return FightReadyUI