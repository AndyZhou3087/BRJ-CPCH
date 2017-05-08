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
    
    local levelCon
    if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode then
        levelCon = SelectLevel[GameDataManager.getCurLevelId()]
    else
        levelCon = EndlessMode
    end
    if not levelCon then
    	return
    end
    local lvSpeed = levelCon.speed
    MoveSpeed = lvSpeed
    if MoveSpeed>=SpeedMax then
        MoveSpeed = SpeedMax
    end
    GameController.setSpeed(MoveSpeed)
    self.m_backbg = BackGroundMove.new(GameBgRes,0,MoveSpeed):addTo(self)

    self.group = {}
    GameController.setRooms(self.group)
    self.pexel = 0
    self.miles = 0
    self.isGiftPop = false
    
    self.m_curZOrder = MAP_ZORDER_MAX + 1

    self.m_roomsNum = MAP_GROUP_INIT_NUM
    
    GameDataManager.resetLevelData()
    
    
    if GAME_TYPE_CONTROL == GAME_TYPE.EndlessMode then
        --预先组合排序
        self.m_conD = GameController.getSorting(ConfigD)
        self.m_conC = GameController.getSorting(ConfigC)
        self.m_conB = GameController.getSorting(ConfigB)
        self.m_conA = GameController.getSorting(ConfigA)
        self.m_conS = GameController.getSorting(ConfigS)
        --预先计算总权重值
        self.m_weightD = GameController.getTotalWeight(ConfigD)
        self.m_weightC = GameController.getTotalWeight(ConfigC)
        self.m_weightB = GameController.getTotalWeight(ConfigB)
        self.m_weightA = GameController.getTotalWeight(ConfigA)
        self.m_weightS = GameController.getTotalWeight(ConfigS)
        --是否遮罩
        self.m_clip = false
    end

    self.m_isDelay = false
    
    self.m_player = Player.new()
    self:addChild(self.m_player,self.m_curZOrder+1)
    self.m_player:setPosition(display.cx-100,display.cy-240)
    GameController.setCurPlayer(self.m_player)
    
    if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode and levelCon.isClip then
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_CLIPP)
    end
    
    
    --新手引导
    if DataPersistence.getAttribute("first_into") then
        self.guideStep = 1
        MoveSpeed = levelCon.guideSpeed
    end
end


