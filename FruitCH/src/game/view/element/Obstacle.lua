--[[
障碍类
]]

local BaseElement = require("game.view.element.BaseElement")
local Obstacle=class("Obstacle",BaseElement)    

local Scheduler = require("framework.scheduler")
local PhysicSprite=require("game.custom.PhysicSprite")
local Special_MATERIAL=cc.PhysicsMaterial(0,0,0)
local ObstacleVo = require("game.data.ObstacleVo")

local Flash_Skeep_Time = 0.25
local Delay_Time = 1.5

function Obstacle:ctor(id,py)
    Obstacle.super.ctor(self)
	
    local obCon = ObstacleConfig[id]
    if obCon then
        self:makeVo(obCon)
        self.m_id=obCon.id
        self.m_posY = py
        self.obcon = nil
        local _size = nil
        local offset = cc.p(0,0)
        
        if obCon.isAnimate then
            ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("armature/"..obCon.armatureName.."0.png", "armature/"..obCon.armatureName.."0.plist" , "armature/"..obCon.armatureName..".ExportJson" )
            self.obcon = ccs.Armature:create(obCon.armatureName)
            self:addChild(self.obcon)
            
            _size = cc.size(self.obcon:getCascadeBoundingBox().size.width*0.8,self.obcon:getCascadeBoundingBox().size.height*0.8)
        
            self:addBody(obCon,_size,offset)
        else
            self.obcon= PhysicSprite.new(obCon.res)
            self:addChild(self.obcon)
            
            _size = cc.size(self.obcon:getCascadeBoundingBox().size.width*0.9,self.obcon:getCascadeBoundingBox().size.height*0.9)
            offset = cc.p(30,40)
            if self.m_vo.m_type == OBSTACLE_TYPE.ice then
                _size = cc.size(self.obcon:getCascadeBoundingBox().size.width*0.9,self.obcon:getCascadeBoundingBox().size.height*0.1)
                offset = cc.p(30,2)
            elseif self.m_vo.m_type == OBSTACLE_TYPE.spring then
                _size = cc.size(self.obcon:getCascadeBoundingBox().size.width*0.2,self.obcon:getCascadeBoundingBox().size.height*0.2)
                offset = cc.p(30,2)
            end       
            self:addBody(obCon,_size,offset)

            if self.m_vo.m_type == OBSTACLE_TYPE.fly then
                local roCount = 0
                local function toRotation()
                    roCount = roCount + 1
                    transition.rotateTo(self.obcon,{time=0.1,rotate=360*roCount,onComplete=function()
                        toRotation()
--                        Tools.printDebug("----------------------roCount:",roCount)
                    end})
                end
                toRotation()
  
                self.tip_1 = display.newSprite("ui/obscale_tip_2.png"):addTo(GameController.getCurMap())
                self.tip_1:setPosition(cc.p(display.cx,self.m_posY))
                self.tip_2 = display.newSprite("ui/obscale_tip_1.png"):addTo(GameController.getCurMap())
                self.tip_2:setPosition(cc.p(display.width-80,self.m_posY))
            end
            
        end
        
        self.obcon:setAnchorPoint(cc.p(0,0))
        
        ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("armature/xiaoshi0.png", "armature/xiaoshi0.plist" , "armature/xiaoshi.ExportJson" )
        self.m_dEffect = ccs.Armature:create("xiaoshi")
        self:addChild(self.m_dEffect)
        self.m_dEffect:setVisible(false)
        self.m_dEffect:getAnimation():setMovementEventCallFunc(handler(self,self.armatureMoveEvent))

        if self.m_vo.m_type ~= OBSTACLE_TYPE.fly and self.m_vo.m_type ~= OBSTACLE_TYPE.special and self.m_vo.m_type ~= OBSTACLE_TYPE.ice then
            if self.m_posY>display.cy then
                self:setScaleY(-1)
            else
                self:setScaleY(1)
            end
        end
        
        if self.m_timer then
            Scheduler.unscheduleGlobal(self.m_timer)
            self.m_timer = nil
        end
        if self.m_vo.m_type == OBSTACLE_TYPE.hide or self.m_vo.m_type == OBSTACLE_TYPE.fly then
            self.m_timer = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),0.01)
            self:setVisible(false)
            if not tolua.isnull(self.tip_1) then
            	self.tip_1:setVisible(false)
            end
            if not tolua.isnull(self.tip_2) then
                self.tip_2:setVisible(false)
            end
        end
        
        if self.m_vo.m_type == OBSTACLE_TYPE.fly then
            GameDispatcher:addListener(EventNames.EVENT_OBSCALE_FLYPAUSE,handler(self,self.flyPause))
            GameDispatcher:addListener(EventNames.EVENT_OBSCALE_FLYRESUM,handler(self,self.flyResum))
        end
        
    end
	
end

function Obstacle:addBody(obcon,size,_offset)
    self.m_body=cc.PhysicsBody:createBox(size,Special_MATERIAL,_offset)
    self.m_body:setCategoryBitmask(0x1111)
    self.m_body:setContactTestBitmask(0x1111)
    self.m_body:setCollisionBitmask(0x0000)
    self.m_body:setDynamic(false)
    self.m_body:setTag(ELEMENT_TAG.OBSTACLE)
    self:setPhysicsBody(self.m_body)
end

--转化为数据对象
function Obstacle:makeVo(_obconfig)
    self.m_obCon = _obconfig
    if _obconfig then
        self.m_vo = clone(ObstacleVo)
        self.m_vo.m_id = _obconfig.id   --障碍id
        self.m_vo.m_type = _obconfig.type     --类型
        self.m_vo.m_time = _obconfig.time  
        self.m_vo.m_att = _obconfig.att 
        self.m_vo.m_dispx = _obconfig.dispx
        self.m_vo.m_speed =  _obconfig.speed
        self.m_vo.m_cutSpeed = _obconfig.cutSpeed
        self.m_vo.m_length = _obconfig.length
    end
