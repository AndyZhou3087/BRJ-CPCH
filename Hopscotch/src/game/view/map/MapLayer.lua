--[[
地图层
]]
local MapRoom = require("game.view.map.MapRoom")
local Player = require("game.view.element.Player")
local Scheduler = require("framework.scheduler")
local SpecialElement = require("game.view.element.SpecialElement")
local BackGroundMove = require("game.view.map.BackGroundMove")
local LineElement = require("game.view.element.LineElement")

local Raycast_DisY = 20  --探测距离
local Raycast_DisX = 6 --探测轴方向有无障碍物

math.randomseed(os.time())   --初始化随机种子

--当前场景状态
local State_Type=
    {
        CommonState = 1,   --普通楼层阶梯状态
        RunningState = 2,   --横跑阶梯状态
    }

local MapLayer = class("MapLayer",function()
    local pLayer = cc.Layer:create()
    return pLayer
end)

function MapLayer:ctor(parameters)

    self.m_chaceRooms = {}  --房间缓存数组
    GameController.setRooms(self.m_chaceRooms)
    self.m_otherRooms = {}   --额外的房间(主要是横跑中不升楼层的房间)
    self.jumpFloorNum = 1
    self.backOrigin = false
    self.m_toJump = false
    self.floorPos = {}
    self.roomArr = {}
    self.specialBody = {}
    self.runFloorNum = RunningFloorNum
    
    self.m_curZOrder = MAP_ZORDER_MAX   --房间当前显示层级
    
    local color = SceneConfig[GameDataManager.getFightScene()].bgColor
    self.bg = cc.LayerGradient:create(color[1],color[2]):addTo(self)
--    self.bg = display.newColorLayer(color[1]):addTo(self)
    Tools.delayCallFunc(0.5,function()
        self.bg:setTouchEnabled(false)
        self.bg:setTouchSwallowEnabled(false)
    end)
    
    self.bgNode = BackGroundMove.new(GameDataManager.getFightScene()):addTo(self)
    
    self.m_bg = display.newSprite("map/Scene_"..GameDataManager.getFightScene().."/Map_frame_2.png")
    self.bottomHeight = self.m_bg:getCascadeBoundingBox().size.height

    --房间层
    self.m_roomNode = display.newNode()
    self.m_roomNode:setTouchEnabled(false)
    self.m_roomNode:setTouchSwallowEnabled(false)
    self:addChild(self.m_roomNode)

    self:initRooms()

    self.m_camera = cc.Camera:createOrthographic(display.width,display.height,0,1)
    self.m_camera:setCameraFlag(cc.CameraFlag.USER1)
    self:addChild(self.m_camera)
    self.m_camera:setPosition3D(cc.vec3(0, 0, 0))
--    Tools.printDebug("-------brj 摄像机初始坐标：",self.m_camera:getPosition())

    self.m_player = Player.new()
    self:addChild(self.m_player,MAP_ZORDER_MAX+1)
    local floorPos = self.floorPos[self.jumpFloorNum]
    local _size = self.m_player:getSize()
    self.m_player:setPosition(cc.p(display.cx,floorPos.y+_size.width*0.5+27))
    GameController.setCurPlayer(self.m_player)

    self:setCameraMask(2)

end

--触摸
local lastTouchTime = 0
function MapLayer:touchFunc(event)
    if tolua.isnull(self.m_player) or self.m_player:isDead() then
        return true
    end
--    Tools.printDebug("-----------------------------self.backOrigin  ",self.backOrigin)
    if self.backOrigin then
    	return true
    end
    if event.name == "began" then
        if (Tools.getSysTime()-lastTouchTime)>=Sequent_Click_Time then
            if self.isCollision then
                self.isCollision = false
--                Tools.printDebug("brj 是否可连击跳跃: ",self.isCollision)
                self:toJump()
            end
        end
        return true
    elseif event.name == "ended" then
        lastTouchTime = Tools.getSysTime()
    elseif event.name == "moved" then
        
    end
    return true
end

