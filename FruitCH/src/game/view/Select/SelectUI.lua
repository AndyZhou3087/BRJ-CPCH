--[[
选择界面
]]
local BaseUI = require("game.view.BaseUI")
local SelectUI = class("SelectUI",BaseUI)

local SelectItem = require("game.view.Select.SelectItem")
local Scheduler = require("framework.scheduler")

function SelectUI:ctor()
    SelectUI.super.ctor(self) 
    self:init()
    --启用onCleanup函数
    self:setNodeEventEnabled(true)
end

--初始化
function SelectUI:init(parameters)
    self.m_json = cc.uiloader:load("json/SelectUI.json")
    self:addChild(self.m_json)

    self.itemArr = {}

    local emptyNode = cc.Node:create()
    emptyNode:setAnchorPoint(0,0)

    self.scrollView = cc.ui.UIScrollView.new({viewRect = cc.rect(0,0,display.width,display.height)})
        :addScrollNode(emptyNode)
        :setDirection(cc.ui.UIScrollView.DIRECTION_HORIZONTAL)
        :onScroll(handler(self, self.scrollListener))
        :addTo(self)
        
    for var=1, #SelectOtherConfig do
        local otherConfig = SelectOtherConfig[var]
        local sprite = display.newSprite(otherConfig.res):addTo(emptyNode)
        sprite:setAnchorPoint(0,0)
        sprite:pos(otherConfig.x,otherConfig.y)
    end
    for var=1, #SelectLevel do
        local selConfig = SelectLevel[var]
        local sel = SelectItem.new(selConfig):addTo(emptyNode)
        sel:setAnchorPoint(0,0)
        sel:setContentSize(100, 100)
        sel:pos(selConfig.pos.x,selConfig.pos.y)
        self.itemArr[var] = sel
    end

    
    --签到
    self.signHandler = Tools.delayCallFunc(0.1,function()
        if not GameDataManager.isDateSign() and GameController.getSignPop() then
        	GameDispatcher:dispatch(EventNames.EVENT_OPEN_SIGNUI)
        end
    end)

    self:moveScrollView()
end

function SelectUI:moveScrollView(parameters)
    local x,y = self.itemArr[GameDataManager.getNextFightDataId()]:getPosition()
    local wordPos = self.itemArr[GameDataManager.getNextFightDataId()]:getParent():convertToWorldSpace(cc.p(x,y))
    local dis = wordPos.x-display.cx
    local nodeX,nodeY = self.scrollView.scrollNode:getPosition()
    Tools.printDebug("-------------ScrollView坐标：",dis)
    if dis <= 0 then
        return
    end
    if -dis >= (display.width - GroupSize.width)-2061 then
        transition.moveBy(self.scrollView.scrollNode,{time = 0.5,x=-dis,y=0})
    else
        transition.moveBy(self.scrollView.scrollNode,{time = 0.5,x=(display.width - GroupSize.width)-2061,y=0})
    end
    
end

function SelectUI:scrollListener(event)
	
end

--关闭界面调用
function SelectUI:dispose(_clean)
    if self.signHandler then
        Scheduler.unscheduleGlobal(self.signHandler)
        self.signHandler = nil
    end
    
    SelectUI.super.toClose(self,_clean)
end

--清理数据
function SelectUI:onCleanup()
    if self.signHandler then
        Scheduler.unscheduleGlobal(self.signHandler)
        self.signHandler = nil
    end
    GameDataManager.SaveData()
end
return SelectUI