--[[
地图层
]]
local Scheduler = require("framework.scheduler")
local Player = require("game.view.element.Player")

local MapLayer = class("MapLayer",function()
    local pLayer = cc.Layer:create()
    return pLayer
end)

local BackGroundMove = require("game.custom.BackGroundMove")
local MapGroup = require("game.view.map.MapGroup")

function MapLayer:ctor(parameters)

    GameController.setSpeed(MoveSpeed)
    self.m_backbg = BackGroundMove.new(GameBgRes,0,MoveSpeed):addTo(self)

    self.group = {}
    self.pexel = 0
    
    self.m_curZOrder = MAP_ZORDER_MAX + 1

    self.m_roomsNum = MAP_GROUP_INIT_NUM
    
    GameDataManager.resetLevelData()
    
    --上边界
--    self.edgeTop = display.newNode()
--    local topBody = cc.PhysicsBody:createEdgeSegment(cc.p(0,display.height-50),cc.p(display.width,display.height-50),cc.PhysicsMaterial(0, 0, 0),2)
--    topBody:setTag(ELEMENT_TAG.Edge_Top)
--    self.edgeTop:setPhysicsBody(topBody)
--    self:addChild(self.edgeTop)
--
--    --下边界
--    self.edgeDown = display.newNode()
--    local downBody = cc.PhysicsBody:createEdgeSegment(cc.p(0,20),cc.p(display.width,20),cc.PhysicsMaterial(0, 0, 0),2)
--    downBody:setTag(ELEMENT_TAG.Edge_Down)
--    self.edgeDown:setPhysicsBody(downBody)
--    self:addChild(self.edgeDown)

    self.m_isDelay = false
    
    self.m_player = Player.new()
    self:addChild(self.m_player,MAP_ZORDER_MAX+1)
    self.m_player:setPosition(display.cx-100,display.cy-240)
    GameController.setCurPlayer(self.m_player)

end

