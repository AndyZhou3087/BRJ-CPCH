--[[
战斗场景
]]
local MapView = require("game.view.map.MapView")
local MapLayer = require("game.view.map.MapLayer")
local scheduler = require("framework.scheduler")

local GameScene = class("GameScene", function()
    return display.newPhysicsScene("GameScene")
end)

local Gravity = 0    --重力

--@param1:战斗场景资源加载完成后的回调方法
function GameScene:ctor(_completeFunc)
    local _world = self:getPhysicsWorld()
    _world:setGravity(cc.p(0, Gravity))
--    _world:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)

    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))

    self:setTouchEnabled(true)
    self:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if self.m_map then
            return self.m_map:touchFunc(event)
        end
    end)

    --加载资源
    LoadResManager.toLoadFightRes(_completeFunc)

end

--开启帧事件
function GameScene:updateStart(parameters)
    local _world = self:getPhysicsWorld()
    _world:setAutoStep(false)
    self:scheduleUpdate()
end

--帧回调
function GameScene:update(_dt)
    self:getPhysicsWorld():step(0.05)
end

function GameScene:onEnter()

    local _levelCon = SelectLevel[GameDataManager.getCurLevelId()]
    if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode and not _levelCon then
        return
    end

    self.m_map = MapLayer.new()
    self:addChild(self.m_map)
    GameController.setCurMapLayer(self.m_map)

    self.m_fightView = MapView.new()
    self:addChild(self.m_fightView,UI_ZORDER.VIEW_ZORDER)

    AudioManager.playGroundMusic(AudioManager.Ground_Music_Type.Fight_Bg,true)

    Tools.delayCallFunc(0.001,function()
        self.m_map:initPhyPos()
        if GameController.getStartPropById(1) then
        	GameDataManager.useGoods(1)
        end
        if GameController.getStartPropById(3) then
        	GameDataManager.useGoods(3)
        end
    end)

    self.m_handlerStart=Tools.delayCallFunc(0.1,handler(self,self.updateStart))

end

function GameScene:onExit()
    Tools.printDebug("Game scene onExit")
    self:release()
end

--场景销毁
function GameScene:onCleanup()
    self:removeNodeEventListenersByEvent(cc.NODE_TOUCH_EVENT)

    --移除帧事件
    self:removeNodeEventListenersByEvent(cc.NODE_ENTER_FRAME_EVENT)
    self:unscheduleUpdate()

    if self.m_handlerStart then
        scheduler.unscheduleGlobal(self.m_handlerStart)
        self.m_handlerStart=nil
    end

    if not tolua.isnull(self.m_map) then
        self.m_map:dispose()
    end

    if not tolua.isnull(self.m_fightView) then
        self.m_fightView:dispose()
    end

    AudioManager.clearAll()
    PoolManager.clearCache()
    --移除战斗场景加载的资源
    LoadResManager.toUnloadFightRes()

end

return GameScene