--进入地图就创建的房间需要调整对应刚体位置,即需传第三个参数为true(room:initPosition(_x,_y,true))
function MapLayer:initRooms(parameters)
    self.m_roomsNum = 0
    self._x = 0
    local _y = self.bottomHeight - Room_Size.height
    for k=1, MAP_ROOM_INIT_NUM*0.1 do
        --控制随机数种子
        if k > 1 then
            local i = GameDataManager.getDataIdByWeight(Map_Grade.floor_D)
            self.m_levelCon = MapGroupConfigD[i]
        else
            local i = GameDataManager.getDataIdByWeight(-1)
            self.m_levelCon = MapGroupConfigD[i]
        end 
        self.curRooms = self.m_levelCon.roomBgs

        if self.m_levelCon then
            self.m_rooms = self.curRooms
            self.m_roomAmount=#self.m_rooms
            self.m_roomsNum = self.m_roomsNum + self.m_roomAmount
        else
            Tools.printDebug("brj error 找不到配置",i)
            return
        end

        for var=1, self.m_roomAmount do
            Tools.printDebug("brj 初始楼层",var+(k-1)*10)
            local _room = MapRoom.new(var,self.m_levelCon,var+(k-1)*10)
            _room:setAnchorPoint(cc.p(0,0))
            _y = _y + Room_Size.height
            if self.m_levelCon.roomType == MAPROOM_TYPE.Lean then
                self._x = self._x + self.m_levelCon.distance
            end

            self.m_roomNode:addChild(_room,self.m_curZOrder)
            _room:initPosition(self._x,_y,true)
            self.floorPos[var+(k-1)*10] = cc.p(self._x,_y)

            table.insert(self.m_chaceRooms,_room)
            
            --特殊房间楼层的钢架
            if self.m_levelCon.roomType == MAPROOM_TYPE.Special and var == 1 then
                --钢架线
                local line_left = LineElement.new(self.m_levelCon.left)
                self:addChild(line_left,self.m_curZOrder)
                line_left:setAnchorPoint(cc.p(0,1))
                local leftHeight = line_left:getCascadeBoundingBox().size.height
                line_left:setPosition(cc.p(self._x+15+self.m_levelCon.lineX,leftHeight*9+_y))
                line_left:setScaleY(8.5-(self.m_levelCon.left[1]-1))
                line_left:setCameraMask(2)
                local line_right = LineElement.new(self.m_levelCon.right)
                self:addChild(line_right,self.m_curZOrder)
                line_right:setAnchorPoint(cc.p(0,1))
                line_right:setScaleX(-1)
                local rightHeight = line_right:getCascadeBoundingBox().size.height
                line_right:setPosition(cc.p(self._x+display.right-15-self.m_levelCon.lineX,rightHeight*9+_y))
                line_right:setScaleY(8.5-(self.m_levelCon.right[1]-1))
                line_right:setCameraMask(2)
                --钢架人
                local steel1 = SpecialElement.new(self.m_levelCon.left,line_left)
                self:addChild(steel1,self.m_curZOrder)
                steel1:setAnchorPoint(cc.p(0,0))
                local size = steel1:getCascadeBoundingBox().size
                local steelY = (self.m_levelCon.left[1]-1)*Room_Size.height
                steel1:setPosition(cc.p(self._x+size.width*0.5+5+self.m_levelCon.lineX,size.height*0.5+16+_y+steelY))
                local steel2 = SpecialElement.new(self.m_levelCon.right,line_right)
                self:addChild(steel2,self.m_curZOrder)
                steel2:setAnchorPoint(cc.p(0,0))
                steel2:setScaleX(-1)
                local steel2Y = (self.m_levelCon.right[1]-1)*Room_Size.height
                steel2:setPosition(cc.p(self._x+display.right-size.width*0.5-5-self.m_levelCon.lineX,size.height*0.5+16+_y+steel2Y))
                steel1:setCameraMask(2)
                steel2:setCameraMask(2)
                self.specialBody[math.floor(self.m_roomsNum/10)] = {}
                table.insert(self.specialBody[math.floor(self.m_roomsNum/10)],steel1)
                table.insert(self.specialBody[math.floor(self.m_roomsNum/10)],steel2)
            end
            
            self.m_curZOrder = self.m_curZOrder + 1
            MAP_ZORDER_MAX = self.m_curZOrder
        end
    end
end

--添加新的房间
--此处为动态添加的房间，不需调整刚体位置，即无需传第三个参数(room:initPosition(_x,_y))
function MapLayer:addNewRooms(parameters)
    
    if self.m_roomsNum % self.runFloorNum == 0 then
--    	local i = math.random(RunningMin,RunningMax)
--    	self.runFloorNum = i
        local k = GameDataManager.getDataIdByWeight()
        Tools.printDebug("brj Hopscotch 横跑组：",k)
        self.m_levelCon = MapRunningConfig[k]
        self.roomType = self.m_levelCon.roomType
        self.floorNum = 0
    else
        if self.m_roomsNum % 10 == 0 then
            local type,config
            if self.m_roomsNum >= Map_Grade.floor_S then
                type = Map_Grade.floor_S
                config = MapGroupConfigS
            elseif self.m_roomsNum >= Map_Grade.floor_A then
                type = Map_Grade.floor_A
                config = MapGroupConfigA
            elseif self.m_roomsNum >= Map_Grade.floor_B then
                type = Map_Grade.floor_B
                config = MapGroupConfigB
            elseif self.m_roomsNum >= Map_Grade.floor_C then
                type = Map_Grade.floor_C
                config = MapGroupConfigC
            else
                type = Map_Grade.floor_D
                config = MapGroupConfigD
            end
            local i = GameDataManager.getDataIdByWeight(type)
            self.m_levelCon = config[i]
            self.roomType = self.m_levelCon.roomType
            self.floorNum = 0
        end 
    end
    
    if self.roomType ~= MAPROOM_TYPE.Running then
        self._x = self.floorPos[self.m_roomsNum].x
        self.floorNum = self.floorNum + 1
    	self:CommonRoomAdd()
    else
        Tools.printDebug("brj Hopscotch 横跑方向：",self.m_levelCon.direction)
        self:RunningRoomAdd(self.m_levelCon.direction)
    end
    