function MapLayer:initRooms()
    if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode then
        self.m_levelCon = SelectLevel[GameDataManager.getCurLevelId()]
        self.curRooms = self.m_levelCon.obstacle
    elseif GAME_TYPE_CONTROL == GAME_TYPE.EndlessMode then
        -- self.endlessCon = EndlessMode.room_Type
        -- self.m_levelCon = self.endlessCon
        -- self.curRooms = self.endlessCon
    end
    
    if self.m_levelCon then
        self.m_roomsNum = MAP_GROUP_INIT_NUM
        self.m_roomAmount=#self.curRooms
        if self.m_roomsNum > self.m_roomAmount then
            self.m_roomsNum = self.m_roomAmount
        end
    else
        Tools.printDebug("chjh error 找不到id=%d的关卡配置",GameDataManager.getCurLevelId())
        return
    end
    
    local _x,_y = 0,0
    for var=1, self.m_roomsNum do
        local _group = MapGroup.new(var,self.m_levelCon)
        local _width = (self.group[#self.group] and self.group[#self.group]:getPositionX()) or CacheDis
        _x = _width + self.m_levelCon.gap + GroupSize.width
        self:addChild(_group,self.m_curZOrder)
        _group:initPosition(_x,_y)
        table.insert(self.group,_group)
        self.m_curZOrder = self.m_curZOrder + 1
    end
end

function MapLayer:addNewGroup(parameters)
    if self.m_roomsNum >= self.m_roomAmount then
        MoveSpeed = 0
        self.m_player:LevelWin()
        return
    end
    self.m_roomsNum = self.m_roomsNum + 1
    Tools.printDebug("----------加载组数：",self.m_roomsNum)
    local _x,_y = 0,0
    if self.m_levelCon then
        local _group = MapGroup.new(self.m_roomsNum,self.m_levelCon)
        local _width = (self.group[#self.group] and self.group[#self.group]:getPositionX()) or CacheDis
        _x = _width + self.m_levelCon.gap + GroupSize.width
        self:addChild(_group,self.m_curZOrder)
        _group:initPosition(_x,_y)
        table.insert(self.group,_group)
    end
    self.m_curZOrder = self.m_curZOrder + 1

    if #self.group >= MAP_GROUP_INIT_NUM then
        local _group = table.remove(self.group,1)
    end
end

--触摸
function MapLayer:touchFunc(event)
    if GameController.isWin or GameController.isDead then
        return true
    end

    if event.name == "began" or event.name == "added" then
        self.m_player:toPlay(PLAYER_ACTION.Jump,0)
        self.m_player:toMove()
        return true
    elseif event.name == "ended" then
        
    elseif event.name == "removed" then

    elseif event.name == "moved" then

    end
    return true
end

--碰撞开始触发
function MapLayer:collisionBeginCallBack(parameters)
    if GameController.isWin or GameController.isDead then
        return true
    end

    Tools.printDebug("碰撞检测")
    local conData = parameters:getContactData()
    local bodyA = parameters:getShapeA():getBody()
    local bodyB = parameters:getShapeB():getBody()
    local tagA = bodyA:getTag()
    local tagB = bodyB:getTag()
    local player,playerBP,playerTag,_size,playerBody
    local obstacle,obstacleBP,obstacleTag,obstacleBody
    local obstacleS,obstacleScale
    local obstacleOff

    if tagA == ELEMENT_TAG.PLAYER_TAG then
        player = bodyA:getNode()
        playerBP = bodyA:getPosition()
        playerTag = tagA
        playerBody = bodyA

        obstacle = bodyB:getNode()
        obstacleBP = bodyB:getPosition()
        obstacleTag = tagB
        obstacleBody = bodyB

        obstacleOff=parameters:getShapeB():getOffset()

    end
    if tagB == ELEMENT_TAG.PLAYER_TAG then
        player = bodyB:getNode()
        playerBP = bodyB:getPosition()
        playerTag = tagB
        playerBody = bodyB

        obstacle = bodyA:getNode()
        obstacleBP = bodyA:getPosition()
        obstacleTag = tagA
        obstacleBody = bodyA

        obstacleOff=parameters:getShapeA():getOffset()
    end
    if tolua.isnull(bodyA) or tolua.isnull(bodyB) then
        return true
    end

    if player and player:getVo().m_hp <= 0 then
        return true
    end
    if (not player) or player:isDead() then
        return true
    end
    if tolua.isnull(obstacle) then
    	return false
    end
    
    if obstacleTag == ELEMENT_TAG.OBSTACLE then
    	obstacle:collision()
    	return true
    end
    if obstacleTag == ELEMENT_TAG.GOLD_TAG then
        obstacle:collision()
        return true
    end

    return true
end


function MapLayer:initPhyPos(parameters)
    self.m_event = cc.EventListenerPhysicsContact:create()
    self.m_event:registerScriptHandler(handler(self,self.collisionBeginCallBack), cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    self:getEventDispatcher():addEventListenerWithFixedPriority(self.m_event,1)
    self.m_timer = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),0.01)

    --初始化几组障碍，不能在ctor的时候调用
    self:initRooms()
end

--帧函数
function MapLayer:onEnterFrame(dt)

    --移动金币
--    GameController.attract()

--    local bpx,bpy = self.m_player:getPosition()
--    self.m_player:update(dt,bpx,bpy)

    --跑了多少米换算公式
   self.pexel = self.pexel + MoveSpeed*0.1/(Pixel/Miles)

   local cur = math.floor(self.pexel)
    GameDataManager.addLevelScore(cur)

end

--设置移动缓慢停止
function MapLayer:toDelay(parameters)
    if not self.m_isDelay then
        self.m_isDelay = true
        local function toSlow(parameters)
            local delay = cc.DelayTime:create(0.1)
            local comFunc = cc.CallFunc:create(function()
                MoveSpeed = MoveSpeed - 10
                if MoveSpeed > 0 then
                    toSlow()
                else
                    MoveSpeed = 0
--                    GameDispatcher:dispatch(EventNames.EVENT_OPEN_REVIVE)  --调用复活界面
                end
            end)
            local seq = cc.Sequence:create(delay,comFunc)
            self:runAction(seq)
        end
        toSlow()
    end

end

--地图销毁
function MapLayer:dispose(parameters)
    --移除碰撞事件
    self:getEventDispatcher():removeEventListener(self.m_event)

    if self.group then
        for key, var in pairs(self.group) do
            if not tolua.isnull(var) then
                var:dispose() 
            end
        end
    end
    self.group = {}

    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end

    if self.m_player then
        self.m_player:dispose()
    end
    
    if not tolua.isnull(self.m_backbg) then
        self.m_backbg:dispose()
    end
    
    MoveSpeed = initSpeed
    self.m_isDelay = false
    
    GameDataManager.resetLevelData()
    GameController.clearBody()
    
    self:removeFromParent(true)
end

return MapLayer