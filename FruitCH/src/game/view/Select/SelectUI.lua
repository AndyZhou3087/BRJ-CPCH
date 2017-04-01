--[[
选择界面
]]
local BaseUI = require("game.view.BaseUI")
local SelectUI = class("SelectUI",BaseUI)

local SelectItem = require("game.view.Select.SelectItem")

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
    
--    local scrollPanel = cc.uiloader:seekNodeByName(self.m_json,"Panel_8")
--    local scrollPanelSize = scrollPanel:getCascadeBoundingBox().size
--    local scrollView = cc.ui.UIListView.new {
--        bgScale9 = true,
--        viewRect = cc.rect(0, 0, scrollPanelSize.width, scrollPanelSize.height),
--        direction = cc.ui.UIScrollView.DIRECTION_HORIZONTAL}
--        :onTouch(handler(self, self.touchListener))
--        :addTo(scrollPanel)
    
--    scrollView:removeAllItems()
--    Tools.delayCallFunc(0.1,function()
--        for var=1, #SelectLevel do
--            local item = scrollView:newItem()
--            local content = SelectItem.new(SelectLevel[var])
--            content:setTouchEnabled(false)
--            content:setContentSize(math.floor(scrollPanelSize.width / SelectItemCount), scrollPanelSize.height)
--            item:setItemSize(math.floor(scrollPanelSize.width / SelectItemCount), scrollPanelSize.height)
--            item:addContent(content)
--            scrollView:addItem(item)
--        end
--        scrollView:reload()
--    end)

    local emptyNode = cc.Node:create()
    emptyNode:setAnchorPoint(0,0)

    local scrollView = cc.ui.UIScrollView.new({viewRect = cc.rect(0,0,GroupSize.width,GroupSize.height)})
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
    end

    
    --签到
    Tools.delayCallFunc(0.1,function()
        if not GameDataManager.isDateSign() and GameController.getSignPop() then
        	GameDispatcher:dispatch(EventNames.EVENT_OPEN_SIGNUI)
        end
    end)
end

function SelectUI:scrollListener(event)
	
end

--关闭界面调用
function SelectUI:toClose(_clean)

    SelectUI.super.toClose(self,_clean)
end

--清理数据
function SelectUI:onCleanup()
    GameDataManager.SaveData()
end
return SelectUI