end

function MapLayer:RunningRoomAdd(_dis)

    self.floorNum = self.floorNum + 1
    local _oldRoom
    if self.floorNum <= 2 then
        _oldRoom = self.m_chaceRooms[#self.m_chaceRooms]
    else
        local oldType = RoomBgs[self.m_levelCon.roomBgs[self.floorNum-1]].type
        if oldType~=0 then
            _oldRoom = self.m_chaceRooms[#self.m_chaceRooms]
        else
            _oldRoom = self.m_otherRooms[#self.m_otherRooms]
        end
    end
    local _newRoom
    local _y = 0
    if _oldRoom then
        local newType = RoomBgs[self.m_levelCon.roomBgs[self.floorNum]].type
        if self.floorNum == 1 then
            self._x = self.floorPos[self.m_roomsNum].x
        end
        if newType~=0 or self.floorNum == 1 then
            self.m_roomsNum = self.m_roomsNum + 1
        end
        _newRoom = MapRoom.new(self.floorNum,self.m_levelCon,self.m_roomsNum)
        if _dis == MAPRUNNING_TYPE.Left then
            if self.floorNum == 1 then
                self._x = self._x-_newRoom:getRoomWidth()*0.5
                _y = _oldRoom:getPositionY() + Room_Size.height
            elseif self.floorNum == #self.m_levelCon.roomBgs then
                self._x = self._x + self.m_levelCon.distance
                _y = _oldRoom:getPositionY() + Room_Size.height
            else
                if _newRoom:getRunningRoomFloorType() == 0 then
                    self._x = self._x-_newRoom:getRoomWidth()-_oldRoom:getRoomGap()
                    _y = _oldRoom:getPositionY()
                elseif _newRoom:getRunningRoomFloorType() == 1 then
                    self._x = self._x+_oldRoom:getRoomWidth()-_newRoom:getRoomWidth()-_oldRoom:getRoomGap()
                    _y = _oldRoom:getPositionY() + Room_Size.height
                elseif _newRoom:getRunningRoomFloorType() == 2 then
                    self._x = self._x-_newRoom:getRoomWidth()-_oldRoom:getRoomGap()
                    _y = _oldRoom:getPositionY() + Room_Size.height
                end
            end
        elseif _dis == MAPRUNNING_TYPE.Right then
            if self.floorNum == 1 then
                self._x = self._x+_newRoom:getRoomWidth()*0.5
                _y = _oldRoom:getPositionY() + Room_Size.height
            elseif self.floorNum == #self.m_levelCon.roomBgs then
                self._x = self._x + self.m_levelCon.distance
                _y = _oldRoom:getPositionY() + Room_Size.height
            else
                if _newRoom:getRunningRoomFloorType() == 0 then
                    self._x = self._x+_oldRoom:getRoomWidth()+_oldRoom:getRoomGap()
                    _y = _oldRoom:getPositionY()
                elseif _newRoom:getRunningRoomFloorType() == 1 then
                    self._x = self._x+_oldRoom:getRoomGap()
                    _y = _oldRoom:getPositionY() + Room_Size.height
                elseif _newRoom:getRunningRoomFloorType() == 2 then
                    self._x = self._x+_oldRoom:getRoomWidth()+_oldRoom:getRoomGap()
                    _y = _oldRoom:getPositionY() + Room_Size.height
                end
            end
        end
    else
        _newRoom = MapRoom.new(1)
    end
    self.m_roomNode:addChild(_newRoom,self.m_curZOrder)
    _newRoom:initPosition(self._x,_y)
    _newRoom:setCameraMask(2)

    self.m_curZOrder = self.m_curZOrder + 1
    if self.floorNum == 1 or (_newRoom:getRunningRoomFloorType() and _newRoom:getRunningRoomFloorType()~=0) then
        self.floorPos[self.m_roomsNum] = cc.p(self._x,_y)
    	table.insert(self.m_chaceRooms,_newRoom)
        if #self.m_chaceRooms > MAP_ROOM_MAX then
            local _room = table.remove(self.m_chaceRooms,1)
            _room:dispose()
        end
    else
        table.insert(self.m_otherRooms,_newRoom)
--        Tools.printDebug("brj ----------------------other缓存 ",self.floorNum)
    end
end

function MapLayer:CommonRoomAdd()
    self.m_roomsNum = self.m_roomsNum + 1
    local _oldRoom = self.m_chaceRooms[#self.m_chaceRooms]
    local _newRoom
    local _y = 0
    if _oldRoom then
        _newRoom = MapRoom.new(self.floorNum,self.m_levelCon,self.m_roomsNum)
        _y = _oldRoom:getPositionY() + Room_Size.height
        if self.m_levelCon.roomType == MAPROOM_TYPE.Lean then
            self._x = self._x + self.m_levelCon.distance
        end
        self.floorPos[self.m_roomsNum] = cc.p(self._x,_y)
    else
        _newRoom = MapRoom.new(1)
    end
    self.m_roomNode:addChild(_newRoom,self.m_curZOrder)
    _newRoom:initPosition(self._x,_y)
    _newRoom:setCameraMask(2)
    table.insert(self.m_chaceRooms,_newRoom)

    --特殊房间楼层的钢架
    if self.m_levelCon.roomType == MAPROOM_TYPE.Special and self.floorNum == 1 then
        --钢架线
        local line_left = LineElement.new(self.m_levelCon.left)
        self:addChild(line_left,self.m_curZOrder)
        line_left:setAnchorPoint(cc.p(0,1))
        local leftHeight = line_left:getCascadeBoundingBox().size.height
        line_left:setPosition(cc.p(self._x+15+self.m_levelCon.lineX,leftHeight*9+_y))
        line_left:setScaleY(8.5-(self.m_levelCon.left[1]-1))
        line_left:setCameraMask(2)
        local line_right = LineElement.new(self.m_levelCon.right)
        self:addChild(line_right,self.m_curZOrder)
        line_right:setAnchorPoint(cc.p(0,1))
        line_right:setScaleX(-1)
        local rightHeight = line_right:getCascadeBoundingBox().size.height
        line_right:setPosition(cc.p(self._x+display.right-15-self.m_levelCon.lineX,rightHeight*9+_y))
        line_right:setScaleY(8.5-(self.m_levelCon.right[1]-1))
        line_right:setCameraMask(2)
        --钢架人
        local steel1 = SpecialElement.new(self.m_levelCon.left,line_left)
        self:addChild(steel1,self.m_curZOrder)
        steel1:setAnchorPoint(cc.p(0,0))
        local size = steel1:getCascadeBoundingBox().size
        local steelY = (self.m_levelCon.left[1]-1)*Room_Size.height
        steel1:setPosition(cc.p(self._x+size.width*0.5+5+self.m_levelCon.lineX,size.height*0.5+16+_y+steelY))
        local steel2 = SpecialElement.new(self.m_levelCon.right,line_right)
        self:addChild(steel2,self.m_curZOrder)
        steel2:setAnchorPoint(cc.p(0,0))
        steel2:setScaleX(-1)
        local steel2Y = (self.m_levelCon.right[1]-1)*Room_Size.height
        steel2:setPosition(cc.p(self._x+display.right-size.width*0.5-5-self.m_levelCon.lineX,size.height*0.5+16+_y+steel2Y))
        steel1:setCameraMask(2)
        steel2:setCameraMask(2)
        self.specialBody[math.floor(self.m_roomsNum/10)] = {}
        table.insert(self.specialBody[math.floor(self.m_roomsNum/10)],steel1)
        table.insert(self.specialBody[math.floor(self.m_roomsNum/10)],steel2)
    end

    self.m_curZOrder = self.m_curZOrder + 1

    if #self.m_chaceRooms > MAP_ROOM_MAX then
        local _room = table.remove(self.m_chaceRooms,1)
        _room:dispose()
    end
end

function MapLayer:initPlayerPos(parameters)
    self.m_physicWorld = display.getRunningScene():getPhysicsWorld()
    self:scheduleUpdate()
    self.m_event = cc.EventListenerPhysicsContact:create()
    self.m_event:registerScriptHandler(handler(self,self.collisionBeginCallBack), cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    self:getEventDispatcher():addEventListenerWithFixedPriority(self.m_event,1)
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.onEnterFrame))
end

--帧函数
function MapLayer:onEnterFrame(dt)
    --移动金币
    GameController.attract()
  
    if tolua.isnull(self.m_player) then
        return
    end

    if tolua.isnull(self.m_player.m_body) then
        return
    end

    if self.m_player:isDead() then
        return
    end
    

    local bpx,bpy = self.m_player:getPosition()
    local _size = self.m_player:getSize()
    self.m_player:update(dt,bpx,bpy)
    
    if self.backOrigin then
        local floorPos = self.floorPos[self.jumpFloorNum]
        self.m_player:setPosition(cc.p(bpx,floorPos.y+_size.width*0.5+27))
    end
    
    local x,y = self.m_camera:getPosition()
--    Tools.printDebug("brj--------m_camera---------edgePos: ",x+display.width-Room_Distance.x+_size.width*0.5)
    if bpx <= x+Room_Distance.x-_size.width*0.5 then
        self.m_player:selfDead()
    end
    if  bpx >= x+display.width-Room_Distance.x+_size.width*0.5 then
        self.m_player:selfDead()
    end
    local pos = self.floorPos[self.jumpFloorNum]
    if bpy < pos.y-self.bottomHeight*0.5 then
        self.m_player:selfDead()
    end

    local _scaleX=self.m_player:getScaleX()
    local vel=self.m_player:getBody():getVelocity()
    self.m_player:setVelocity(cc.p(-_scaleX/math.abs(_scaleX)*self.m_player:getSpeed(),vel.y))

    local _body = self.m_player:getBody()
    local _p = _body:getPosition()
    local _veloc = _body:getVelocity()
    local _scaleX = self.m_player:getScaleX()
    local _add = -1*_scaleX/math.abs(_scaleX)  --因为人物默认是向左的，所以乘以-1
    if self.m_player:getJump() then
        self.m_physicWorld:rayCast(handler(self,self.rayCastFunc),cc.p(_p.x,_p.y),cc.p(_p.x,_p.y+_size.height*0.5+Raycast_DisY))
    else
        self.m_physicWorld:rayCast(handler(self,self.rayCastFunc),cc.p(_p.x,_p.y),cc.p(_p.x,_p.y-_size.height*0.5-Raycast_DisY))
    end
    --左右射线检测
    self.m_physicWorld:rayCast(handler(self,self.rayCastFuncX),cc.p(_p.x,_p.y-_size.height*0.25),cc.p(_p.x+_add*(_size.width*0.5+Raycast_DisX),_p.y-_size.height*0.25))
    
    if self.curRoomType == MAPROOM_TYPE.Running then
        if self.curState == State_Type.RunningState then
            local x,y = self.m_player:getPosition()
            local mx,my = self.m_camera:getPosition()
            if _scaleX == 1 then
                if x-display.cx+50 <= mx then
                    self.m_camera:setPositionX(x-display.cx+50)
                    self.bg:setPositionX(x-display.cx+50)
                    self.bgNode:bgLandscapeMove(x-display.cx+50,(x-display.cx+50-mx)*0.95,mx,_scaleX)
                end
            else
                if x-display.cx-50 >= mx then
                    self.m_camera:setPositionX(x-display.cx-50)
                    self.bg:setPositionX(x-display.cx-50)
                    self.bgNode:bgLandscapeMove(x-display.cx-50,(x-display.cx-50-mx)*0.95,mx,_scaleX)
                end
            end
        end
    end
   
    if self.jumpFloorNum == Map_Grade.floor_D then
        self.m_player:changeSpeed(MAP_SPEED.floor_D)
    elseif self.jumpFloorNum == Map_Grade.floor_C then
        self.m_player:changeSpeed(MAP_SPEED.floor_C)
    elseif self.jumpFloorNum == Map_Grade.floor_B then
        self.m_player:changeSpeed(MAP_SPEED.floor_B)
    elseif self.jumpFloorNum == Map_Grade.floor_A then
        self.m_player:changeSpeed(MAP_SPEED.floor_A)
    elseif self.jumpFloorNum == Map_Grade.floor_S then
        self.m_player:changeSpeed(MAP_SPEED.floor_S)
    end
end


--碰撞开始触发
function MapLayer:collisionBeginCallBack(parameters)
    if not GameController.getCollsionEnable() then
        return true
    end
    
    if self.backOrigin then
        return true
    end

    local conData = parameters:getContactData()
    local bodyA = parameters:getShapeA():getBody()
    local bodyB = parameters:getShapeB():getBody()
    local tagA = bodyA:getTag()
    local tagB = bodyB:getTag()
    --    Tools.printDebug("chjh beginCallBack bodyA,bodyB",tostring(bodyA),tostring(bodyB))
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
    
    if (not player) or player:isDead() then
        return true
    end
    if tolua.isnull(obstacle) then
        return false
    end
    
    if obstacleTag == ELEMENT_TAG.FLOOR then
        self.isCollision = true
        if not self.m_player:getJump() and self.curRoomType ~= MAPROOM_TYPE.Running then
            local _size = self.m_player:getSize()
            local bpx,bpy = self.m_player:getPosition()
            local roomIndex = math.ceil((self.m_player:getPositionY()-self.bottomHeight)/Room_Size.height)
            if roomIndex == self.jumpFloorNum then
                local floorPos = self.floorPos[self.jumpFloorNum]
                self.m_player:setPosition(cc.p(bpx,floorPos.y+_size.width*0.5+27))
--                Tools.printDebug("----------brj 碰撞检测------------: ")
            end
        end
    end
    
    local _x = -1
    local _scaleX = player:getScaleX()
    if conData.normal.x < 0 then
        _x = -1
    else
        _x = 1
    end
--    Tools.printDebug("brj------------碰撞tag: ",obstacleTag)
    if obstacleTag==ELEMENT_TAG.WALLLEFT or obstacleTag==ELEMENT_TAG.WALLRIGHT or obstacleTag==ELEMENT_TAG.SPECIAL_TAG then
       if not tolua.isnull(obstacle) then
            local vel=self.m_player:getBody():getVelocity()
            local _size = self.m_player:getSize()
            if playerBP.x+_size.width*0.5<obstacleBP.x then
                player:setVelocity(cc.p(self.m_player:getSpeed(),vel.y))
                player:setScaleX(math.abs(_scaleX))
            else
                player:setVelocity(cc.p(-self.m_player:getSpeed(),vel.y))
                player:setScaleX(-math.abs(_scaleX))
            end
       end
       if obstacleTag==ELEMENT_TAG.SPECIAL_TAG then
            if not tolua.isnull(obstacle) then
            	obstacle:collision()
            end
       end
       self.isCollision = true
    elseif obstacleTag == ELEMENT_TAG.GOOD_TAG then
        if not tolua.isnull(obstacle) then
            obstacle:collision()
        end
    end

    return true
end

--碰撞反射，从人物中心向下或向上发射一个比自身一半多 Raycast_DisY 像素的探测射线，进行检测有无障碍物
function MapLayer:rayCastFunc(_world,_p1,_p2,_p3)
    if self.backOrigin then
        return true
    end

    local _body = _p1.shape:getBody()
    local _bnode = _body:getNode()
    local _tag = _body:getTag()
    local _vo = self.m_player:getVo()
    local _hitP = cc.p(_p1.ended.x,_p1.ended.y)

    if tolua.isnull(_bnode) then
        return false
    end
    if _tag==ELEMENT_TAG.PLAYER_TAG then
        return true
    end
    
    if _tag == ELEMENT_TAG.FLOOR then
        if not self.m_player:getJump() and self.curRoomType ~= MAPROOM_TYPE.Running then
            local _size = self.m_player:getSize()
            local bpx,bpy = self.m_player:getPosition()
            local roomIndex = math.ceil((self.m_player:getPositionY()-self.bottomHeight)/Room_Size.height)
            if roomIndex == self.jumpFloorNum then
                local floorPos = self.floorPos[self.jumpFloorNum]
                self.m_player:setPosition(cc.p(bpx,floorPos.y+_size.width*0.5+27))
            end
        end
        self.isCollision = true
--        Tools.printDebug("----------brj 射线检测------------: ",self.isCollision)
        local roomIndex = math.ceil((self.m_player:getPositionY()-self.bottomHeight)/Room_Size.height)
        if self.m_lastRoomIdx ~= roomIndex then
            local _room = self:getRoomByIdx(roomIndex)
            if _room then
                _room:intoRoom()
                self.curRoomRunType = _room:getRunningRoomFloorType()
                self.curRoomType = _room:getCurRoomType()
                self.curRoomDistance = _room:getRunningDistance()
                self.m_lastRoomIdx = roomIndex
            end
--            Tools.printDebug("brj 当前楼层房间类型： ",self.curRoomType)
            if roomIndex > self.jumpFloorNum then
                self.jumpFloorNum = roomIndex
                GameDataManager.setPoints(self.jumpFloorNum)
                self:addNewRooms()
                if self.curRoomType~=MAPROOM_TYPE.Running then
                    self:toCameraMove()
                else
                    if self.jumpFloorNum % 10 == 1 then
                        self:toCameraMove()
                    else
                        self:toRunCameraMove() 
                    end
                end
            end
            if self.curRoomType==MAPROOM_TYPE.Running then
                self:toRunFirstCameraMove()
            end
        end
        return true
    end

    return true
end

function MapLayer:rayCastFuncX(_world,_p1,_p2,_p3)
    if self.backOrigin then
        return true
    end

    local _body = _p1.shape:getBody()
    local _bnode = _body:getNode()
    local _tag = _body:getTag()
    local _scaleX = self.m_player:getScaleX()
    local playerBP=self.m_player:getBody():getPosition()
    local obstacleBP=_body:getPosition()

    if (not _bnode) or _tag==ELEMENT_TAG.PLAYER_TAG then
        return true
    end
    
    if _tag==ELEMENT_TAG.WALLLEFT or _tag==ELEMENT_TAG.WALLRIGHT or _tag==ELEMENT_TAG.SPECIAL_TAG then
        if not tolua.isnull(_bnode) then
            local vel=self.m_player:getBody():getVelocity()
            local _size = self.m_player:getSize()
            if playerBP.x+_size.width*0.5<obstacleBP.x then
                self.m_player:setVelocity(cc.p(self.m_player:getSpeed(),vel.y))
                self.m_player:setScaleX(math.abs(_scaleX))
            else
                self.m_player:setVelocity(cc.p(-self.m_player:getSpeed(),vel.y))
                self.m_player:setScaleX(-math.abs(_scaleX))
            end
       end
    end

    return true
end

--根据房间编号从缓存中获取房间对象
function MapLayer:getRoomByIdx(_roomIndx)
    for key, var in pairs(self.m_chaceRooms) do
        if var:getRoomIndex() == _roomIndx then
            return var
        end
    end
end

--进行弹跳
function MapLayer:toJump()
    self.m_toJump = true
    local roomIndex = math.ceil((self.m_player:getPositionY()-self.bottomHeight)/Room_Size.height)
    local pos = self.floorPos[roomIndex+1]
    self.m_player:toJump(pos.y,self.isCollision)

end
--摄像机移动
function MapLayer:toCameraMove()
    if self.curRoomType==MAPROOM_TYPE.Running then
        local pos = self.floorPos[self.jumpFloorNum]
        local roomIndex = math.ceil((self.m_player:getPositionY()-self.bottomHeight)/Room_Size.height)
        if roomIndex >= GameDataManager.getPoints() then
            self.m_camera:stopAllActions()
            local mx,my = self.m_camera:getPosition()
            local move = cc.MoveTo:create(0.3,cc.p(mx,pos.y-self.bottomHeight))
            self.m_camera:runAction(move)

            self.bgNode:bgPortraitRunningMove(pos.y,self.bottomHeight,mx)

            self.bg:stopAllActions()
            local move3 = cc.MoveTo:create(0.3,cc.p(mx,pos.y-self.bottomHeight))
            self.bg:runAction(move3)
        end
    else
        self.curState = State_Type.CommonState
        local pos = self.floorPos[self.jumpFloorNum]
        local roomIndex = math.ceil((self.m_player:getPositionY()-self.bottomHeight)/Room_Size.height)
        if roomIndex >= GameDataManager.getPoints() then
            self.m_camera:stopAllActions()
            local mx,my = self.m_camera:getPosition()
            local move = cc.MoveTo:create(0.3,cc.p(pos.x,pos.y-self.bottomHeight))
            self.m_camera:runAction(move)

            self.bgNode:bgPortraitMove(pos,self.bottomHeight,mx)

            self.bg:stopAllActions()
            local move3 = cc.MoveTo:create(0.3,cc.p(pos.x,pos.y-self.bottomHeight))
            self.bg:runAction(move3)
        end 
    end
end

--横跑过程中的摄像机移动
function MapLayer:toRunCameraMove()
    local roomIndex = math.ceil((self.m_player:getPositionY()-self.bottomHeight)/Room_Size.height)
    if roomIndex >= GameDataManager.getPoints() and self.floorNum ~= 1 then
        local pos = self.floorPos[self.jumpFloorNum]
        local mx,my = self.m_camera:getPosition()
        self.m_camera:stopAllActions()
        local move = cc.MoveBy:create(0.3,cc.p(0,pos.y-self.bottomHeight-my))
        self.m_camera:runAction(move)
        
        self.bgNode:toRunCameraMove(pos.y,self.bottomHeight)
        
        local bgx,bgy = self.bg:getPosition()
        self.bg:stopAllActions()
        local move3 = cc.MoveBy:create(0.3,cc.p(0,pos.y-self.bottomHeight-bgy))
        self.bg:runAction(move3)
    end
end

--当横跑第一层时调用
function MapLayer:toRunFirstCameraMove()
	if self.jumpFloorNum % 10 == 1 then
        local pos = self.floorPos[self.jumpFloorNum]
        local _scaleX=self.m_player:getScaleX()
        local mx,my = self.m_camera:getPosition()
        local x,y = self.m_player:getPosition()
        local toX
        if _scaleX == 1 and self.curRoomDistance == MAPRUNNING_TYPE.Left then
            toX = x-display.width
        elseif _scaleX == -1 and self.curRoomDistance == MAPRUNNING_TYPE.Right then
            toX = x
        else
            toX = mx
        end
        if _scaleX == 1 and self.curRoomDistance == MAPRUNNING_TYPE.Left or (_scaleX == -1 and self.curRoomDistance == MAPRUNNING_TYPE.Right) then
            self.m_camera:stopAllActions()
            local moveY = cc.MoveTo:create(0.2,cc.p(mx,pos.y-self.bottomHeight))
            local moveX = cc.MoveTo:create(1,cc.p(toX,pos.y-self.bottomHeight))
            local callfun = cc.CallFunc:create(function()
                self.curState = State_Type.RunningState
                self.runFirstX = self.m_camera:getPositionX()
            end)
            local seq = cc.Sequence:create(moveY,moveX,callfun)
            self.m_camera:runAction(seq)

            self.bg:stopAllActions()
            local moveY = cc.MoveTo:create(0.2,cc.p(mx,pos.y-self.bottomHeight))
            local moveX = cc.MoveTo:create(1,cc.p(toX,pos.y-self.bottomHeight))
            local seq = cc.Sequence:create(moveY,moveX)
            self.bg:runAction(seq)

            self.bgNode:toRunYtoXMove(pos.y,self.bottomHeight,toX,mx)

        end
    elseif self.jumpFloorNum % 10 == 9 then
        self.curState = State_Type.CommonState
        local pos = self.floorPos[self.jumpFloorNum+1]
        local _scaleX=self.m_player:getScaleX()
        local mx,my = self.m_camera:getPosition()
        self.m_camera:stopAllActions()
        local moveY = cc.MoveTo:create(0.5,cc.p(pos.x,pos.y-self.bottomHeight))
        local moveX = cc.MoveTo:create(0.5,cc.p(pos.x,my))
        local seq = cc.Sequence:create(moveX,moveY)
        self.m_camera:runAction(seq)
        self.bg:stopAllActions()
        local moveY = cc.MoveTo:create(0.5,cc.p(pos.x,pos.y-self.bottomHeight))
        local moveX = cc.MoveTo:create(0.5,cc.p(pos.x,my))
        local seq = cc.Sequence:create(moveX,moveY)
        self.bg:runAction(seq)
        
        self.bgNode:toRunXtoYMove(pos,self.bottomHeight,my)

    elseif self.jumpFloorNum % 10 == 10 then
        local removeCount = #self.m_otherRooms
        for var=1, removeCount do
            local _room = table.remove(self.m_otherRooms,1)
            _room:dispose()
        end
    end
end

--回到起始点
function MapLayer:backOriginFunc()
    self.backOrigin = true
    GameDataManager.resetPoints()
    GameDataManager.resetGameDiamond()
    local removeCount = 0
    if #self.m_chaceRooms > MAP_ROOM_INIT_NUM then
        removeCount = #self.m_chaceRooms - MAP_ROOM_INIT_NUM
        self.m_roomsNum = self.m_roomsNum - removeCount
    end
    for var=1, removeCount do
        local _room = table.remove(self.m_chaceRooms,#self.m_chaceRooms)
        _room:dispose()
    end
    self.jumpFloorNum = 1
    local _size = self.m_player:getSize()
    local floorPos = self.floorPos[self.jumpFloorNum]
    self.m_player:addLifeNum(1)
    self.m_player:setPosition(cc.p(display.cx,self.bottomHeight+_size.width*0.5+27))
    
    self.m_camera:stopAllActions()
    local move = cc.MoveTo:create(0.5,cc.p(0,0))
    self.m_camera:runAction(move)
    
    self.bgNode:toBackOrigin()
    
    Tools.delayCallFunc(1,function()
        self.backOrigin = false
        self.m_player:setDeadReback()
    end)
    Tools.printDebug("----------brj 摄像机坐标：",self.m_camera:getPosition())

end

--销毁特殊刚体
function MapLayer:disposeSpecial(_typeNum)
    if self.specialBody[_typeNum] then
        for key, var in pairs(self.specialBody[_typeNum]) do
            if not tolua.isnull(var) then
--                Tools.printDebug("brj 跳房子 ：",_typeNum)
                var:dispose()
            end
        end
        self.specialBody[_typeNum] = {}
    end
end


--地图销毁
function MapLayer:dispose(parameters)
    --移除碰撞事件
    self:getEventDispatcher():removeEventListener(self.m_event)
    --移除帧事件
    self:removeNodeEventListenersByEvent(cc.NODE_ENTER_FRAME_EVENT)
    --移除其它事件
--    GameDispatcher:removeListenerByName(EventNames.EVENT_BACK_ORIGIN)


    if self.m_player then
        self.m_player:dispose()
    end

    for key, var in ipairs(self.m_chaceRooms) do
        if not tolua.isnull(var) then
            var:dispose()
        end
    end
    
    for key, var in ipairs(self.m_otherRooms) do
        if not tolua.isnull(var) then
            var:dispose()
        end
    end
    
    for key, var in pairs(self.specialBody) do
    	for k, v in pairs(var) do
    		if not tolua.isnull(v) then
    			v:dispose()
    		end
    	end
    end

    GameDataManager.resetPoints()
    GameDataManager.resetGameDiamond()
    
    GameController.clearRooms()
    GameController.clearBody()
    self:removeFromParent(true)
end

return MapLayer