--[[
地图界面
]]
local MapView = class("MapView",function()
    return display.newNode()
end)

function MapView:ctor(parameters)
    self:setTouchSwallowEnabled(false)

    self.m_mapView = cc.uiloader:load("json/MapView.json")
    self:addChild(self.m_mapView)
    
    local Image_2 = cc.uiloader:seekNodeByName(self.m_mapView,"Image_2")
    Image_2:setPositionY(display.top-34)
    local Image_2_0 = cc.uiloader:seekNodeByName(self.m_mapView,"Image_2_0")
    Image_2_0:setPositionY(display.top-84)

    self.DiamondCount = cc.uiloader:seekNodeByName(self.m_mapView,"DiamondCount")
    self.DiamondCount:setString(GameDataManager.getDiamond())
    
    self.RecordScroe = cc.uiloader:seekNodeByName(self.m_mapView,"RecordScroe")
    self.RecordScroe:setString(GameDataManager.getRecord())
    
    self.Score = cc.uiloader:seekNodeByName(self.m_mapView,"Score")
    self.Score:setPositionY(display.top-64)
    self.Score:setString(1)
    
    self.PauseBtn = cc.uiloader:seekNodeByName(self.m_mapView,"PauseBtn")
    self.PauseBtn:setPositionY(display.top-62)
    local pause = cc.uiloader:seekNodeByName(self.m_mapView,"Button_9")
    pause:setButtonEnabled(false)
    self.PauseBtn:onButtonPressed(function(_event)    --按下
        pause:setButtonImage("disabled","pause/pause_2.png")
    end)
    self.PauseBtn:onButtonRelease(function(_event)    --触摸离开
        pause:setButtonImage("disabled","pause/pause_1.png")
    end)
    self.PauseBtn:onButtonClicked(function (event)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_PAUSE)
    end)

    --监听钻石
    self.diamondHandler = GameDispatcher:addListener(EventNames.EVENT_DIAMOND_CHANGE,handler(self,self.updateDiamond))
    GameDispatcher:addListener(EventNames.EVENT_UPDATE_FLOOR,handler(self,self.updateFloor))
    GameDispatcher:addListener(EventNames.EVENT_UPDATE_BEST,handler(self,self.updateBestFloor))
end

function MapView:updateDiamond()
    self.DiamondCount:setString(GameDataManager.getDiamond())
end

function MapView:updateFloor()
    if self.Score then
        self.Score:setString(GameDataManager.getPoints())
    end
end

function MapView:updateBestFloor()
    if self.RecordScroe then
        self.RecordScroe:setString(GameDataManager.getRecord())
    end
end

function MapView:dispose(parameters)
    GameDispatcher:removeListenerByHandle(self.diamondHandler)
    GameDispatcher:removeListenerByName(EventNames.EVENT_UPDATE_BEST)
    GameDispatcher:removeListenerByName(EventNames.EVENT_UPDATE_FLOOR)

    self:removeFromParent(true)
end

return MapView