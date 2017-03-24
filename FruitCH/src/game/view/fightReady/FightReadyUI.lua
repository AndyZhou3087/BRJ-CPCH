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

    --阴影层
    local bg = display.newColorLayer(cc.c4b(0,0,0,120)):addTo(self)
    self.m_size_ = bg:getCascadeBoundingBox().size

    self.FightReady = cc.uiloader:load("json/FightReady.json")
    self:addChild(self.FightReady)
    
    local commonui = CommonUI.new():addTo(self)
    commonui:setPosition(cc.p(10,display.top-60))
    
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
--        GameDataManager.resetLevelData()  --重置关卡数据
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
        Tools.printDebug("-----------角色")
    end)
    
    local startGame = cc.uiloader:seekNodeByName(self.FightReady,"StartGame")
    startGame:onButtonClicked(function(event)
        Tools.printDebug("-----------开始游戏")
        GameDataManager.generatePlayerVo()  --产生新的角色数据对象
        if GameDataManager.costPower(_levelCon.costPower) then
        	if parm == GAME_TYPE.LevelMode then
                for key, var in ipairs(self.m_goods) do
                    if var.isSelect then
                        GameDataManager.useGoods(var.id)
                        if var.cost.type == COST_TYPE.Gold then
                            GameDataManager.costGold(var.cost.price)
                        elseif var.cost.type == COST_TYPE.Diamond then
                            GameDataManager.costDiamond(var.cost.price)
                        end
                    end
                end
                GAME_TYPE_CONTROL = GAME_TYPE.LevelMode
                app:enterGameScene()
                self:toClose(true)
                --        elseif parm == GAME_TYPE.EndlessMode and GameDataManager.costPower(EndlessMode.costPower) then      
                --            GAME_TYPE_CONTROL = GAME_TYPE.EndlessMode
                --            for key, var in ipairs(self.m_goods) do
                --                if var.isSelect then
                --                    local curId = var.id
                --                    GameDataManager.useGoods(var.id)
                --                end           
                --            end
                --            app:enterFightScene()
                --            self:toClose(true)
            end
        else
            print("体力不足！！",GameDataManager.getPower())
            startGame:setButtonEnabled(true)
            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="体力不足"})
--            GameDispatcher:dispatch(EventNames.EVENT_OPEN_POWER,{})
        end
    end)
    
    GameDispatcher:dispatch(EventNames.EVENT_LOADING_OVER)
end

function FightReadyUI:touchListener(event)
	
end

function FightReadyUI:initProp(par)
    self.m_maxNum = #self.m_goods
    if self.m_maxNum > 5 then
        self.m_maxNum = 5
    end

    self.listView:removeAllItems()
    Tools.delayCallFunc(0.1,function()
        for var = 1,self.m_maxNum do
        --显示每关配置的选用道具
            local _goodsCon = self.m_goods[var]

            if _goodsCon then
                local item = self.listView:newItem()
                local content = PropItem.new(_goodsCon)
                content:setTouchEnabled(false)
                content:setContentSize(self.listPanelSize.width, 105)
                item:setItemSize(self.listPanelSize.width, 105)
                item:addContent(content)
                self.listView:addItem(item)
               
            else
                Tools.printDebug("hc 开局道具配置错误")
            end
        end
        self.listView:reload()
    end)
end

--获取道具数据
function FightReadyUI:makeGoodsData(parameters)
    local _dataList = {}
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

--关闭界面调用
function FightReadyUI:toClose(_clean)

    FightReadyUI.super.toClose(self,_clean)

end

return FightReadyUI