function MapLayer:initRooms()
    if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode then
        self.m_levelCon = SelectLevel[GameDataManager.getCurLevelId()]
        if DataPersistence.getAttribute("first_into") then
            self.curRooms = self.m_levelCon.guideMap
            self.m_gap = self.m_levelCon.guideGap
        else
            self.curRooms = self.m_levelCon.map
            self.m_gap = self.m_levelCon.gap
        end
    elseif GAME_TYPE_CONTROL == GAME_TYPE.EndlessMode then
        --控制随机数种子
        math.randomseed(tostring(os.time()):reverse():sub(1, 6))
        self.m_levelCon = ConfigD[GameController.getDataIdByWeight(self.m_weightD,self.m_conD)]
        self.m_gap = self.m_levelCon.gap
    end

    if self.m_levelCon then
        self.m_roomsNum = MAP_GROUP_INIT_NUM
        if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode then
            self.m_roomAmount=#self.curRooms
            Tools.printDebug("chjh 关卡配置",self.m_roomAmount)
            if self.m_roomsNum > self.m_roomAmount then
                self.m_roomsNum = self.m_roomAmount
            end
        end
    else
        Tools.printDebug("chjh error 找不到id=%d的关卡配置",GameDataManager.getCurLevelId())
        return
    end
    
    local _x,_y = 0,0
    for var=1, self.m_roomsNum do
        local _group = MapGroup.new(var,self.m_levelCon)
        local _width = (self.group[#self.group] and self.group[#self.group]:getPositionX()) or CacheDis
        _x = _width + self.m_gap + GroupSize.width
        self:addChild(_group,self.m_curZOrder)
        _group:initPosition(_x,_y)
        table.insert(self.group,_group)
--        self.m_curZOrder = self.m_curZOrder + 1
    end
end

function MapLayer:addNewGroup(parameters)
    if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode and self.m_roomsNum >= self.m_roomAmount then
        MoveSpeed = 0
        self.m_player:LevelWin()
        return
    end
    if GAME_TYPE_CONTROL == GAME_TYPE.EndlessMode then
        self:addEndlessGroup()
    end
    
    self.m_roomsNum = self.m_roomsNum + 1
    Tools.printDebug("----------加载组数：",self.m_roomsNum)
    local _x,_y = 0,0
    if self.m_levelCon then
        local _group = MapGroup.new(self.m_roomsNum,self.m_levelCon)
        local _width = (self.group[#self.group] and self.group[#self.group]:getPositionX()) or CacheDis
        _x = _width + self.m_gap + GroupSize.width
        self:addChild(_group,self.m_curZOrder)
        _group:initPosition(_x,_y)
        table.insert(self.group,_group)
    end
--    self.m_curZOrder = self.m_curZOrder + 1

    if #self.group >= MAP_GROUP_INIT_NUM then
        local _group = table.remove(self.group,1)
    end
end

function MapLayer:addEndlessGroup(parameters)
    if self.pexel >= EndlessMode.DistanceS.move then
        self.m_levelCon = ConfigS[GameController.getDataIdByWeight(self.m_weightS,self.m_conS)]
        MoveSpeed = EndlessMode.DistanceS.speed
    elseif self.pexel >= EndlessMode.DistanceA.move then
        self.m_levelCon = ConfigA[GameController.getDataIdByWeight(self.m_weightA,self.m_conA)]
        MoveSpeed = EndlessMode.DistanceA.speed
    elseif self.pexel >= EndlessMode.DistanceB.move then
        self.m_levelCon = ConfigB[GameController.getDataIdByWeight(self.m_weightB,self.m_conB)]
        MoveSpeed = EndlessMode.DistanceB.speed
    elseif self.pexel >= EndlessMode.DistanceC.move then
        self.m_levelCon = ConfigC[GameController.getDataIdByWeight(self.m_weightC,self.m_conC)]
        MoveSpeed = EndlessMode.DistanceC.speed
    else
        self.m_levelCon = ConfigD[GameController.getDataIdByWeight(self.m_weightD,self.m_conD)]
        MoveSpeed = EndlessMode.DistanceD.speed
    end
    if MoveSpeed>=SpeedMax then
    	MoveSpeed = SpeedMax
    end
    GameController.setSpeed(MoveSpeed)
end

--触摸
function MapLayer:touchFunc(event)
    if MoveSpeed<=0 then
    	return
    end
    if DataPersistence.getAttribute("first_into") then
    	return
    end
    if GameController.isWin or GameController.isDead then
        return
    end
    if GameController.isInState(PLAYER_STATE.StartSprint) or GameController.isInState(PLAYER_STATE.DeadSprint)
        or GameController.isInState(PLAYER_STATE.LimitSprint) or GameController.isInState(PLAYER_STATE.Spring) then
    	return
    end
    if event.name == "began" or event.name == "added" then
        self.m_player:clickJumpfunc()
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
    if not GameController.getCollsionEnable() then
    	return true
    end
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
    
    if obstacleTag == ELEMENT_TAG.OBSTACLE or obstacleTag == ELEMENT_TAG.GOLD_TAG or obstacleTag == ELEMENT_TAG.GOOD_TAG then
        if obstacleTag == ELEMENT_TAG.OBSTACLE then
            if not obstacle:isDisappear() then
                obstacle:collision()
            end
        else
            obstacle:collision()
        end
    	return true
    end

    return true
end
--碰撞结束
function MapLayer:collisionEndCallBack(parameters)
    if not GameController.getCollsionEnable() then
        return true
    end
    if GameController.isWin or GameController.isDead then
        return true
    end

    Tools.printDebug("----------碰撞检测离开")
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
        if obstacle:getVo().m_type == OBSTACLE_TYPE.ice then
            obstacle:collisionEnd()
        end
        return true
    end

    return true
end


function MapLayer:initPhyPos(parameters)
    self.m_event = cc.EventListenerPhysicsContact:create()
    self.m_event:registerScriptHandler(handler(self,self.collisionBeginCallBack), cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    self.m_event:registerScriptHandler(handler(self,self.collisionEndCallBack), cc.Handler.EVENT_PHYSICS_CONTACT_SEPERATE)
    self:getEventDispatcher():addEventListenerWithFixedPriority(self.m_event,1)
    self.m_timer = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),FrameTime)

    --初始化几组障碍，不能在ctor的时候调用
    self:initRooms()
end

--帧函数
function MapLayer:onEnterFrame(dt)

    --移动金币
    GameController.attract()

    if not tolua.isnull(self.m_player) then
        local bpx,bpy = self.m_player:getPosition()
        self.m_player:update(dt,bpx,bpy)
    end

    --跑了多少米换算公式
   self.pexel = self.pexel + MoveSpeed*0.1/(Pixel/Miles)
   GameDataManager.saveDayRunDistance(MoveSpeed*0.1/(Pixel/Miles))
--    Tools.printDebug("-----------多少米：",self.pexel)
    
    self.miles = self.miles + MoveSpeed*0.1
--    Tools.printDebug("-----------多少像素：",self.miles)
    if not DataPersistence.getAttribute("first_into") and GAME_TYPE_CONTROL == GAME_TYPE.LevelMode and not self.isGiftPop then
        if self.m_levelCon.giftGap and self.miles >= self.m_levelCon.giftGap then
            self.isGiftPop = true
            if not GameDataManager.getRoleModle(GiftConfig[1].roleId) then
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_GIFTROLE,{giftId = 1,isGame = true,animation = true})
            elseif not GameDataManager.getRoleModle(GiftConfig[2].roleId) then
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_GIFTROLE,{giftId = 2,isGame = true,animation = true})
            elseif not GameDataManager.getRoleModle(GiftConfig[3].roleId) then
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_GIFTROLE,{giftId = 3,isGame = true,animation = true})
            elseif not GameDataManager.getRoleModle(GiftConfig[4].roleId) then
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_GIFTROLE,{giftId = 4,isGame = true,animation = true})
            end
    	end
    end
   
   if GAME_TYPE_CONTROL == GAME_TYPE.EndlessMode then
        if self.pexel >= EndlessMode.DistanceS.move then
            if not self.m_clip and EndlessMode.DistanceS.isClip then
                self.m_clip = true
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_CLIPP)
            elseif not EndlessMode.DistanceS.isClip and self.m_clip then
                self.m_clip = false
                GameDispatcher:dispatch(EventNames.EVENT_CLOSE_CLIP)
            end
        elseif self.pexel >= EndlessMode.DistanceA.move then
            if not self.m_clip and EndlessMode.DistanceA.isClip then
                self.m_clip = true
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_CLIPP)
            elseif not EndlessMode.DistanceA.isClip and self.m_clip then
                self.m_clip = false
                GameDispatcher:dispatch(EventNames.EVENT_CLOSE_CLIP)
            end
        elseif self.pexel >= EndlessMode.DistanceB.move then
            if not self.m_clip and EndlessMode.DistanceB.isClip then
                self.m_clip = true
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_CLIPP)
            elseif not EndlessMode.DistanceB.isClip and self.m_clip then
                self.m_clip = false
                GameDispatcher:dispatch(EventNames.EVENT_CLOSE_CLIP)
            end
        elseif self.pexel >= EndlessMode.DistanceC.move then
            if not self.m_clip and EndlessMode.DistanceC.isClip then
                self.m_clip = true
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_CLIPP)
            elseif not EndlessMode.DistanceC.isClip and self.m_clip then
                self.m_clip = false
                GameDispatcher:dispatch(EventNames.EVENT_CLOSE_CLIP)
            end
        elseif self.pexel >= EndlessMode.DistanceD.move then
            if not self.m_clip and EndlessMode.DistanceD.isClip then
                self.m_clip = true
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_CLIPP)
            elseif not EndlessMode.DistanceD.isClip and self.m_clip then
                self.m_clip = false
                GameDispatcher:dispatch(EventNames.EVENT_CLOSE_CLIP)
            end
        end
   end

    local cur = math.floor(self.pexel)
    GameDataManager.addLevelScore(cur)
    
    if DataPersistence.getAttribute("first_into") then
        self:initGuide()
    end
end


function MapLayer:initGuide(parameters)
    local per = (GroupSize.width*0.5-100-(display.cx-100))/(Pixel/Miles)
    if self.pexel >= 29+per and self.guideStep == 1 then
        self:stepJump()
    elseif self.pexel >= 40+per and self.guideStep == 2 then
        self:stepJump()
    elseif self.pexel >= 85+per and self.guideStep == 3 then
        self:stepJump()
    elseif self.pexel >= 115+per and self.guideStep == 4 then
        self:stepJump()
    end
end

function MapLayer:stepJump(parameters)
    self.guideStep = self.guideStep + 1
    GameController.pauseGame()
    GameDispatcher:dispatch(EventNames.EVENT_GUIDE_UPDATE,{step = self.guideStep})
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

    if not tolua.isnull(self.m_player) then
        self.m_player:dispose()
    end
    
    if not tolua.isnull(self.m_backbg) then
        self.m_backbg:dispose()
    end
    
    self.m_isDelay = false
    
    GameDataManager.resetLevelData()
    GameDataManager.resetSingleProp()
    GameDataManager.resetGameTime()
    GameController.resetStartProp()
    GameController.clearRooms()
    GameController.clearBody()

    self:removeFromParent(true)
end

return MapLayer