end

--获取对象数据
function Obstacle:getVo()
    return self.m_vo
end

function Obstacle:onEnterFrame(parameters)
    local x,y = self:getPosition()
    local point = self:getParent():convertToWorldSpace(cc.p(x,y))
    local px,py = GameController.getCurPlayer():getPosition()
    if point.x <= display.right+400 then
        if self.m_vo.m_type == OBSTACLE_TYPE.fly and MoveSpeed~=0 then
            self:setVisible(true)
            if self.m_timer then
                Scheduler.unscheduleGlobal(self.m_timer)
                self.m_timer = nil
            end
            if not tolua.isnull(self.tip_1) then
                self.tip_1:setVisible(true)
            end
            if not tolua.isnull(self.tip_2) then
                self.tip_2:setVisible(true)
            end
            self:executeMove()
        end
    end
    if point.x-px <= self.m_vo.m_dispx and self.m_vo.m_type == OBSTACLE_TYPE.hide then
        self:setVisible(true)
        if self.m_timer then
            Scheduler.unscheduleGlobal(self.m_timer)
            self.m_timer = nil
        end
    end
end

--飞行障碍物执行飞行动画
function Obstacle:executeMove(parameters)
    local _speed
    if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode then
    	_speed = SelectLevel[GameDataManager.getCurLevelId()].speed
    elseif GAME_TYPE_CONTROL == GAME_TYPE.EndlessMode then
        _speed = EndlessMode.speed
    end
    local fadeOut = cc.FadeOut:create(Flash_Skeep_Time/(MoveSpeed/_speed))
    local fadeIn = cc.FadeIn:create(Flash_Skeep_Time/(MoveSpeed/_speed))
    local sqes = cc.Sequence:create(fadeOut,fadeIn)
    local repeated = cc.Repeat:create(sqes,3)
    local callfunc = cc.CallFunc:create(function()
        transition.stopTarget(self.tip_1)
        if not tolua.isnull(self.tip_1) then
            self.tip_1:removeFromParent()
        end
        if not tolua.isnull(self.tip_2) then
            self.tip_2:removeFromParent()
        end
        transition.moveBy(self,{time=self.m_vo.m_speed,x=-display.width-200,y=0,onComplete=function()
            self:dispose()
        end})
    end)
    local seque = cc.Sequence:create(repeated,callfunc)
    self.tip_1:runAction(seque)
end

function Obstacle:flyPause(parameters)
    if not tolua.isnull(self.tip_1) and self.tip_1:isVisible() then
        transition.pauseTarget(self.tip_1)
	end
    transition.pauseTarget(self)
end

function Obstacle:flyResum(parameters)
    if not tolua.isnull(self.tip_1) and self.tip_1:isVisible() then
        transition.resumeTarget(self.tip_1)
    end
    transition.resumeTarget(self)
end

function Obstacle:armatureMoveEvent(armatureBack,movementType,movementID)
    if movementID == "xiaoshi" and movementType==ccs.MovementEventType.complete then   
        if not tolua.isnull(self) then
            self:dispose()
        end
	end
end

function Obstacle:collision(_type)
    if self.m_vo.m_type == OBSTACLE_TYPE.special then
        GameDispatcher:dispatch(EventNames.EVENT_PLAYER_ATTACKED,{isSpecial = true,att = self.m_vo.m_att})
    elseif self.m_vo.m_type == OBSTACLE_TYPE.ice then
        GameDispatcher:dispatch(EventNames.EVENT_SLOW_SPEED,{cutSpeed = self.m_vo.m_cutSpeed,length = self.m_vo.m_length})
    elseif self.m_vo.m_type == OBSTACLE_TYPE.spring then
        GameDispatcher:dispatch(EventNames.EVENT_OBSCALE_SPRING)
    else
        if GameController.isInState(PLAYER_STATE.Defence) or GameController.isInState(PLAYER_STATE.StartProtect) then
            GameDispatcher:dispatch(EventNames.EVENT_PLAYER_ATTACKED,{isSpecial = false,att = self.m_vo.m_att})
            self.obcon:setVisible(false)
            self.m_dEffect:setVisible(true)
            self.m_dEffect:getAnimation():play("xiaoshi",0,0)
            if self.m_vo.m_type == OBSTACLE_TYPE.fly then
                self:stopAllActions()
            end
            return
        end
        if GameController.getCurPlayer():getJumpState() then
                self.obcon:setVisible(false)
                self.m_dEffect:setVisible(true)
                self.m_dEffect:getAnimation():play("xiaoshi",0,0)
                if self.m_vo.m_type == OBSTACLE_TYPE.fly then
                	self:stopAllActions()
                end
        	return
        end
        GameDispatcher:dispatch(EventNames.EVENT_PLAYER_ATTACKED,{isSpecial = false,att = self.m_vo.m_att})
    end
    
    --        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Obstacle_Sound)
end

function Obstacle:dispose(parameters)
    GameDispatcher:removeListenerByName(EventNames.EVENT_OBSCALE_FLYPAUSE)
    GameDispatcher:removeListenerByName(EventNames.EVENT_OBSCALE_FLYRESUM)
    
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
    if not tolua.isnull(self.tip_1) then
        self.tip_1:removeFromParent()
    end
    if not tolua.isnull(self.tip_2) then
        self.tip_2:removeFromParent()
    end
    
    if not tolua.isnull(self.m_dEffect) then
        self.m_dEffect:removeFromParent()
    end

    self.super.dispose(self)
end

return Obstacle