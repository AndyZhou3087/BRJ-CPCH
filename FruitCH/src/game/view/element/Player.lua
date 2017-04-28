local LiveThing = import(".LiveThing")
local Player = class("Player", LiveThing)

local Special_MATERIAL=cc.PhysicsMaterial(0,0,0)
local BuffState = require("game.view.element.BuffState")
local Scheduler = require("framework.scheduler")

local Flash_Skeep_Time = 0.1 --闪动间隔

local FrameCount = 25

---人物类
function Player:ctor()
    Player.super.ctor(self)
    self.m_vo = GameDataManager.getPlayerVo()
    self.m_hp = self.m_vo.m_hp

    self.m_buffArr = {} --buff列表

    --角色死亡
    self.m_isDead = false
    GameController.isWin = false
    
    self.m_jump = false
    self.m_run = true
    self.touchCount = 0
    
    self.m_curModle = GameDataManager.getFightRole()
    local modle = RoleConfig[self.m_curModle].armatureName
    self:createModle(modle)

    self.p_siz=cc.size(80,110)--角色本身区域限定
    self.pSize = cc.size(60,100)--与障碍物碰撞区域
    self.p_offset = cc.p(20,50)
    self:addBody(self.p_offset,self.pSize)
    
    self.m_twoJump = false
    self.m_isMagnet = false
    local actSkill = RoleConfig[self.m_curModle].skillAct
    for var=1, #actSkill do
        if actSkill[var].type == PLAYER_ACT_TYPE.Twojump then
    		self.m_twoJump = true
        elseif actSkill[var].type == PLAYER_ACT_TYPE.Magnet then
            self:magnetSkill(actSkill[var].radius)
        elseif actSkill[var].type == PLAYER_ACT_TYPE.Protect then
            self:protectSkill()
    	end
    end
    
    --控制随机数种子
    math.randomseed(tostring(os.time()):reverse():sub(1, #RoleConfig))
    
    --受伤害
    GameDispatcher:addListener(EventNames.EVENT_PLAYER_ATTACKED,handler(self,self.playerAttacked))
    --开局冲刺
    GameDispatcher:addListener(EventNames.EVENT_START_SPRINT,handler(self,self.sprinting))
    --死亡冲刺
    GameDispatcher:addListener(EventNames.EVENT_DEAD_SPRINT,handler(self,self.deadSprint))
    --开局护盾
    GameDispatcher:addListener(EventNames.EVENT_START_PROTECT,handler(self,self.startProtect))
    --死亡接力
    GameDispatcher:addListener(EventNames.EVENT_DEAD_RELAY,handler(self,self.deadRelay))
    --吸铁石
    GameDispatcher:addListener(EventNames.EVENT_MANGET,handler(self,self.manget))
    --巨人药水
    GameDispatcher:addListener(EventNames.EVENT_GRANT_DRINK,handler(self,self.grantDrink))
    --极限冲刺
    GameDispatcher:addListener(EventNames.EVENT_LIMIT_SPRINT,handler(self,self.limitSprint))
    --金币转换
    GameDispatcher:addListener(EventNames.EVENT_TRANSFORM_GOLD,handler(self,self.transformGold))
    --速度减慢
    GameDispatcher:addListener(EventNames.EVENT_SLOW_SPEED,handler(self,self.slowSpeed))
    --弹簧
    GameDispatcher:addListener(EventNames.EVENT_OBSCALE_SPRING,handler(self,self.spring))
    --游戏内护盾
    GameDispatcher:addListener(EventNames.EVENT_GAME_PROTECT,handler(self,self.gameProtect))
    

    --角色暂停和恢复
    GameDispatcher:addListener(EventNames.EVENT_PLAYER_PAUSE,handler(self,self.pause))
    GameDispatcher:addListener(EventNames.EVENT_PLAYER_REGAIN,handler(self,self.regain))
    --角色复活
    GameDispatcher:addListener(EventNames.EVENT_ROLE_REVIVE,handler(self,self.revive))

end

--创建人物模型动画[_place:角色位置]
function Player:createModle(_actionName)
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("role/".._actionName.."0.png", "role/".._actionName.."0.plist" , "role/".._actionName..".ExportJson" )

    self.m_armature = ccs.Armature:create(_actionName)
    self:addChild(self.m_armature)
    self:setAnchorPoint(cc.p(0,0))
    self.m_animation = self.m_armature:getAnimation()
    self.m_animation:setSpeedScale(MoveSpeed*0.01)
    self:toPlay(PLAYER_ACTION.Run)
    self.m_animation:setMovementEventCallFunc(handler(self,self.armatureMoveEvent))
    self.m_animation:setFrameEventCallFunc(handler(self,self.onActionFrameEvent))
end


function Player:addBody(_offset,size)
    self.m_body=cc.PhysicsBody:createBox(size,Special_MATERIAL,_offset)
    self.m_body:setCategoryBitmask(0x1101)
    self.m_body:setContactTestBitmask(0x1111)
    self.m_body:setCollisionBitmask(0x1111)
    self.m_body:setDynamic(true)
    self.m_body:setTag(ELEMENT_TAG.PLAYER_TAG)
    self:setPhysicsBody(self.m_body)
end


function Player:onActionFrameEvent(_bone,_evt,_begin,_end)
    if _evt == nil then
        return
    end

    -- if _evt == "run_over" then
    --     if not self:isInState(PLAYER_STATE.WalkMachine) then
    --         self.m_runNum = self.m_runNum+1
    --         if self.m_runNum == 6 then
    --             self.m_runNum=0
    --             self:toPlay(PLAYER_ACTION.Run_Two)
    --         end
    --     else
    --         self.m_FireNum = self.m_FireNum+1
    --         if self.m_FireNum == GoodsConfig[2].interval_time then
    --             self.m_FireNum=0
    --             if not tolua.isnull(self.m_fireBone) then
    --                 self.m_fireBone:updateDisplayedOpacity(0)
    --                 self.m_walkFire:setVisible(true)
    --                 self:delayShow(self.m_fireBone)
    --             end
    --             WalkFire_State = true
    --         end
    --     end
    --     return
    -- end
end

--角色动画桢函数回调
function Player:armatureMoveEvent(armatureBack,movementType,movementID)
    if movementID==PLAYER_ACTION.Jump and movementType==ccs.MovementEventType.complete then
        self:toPlay(PLAYER_ACTION.Attack,0)
    elseif movementID==PLAYER_ACTION.Attack and movementType==ccs.MovementEventType.complete then
--        self:toPlay(PLAYER_ACTION.Down,0)
--    elseif movementID==PLAYER_ACTION.Down and movementType==ccs.MovementEventType.complete then
        self:toPlay(PLAYER_ACTION.Run)
        self.m_jump = false
        self.m_run = true
    end
end

--获取对象数据
function Player:getVo()
    return self.m_vo
end

function Player:isDead(parameters)
	return self.m_vo.m_hp<=0
end


--闯关胜利后滑行一段距离
function Player:LevelWin()
    GameController.isWin = true
    
    --清除所有buff
    for var=#self.m_buffArr,1,-1  do
        local _buff = self.m_buffArr[var]
        if _buff then
            self:clearBuff(_buff:getType())
        end
    end
    self.m_buffArr = {}
    MoveSpeed = 0
    
    transition.moveTo(self,{time = 1,x=display.right+100,y=self:getPositionY(),onComplete=function()
        self:dispose()
        if DataPersistence.getAttribute("first_into") then
            DataPersistence.updateAttribute("first_into",false)
        	app:enterMainScene()
        else
            --弹结算界面
            GameDispatcher:dispatch(EventNames.EVENT_OPEN_OVER,{type=GAMEOVER_TYPE.Win})
        end
    end})
end

--重置角色状态
function Player:reSetUD()
    self.m_jump = false
    self.m_run = true
end

--角色动画切换(_place:角色位置,_animation动画名称)
function Player:toPlay(_actionName,loop)
    if not self.m_twoJump and self.m_jump and _actionName == PLAYER_ACTION.Jump and not self:isInState(PLAYER_STATE.Spring) 
        and not self.clickJump then
        Tools.printDebug("---------动画被挡了")
    	return
    end
    local _loop = loop or 1
    self.m_animation:play(_actionName,0,_loop)
    Tools.printDebug("Fruit PaoKu 角色跳跃:",_actionName)
    if _actionName==PLAYER_ACTION.Run then
        self:reSetUD()
    end
end

function Player:clickJumpfunc()
    if self.playerY and self.m_jump and ((self.playerY<display.cy and self:getPositionY()>= display.cy+170-self:getAreaSize().height*0.5) or 
        (self.playerY>display.cy and self:getPositionY()<= display.cy-190+self:getAreaSize().height*0.5)) then
        self.clickJump = true
        Tools.printDebug("---------缓冲区域二次点击")
    else
        self.clickJump = false
    end
end

--角色移动
function Player:toMove(isSpring)
    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Jump_Sound)
    if self.backHandler then
        Scheduler.unscheduleGlobal(self.backHandler)
        self.backHandler=nil
    end
    
    if self:isInState(PLAYER_STATE.Slow) then
        self:clearBuff(PLAYER_STATE.Slow)
    end

    self.touchCount = self.touchCount + 1
    if self.touchCount == 1 then
        self.playerY = self:getPositionY()
    end
    if self.touchCount > 1 then
        self.roleY = self:getPositionY()
    end
    local frameSpeed = MoveSpeed
    if MoveSpeed >= 100 then
        frameSpeed = 100
    end
    if not self.m_jump then
        self.m_jump = true
        self.m_run = false
        local direction = 1
        if self:getPositionY()<display.cy then
            direction = 1
        else
            direction = -1
        end
        transition.moveBy(self,{time=FrameCount/frameSpeed,x=0,y=direction*(440-self:getAreaSize().height*0.5),onComplete=function()
            self.m_jump = false
            self.m_run = true
            self.touchCount = 0
            self:setScaleY(direction*-1)
            if self:getScaleY() == -1 then
                local x,y = self:getPosition()
                self:setPositionY(y+self:getAreaSize().height*0.5)
            else
                local x,y = self:getPosition()
                self:setPositionY(y-self:getAreaSize().height*0.5)
            end
        end})
    else
        if self.touchCount == 2 and (self.m_twoJump or isSpring or self.clickJump) then
            Tools.printDebug("---------缓冲区域二次点击hhhhhhhhhhhhhhhh")
            self:stopAllActions()
            local direction = 1
            local m_pY
            if self.playerY<display.cy then
                direction = 1
                m_pY = display.cy-240+self:getAreaSize().height*0.5
            else
                direction = -1
                m_pY = display.cy+200-self:getAreaSize().height*0.5
            end
            transition.moveTo(self,{time=FrameCount/frameSpeed,x=self:getPositionX(),y=m_pY,onComplete = function()
                self.clickJump = false
                self.m_jump = false
                self.m_run = true
                self.touchCount = 0
                self:setScaleY(direction)
                if direction == -1 then
                    local x,y = self:getPosition()
                    self:setPositionY(y+self:getAreaSize().height*0.5)
                else
                    local x,y = self:getPosition()
                    self:setPositionY(y-self:getAreaSize().height*0.5)
                end
                if self:isInState(PLAYER_STATE.Spring) then
                    self:clearBuff(PLAYER_STATE.Spring)
                end
            end})
        elseif self.touchCount > 2 and isSpring then
            self:stopAllActions()
            local direction = 1
            local m_pY
            if self.roleY<display.cy then
                direction = -1
                m_pY = display.cy+200-self:getAreaSize().height*0.5
            else
                direction = 1
                m_pY = display.cy-240+self:getAreaSize().height*0.5
            end
            transition.moveTo(self,{time=FrameCount/frameSpeed,x=self:getPositionX(),y=m_pY,onComplete = function()
                self.m_jump = false
                self.m_run = true
                self.touchCount = 0
                self:setScaleY(direction)
                if direction == -1 then
                    local x,y = self:getPosition()
                    self:setPositionY(y+self:getAreaSize().height*0.5)
                else
                    local x,y = self:getPosition()
                    self:setPositionY(y-self:getAreaSize().height*0.5)
                end
                if self:isInState(PLAYER_STATE.Spring) then
                    self:clearBuff(PLAYER_STATE.Spring)
                end
            end})
        end
    end
    
end

--获取状态
function Player:getJumpState(parameters)
    return self.m_jump
end

--获取角色刚体大小
function Player:getSize(parameters)
    return self.p_siz
end

function Player:getAreaSize(parameters)
    return self.p_siz
end

function Player:getOffset(parameters)
    return self.p_offset
end

function Player:update(dt,_x,_y)
    if self.m_propManget then
        GameController.detect(self,cc.p(_x,_y),self.m_propRadius)
    elseif self.startSprintManget then
        GameController.detect(self,cc.p(_x,_y),self.startSprintRadius)
    elseif self.deadSprintManget then
        GameController.detect(self,cc.p(_x,_y),self.deadSprintRadius)
    elseif self.limitSprintManget then
        GameController.detect(self,cc.p(_x,_y),self.limitSprintRadius)
    elseif self.m_isMagnet then
        GameController.detect(self,cc.p(_x,_y),self.m_radius)
    end
    
    if self.originPos and self:getPositionX()<self.originPos.x and not self.backHandler then
        local x,y = self:getPosition()
        self:setPositionX(x+MoveSpeed*0.1)
    end
    
    --冲刺时消除障碍物
    if self:isInState(PLAYER_STATE.StartSprint) or self:isInState(PLAYER_STATE.DeadSprint) or self:isInState(PLAYER_STATE.LimitSprint) then
    	self:clearObstales()
    end
end

--全屏清除障碍物
function Player:clearObstales(parameters)
    local allObstales = GameController.getScreenObstacles()
    for key, var in pairs(allObstales) do
        if var:getVo().m_type == OBSTACLE_TYPE.fly or var:getVo().m_type == OBSTACLE_TYPE.hide or var:getVo().m_type == OBSTACLE_TYPE.static
            or var:getVo().m_type == OBSTACLE_TYPE.special then
            var:removeSelf()
        end
	end
end

--====================角色buff=================
--角色受伤害
function Player:playerAttacked(parm)
    if self:isInState(PLAYER_STATE.StartProtect) then
        self:clearBuff(PLAYER_STATE.StartProtect)
        return
    end
    if self:isInState(PLAYER_STATE.Defence) then
    	self:clearBuff(PLAYER_STATE.Defence)
    	return
    end
    if self:isInState(PLAYER_STATE.GameDefence) then
        self:clearBuff(PLAYER_STATE.GameDefence)
        return
    end
    if self:isInState(PLAYER_STATE.StartSprint) or self:isInState(PLAYER_STATE.DeadSprint) then
        return
    end
    if self:isInState(PLAYER_STATE.LimitSprint) then
        return
    end
    
    self.m_hp = self.m_hp - parm.data.att
    if self.m_hp <= 0 then
        Tools.printDebug("------------角色死亡..")
        self:deadSprintFlash()
    end
end

function Player:deadSprintFlash(parameters)
	if GameController.getStartPropById(2) then
        GameDataManager.useGoods(2)
    else
        self:deadContinueFlash()
    end
end

function Player:deadContinueFlash()
	if GameController.getStartPropById(4) then
        GameDataManager.useGoods(4)
    else
        self:deadFlash()
    end
end

--
function Player:deadFlash()
    self:death()
    --复活界面
    GameDispatcher:dispatch(EventNames.EVENT_REVIVE_VIEW,{animation = true})
end

--角色死亡
function Player:death()

    if GameDataManager.getFightRole() == 2 then
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.RoleWomen_Dead)
    else
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.RoleMan_Dead)
    end

    self:stopAllActions()
    self:toPlay(PLAYER_ACTION.Down)
    
    --背景和障碍停止移动
    MoveSpeed = 0
--        self:getParent():toDelay()

    self.m_isDead = true
    GameController.isDead = true
    self.m_armature:setVisible(false)

    --清除所有buff
    for var=#self.m_buffArr,1,-1  do
        local _buff = self.m_buffArr[var]
        if _buff then
            self:clearBuff(_buff:getType())
        end
    end
    self.m_buffArr = {}

end

--角色复活
function Player:revive(parameters)

    --清除所有状态
    for var=#self.m_buffArr,1,-1  do
        local _buff = self.m_buffArr[var]
        if _buff~=nil then
            self:clearBuff(_buff:getType())
        end
    end
    self.m_buffArr = {}

    self.m_hp = self.m_vo.m_hp
    self.m_armature:setVisible(true)
--    Tools.printDebug("----------------角色scale：",self.m_jump)
    if self.m_jump and self:getScaleY() == -1 then
        self:setScaleY(1)
        self:setPosition(display.cx-100,display.cy-240)
    elseif self.m_jump and self:getScaleY() == 1 then
        self:setScaleY(-1)
        self:setPosition(display.cx-100,display.cy+200)
    end
    if self.originScaleY then
        self:setScaleY(self.originScaleY)
    end
    if self.originPos then
        self:setPosition(self.originPos)
    end
    
    self:toPlay(PLAYER_ACTION.Run)
    
    self.m_isDead = false
    GameController.isWin = false
    GameController.isDead = false
    GameController.isWin = false
    self.m_jump = false
    self.m_run = true

    self.m_twoJump = false
    self.m_isMagnet = false
    local actSkill = RoleConfig[self.m_curModle].skillAct
    for var=1, #actSkill do
        if actSkill[var].type == PLAYER_ACT_TYPE.Twojump then
            self.m_twoJump = true
        elseif actSkill[var].type == PLAYER_ACT_TYPE.Magnet then
            self:magnetSkill(actSkill[var].radius)
        elseif actSkill[var].type == PLAYER_ACT_TYPE.Protect then
            self:protectSkill()
        end
    end
    
    GameController.resumeGame(true)
    self:clearObstales()
end

--巨人药水
function Player:grantDrink(parameters)
    Tools.printDebug("----------巨人药水")
    if self:isInState(PLAYER_STATE.GrankDrink) then
        return
    end

    local _lv = GameDataManager.getRoleLevel(self.m_curModle)
    local _time = parameters.data.time+GameDataManager.getUnActSkillTime(self.m_curModle,_lv,GOODS_TYPE.GrantDrink)
    self:addBuff({type=PLAYER_STATE.GrankDrink,time = _time})
    self.m_grankHandler = Tools.delayCallFunc(parameters.data.time,function()
        self:clearBuff(PLAYER_STATE.GrankDrink)
    end)
    GameDataManager.setGamePropTime(PLAYER_STATE.GrankDrink,_time)

    self.m_armature:setScale(parameters.data.scale)
    self.m_body:removeFromWorld()
    local _size = cc.size(self.m_armature:getCascadeBoundingBox().size.width*0.6*parameters.data.scale,
        self.m_armature:getCascadeBoundingBox().size.height*parameters.data.scale*0.7)

    if self:isInState(PLAYER_STATE.StartSprint) or self:isInState(PLAYER_STATE.DeadSprint) then
        self:setPosition(cc.p(display.cx,display.cy-50))
        self:addBody(cc.p(10,80),_size)
    else
        if self:getScaleY() == 1 then
            self:addBody(cc.p(10,80),_size)
        else
            self:addBody(cc.p(10,-80),_size)
        end
    end
end

--吸铁石
function Player:manget(parameters)
	Tools.printDebug("--------吸铁石道具")
	if self:isInState(PLAYER_STATE.MagnetProp) then
        return
	end
    if self:isInState(PLAYER_STATE.Magnet) then
        return
    end
    
	self.m_propManget = true
    self.m_propRadius = parameters.data.radius
    
    local _lv = GameDataManager.getRoleLevel(self.m_curModle)
    local _time = parameters.data.time+GameDataManager.getUnActSkillTime(self.m_curModle,_lv,GOODS_TYPE.Magnet)
    self:addBuff({type=PLAYER_STATE.MagnetProp,time = _time})
    self.m_manHandler = Tools.delayCallFunc(parameters.data.time,function()
        self:clearBuff(PLAYER_STATE.MagnetProp)
    end)
    
    --特效
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("armature/xitieshi0.png", "armature/xitieshi0.plist" , "armature/xitieshi.ExportJson")
    self.m_manget = ccs.Armature:create("xitieshi")
    self.m_manget:getAnimation():playWithIndex(0)
    self.m_manget:setPosition(20,60)
    self:addChild(self.m_manget)
    
    GameDataManager.setGamePropTime(PLAYER_STATE.MagnetProp,_time)
end

--开局护盾
function Player:startProtect(parameters)
    if self:isDead() then
        return
    end
	Tools.printDebug("-----开局护盾")
	--护盾特效
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("armature/huduen0.png", "armature/huduen0.plist" , "armature/huduen.ExportJson")
    self.m_huduen = ccs.Armature:create("huduen")
    self.m_huduen:getAnimation():playWithIndex(0)
    self.m_huduen:setPosition(20,60)
    self:addChild(self.m_huduen)
	
    self:addBuff({type=PLAYER_STATE.StartProtect,time = parameters.data.time})
--    self.m_proHandler = Tools.delayCallFunc(parameters.data.time,function()
--        self:clearBuff(PLAYER_STATE.StartProtect)
--    end)
end

--游戏内吃到护盾
function Player:gameProtect(parameters)
    if self:isDead() then
        return
    end
    if self:isInState(PLAYER_STATE.StartProtect) then
        return
    end
    if self:isInState(PLAYER_STATE.GameDefence) then
        self:clearBuff(PLAYER_STATE.GameDefence)
    end
    
    if self:isInState(PLAYER_STATE.Defence) then
        return
    end
    
    Tools.printDebug("-----游戏内护盾")
    --护盾特效
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("armature/huduen0.png", "armature/huduen0.plist" , "armature/huduen.ExportJson")
    self.m_protect = ccs.Armature:create("huduen")
    self.m_protect:getAnimation():playWithIndex(0)
    self.m_protect:setPosition(20,60)
    self:addChild(self.m_protect)
    
    self:addBuff({type=PLAYER_STATE.GameDefence,time = parameters.data.time})
end

--开局冲刺
function Player:sprinting(parameters)

    if self:isDead() then
    	return
    end
    Tools.printDebug("-----------开局冲刺")
    
    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Sprint_Sound)
    --冲刺特效
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("role/chongci0.png", "role/chongci0.plist" , "role/chongci.ExportJson")
    self.m_spdeffect = ccs.Armature:create("chongci")
    self.m_spdeffect:getAnimation():playWithIndex(0)
    self.m_spdeffect:setPosition(-80,60)
    
    self:toPlay(PLAYER_ACTION.Run,0)
    self:addChild(self.m_spdeffect,10)
    
    self.oldX,self.oldY = self:getPosition()
    self:setPosition(cc.p(display.cx,display.cy))
    if self:isInState(PLAYER_STATE.GrankDrink) then
        self:setPosition(cc.p(display.cx,display.cy-50))
    end
    
    self:addBuff({type=PLAYER_STATE.StartSprint,time = parameters.data.time})
    self.initSpeed = MoveSpeed
    MoveSpeed = parameters.data.speed
    self.m_handler = Tools.delayCallFunc(parameters.data.time,function()
        self:clearBuff(PLAYER_STATE.StartSprint)
    end)
    self.startSprintManget = true
    self.startSprintRadius = parameters.data.radius
    
    GameDataManager.setGamePropTime(PLAYER_STATE.StartSprint,parameters.data.time,parameters.data.speed)
    
end
--死亡冲刺
function Player:deadSprint(parameters)
    if self:isDead() then
        return
    end
    Tools.printDebug("-----------死亡冲刺")
    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Sprint_Sound)
    --冲刺特效
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("role/chongci0.png", "role/chongci0.plist" , "role/chongci.ExportJson")
    self.m_deadDffect = ccs.Armature:create("chongci")
    self.m_deadDffect:getAnimation():playWithIndex(0)
    self.m_deadDffect:setPosition(-80,60)

    self:stopAllActions()
    self:toPlay(PLAYER_ACTION.Run,0)
    self:addChild(self.m_deadDffect,10)

    self.m_scaleY = self:getScaleY()
    self:setScaleY(1)
    self:setPosition(cc.p(display.cx,display.cy))
    if self:isInState(PLAYER_STATE.GrankDrink) then
        self:setPosition(cc.p(display.cx,display.cy-50))
    end

    self:addBuff({type=PLAYER_STATE.DeadSprint,time = parameters.data.time})
    self.deadSpeed = MoveSpeed
    MoveSpeed = parameters.data.speed
    self.m_dHandler = Tools.delayCallFunc(parameters.data.time,function()
        self:clearBuff(PLAYER_STATE.DeadSprint)
    end)
    self.deadSprintManget = true
    self.deadSprintRadius = parameters.data.radius
    
    GameDataManager.setGamePropTime(PLAYER_STATE.DeadSprint,parameters.data.time,parameters.data.speed)
end
--死亡接力
function Player:deadRelay(parameters)
    --清除所有buff
    for var=#self.m_buffArr,1,-1  do
        local _buff = self.m_buffArr[var]
        if _buff then
            self:clearBuff(_buff:getType())
        end
    end
    self.m_buffArr = {}

    self:reSetUD()
    self.m_hp = self.m_vo.m_hp

    local old = self.m_armature
    local random = math.random(1,GameDataManager.getRoleModelCount())
    Tools.printDebug("-----------死亡接力..",random)
    local modle = RoleConfig[random].armatureName
    self:createModle(modle)
    old:removeFromParent()
    
    if self.originScaleY then
        self:setScaleY(self.originScaleY)
    end
    if self.originPos then
        self:setPosition(self.originPos)
    end
    
    self.m_jump = false
    self.m_run = true
    self:clearObstales()
end
--极限冲刺
function Player:limitSprint(parameters)
	
    if self:isDead() then
        return
    end
    
    if self:isInState(PLAYER_STATE.LimitSprint) then
    	return
    end
    if self:isInState(PLAYER_STATE.DeadSprint) then
    	return
    end
    if self:isInState(PLAYER_STATE.StartSprint) then
        return
    end
    
    Tools.printDebug("----------极限冲刺")
    
    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Sprint_Sound)
    --冲刺特效
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("role/chongci0.png", "role/chongci0.plist" , "role/chongci.ExportJson")
    self.m_limitDffect = ccs.Armature:create("chongci")
    self.m_limitDffect:getAnimation():playWithIndex(0)
    self.m_limitDffect:setPosition(-80,60)

    self:stopAllActions()
    self:toPlay(PLAYER_ACTION.Run,0)
    self:addChild(self.m_limitDffect,10)

    self.m_scaleY = self:getScaleY()
    self:setScaleY(1)
    self:setPosition(cc.p(display.cx,display.cy))
    if self:isInState(PLAYER_STATE.GrankDrink) then
        self:setPosition(cc.p(display.cx,display.cy-50))
    end

    self:addBuff({type=PLAYER_STATE.LimitSprint,time = parameters.data.time})
    self.limitSpeed = MoveSpeed
    MoveSpeed = parameters.data.speed
    local _lv = GameDataManager.getRoleLevel(self.m_curModle)
    local _time = parameters.data.time+GameDataManager.getUnActSkillTime(self.m_curModle,_lv,GOODS_TYPE.LimitSprint)
    self.m_limitHandler = Tools.delayCallFunc(parameters.data.time,function()
        self:clearBuff(PLAYER_STATE.LimitSprint)
    end)
    self.limitSprintManget = true
    self.limitSprintRadius = parameters.data.radius

    GameDataManager.setGamePropTime(PLAYER_STATE.LimitSprint,_time,parameters.data.speed)
end
--金币转换
function Player:transformGold(parameters)
    if self:isDead() then
        return
    end
    if self:isInState(PLAYER_STATE.TransformGold) then
    	return
    end
    Tools.printDebug("----------金币转换")
    
    local _lv = GameDataManager.getRoleLevel(self.m_curModle)
    local _time = parameters.data.time+GameDataManager.getUnActSkillTime(self.m_curModle,_lv,GOODS_TYPE.ConverGold)
    self:addBuff({type=PLAYER_STATE.TransformGold,time = parameters.data.time})
    self.m_transHandler = Tools.delayCallFunc(parameters.data.time,function()
        self:clearBuff(PLAYER_STATE.TransformGold)
    end)
    GameDataManager.setGamePropTime(PLAYER_STATE.TransformGold,_time)
end

--速度减慢(滑冰)
function Player:slowSpeed(parameters)
    if self:isDead() then
        return
    end
    
    if self:isInState(PLAYER_STATE.Slow) then
        return
    end
    Tools.printDebug("----------速度减慢")
    
    if parameters.data.isSlow then
        self:addBuff({type=PLAYER_STATE.Slow})
        self.originSpeed = MoveSpeed
        local speed = MoveSpeed - parameters.data.cutSpeed
        MoveSpeed = speed
    else
        self:clearBuff(PLAYER_STATE.Slow)
    end
    
end
--弹簧障碍物
function Player:spring(parameters)
    if self:isDead() then
        return
    end
    if self:isInState(PLAYER_STATE.StartSprint) then
        return
    end
    if self:isInState(PLAYER_STATE.DeadSprint) then
        return
    end
    if self:isInState(PLAYER_STATE.LimitSprint) then
        return
    end
    if self:isInState(PLAYER_STATE.Spring) then
        self:clearBuff(PLAYER_STATE.Spring)
    end
    
    Tools.printDebug("----------弹簧跳跃",self:getJumpState())
    
    if self:getJumpState() then
        self:addBuff({type=PLAYER_STATE.Spring})
        self:toPlay(PLAYER_ACTION.Jump,0)
        self:toMove(true)
    else
        local x = parameters.data
        if x<self:getPositionX() then
            Tools.printDebug("print error 卡在弹簧--------------")
        	return
        end
        self.originPos = cc.p(self:getPosition())
        self.originScaleY = self:getScaleY()
        if self.backHandler then
            Scheduler.unscheduleGlobal(self.backHandler)
            self.backHandler=nil
        end
        self.backHandler = Scheduler.scheduleGlobal(handler(self,self.backMove),FrameTime)
    end
end

--向后移动
function Player:backMove(parameters)
    local x,y = self:getPosition()
    self:setPosition(x-MoveSpeed*0.1,y)
    if self:getPositionX()<=-self:getSize().width then
        if self.backHandler then
            Scheduler.unscheduleGlobal(self.backHandler)
            self.backHandler=nil
        end
        self:deadSprintFlash()
    end
end

--==================End===================

--================角色技能buff=============
--吸金币
function Player:magnetSkill(radius)
    self:addBuff({type=PLAYER_STATE.Magnet})
    self.m_radius = radius
    self.m_isMagnet = true
    --特效
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("armature/xitieshi0.png", "armature/xitieshi0.plist" , "armature/xitieshi.ExportJson")
    self.m_mangetSelf = ccs.Armature:create("xitieshi")
    self.m_mangetSelf:getAnimation():playWithIndex(0)
    self.m_mangetSelf:setPosition(20,60)
    self:addChild(self.m_mangetSelf)
end

--护盾技能
function Player:protectSkill(parameters)
    Tools.printDebug("----------角色的护盾")
    self:addBuff({type=PLAYER_STATE.Defence})
    --护盾特效
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("armature/huduen0.png", "armature/huduen0.plist" , "armature/huduen.ExportJson")
    self.m_protectSkill = ccs.Armature:create("huduen")
    self.m_protectSkill:getAnimation():playWithIndex(0)
    self.m_protectSkill:setPosition(20,60)
    self:addChild(self.m_protectSkill)
end
--================End=======================

--判断玩家是否处于某种状态
function Player:isInState(_state)
    if #self.m_buffArr > 0 then
        for key, var in ipairs(self.m_buffArr) do
            if _state == var:getType() then
                return true
            end
        end
        return false
    else
        return false
    end
end

--添加buff
function Player:addBuff(_params)
    local _buff = BuffState.new({type=_params.type,time=_params.time})
    table.insert(self.m_buffArr,_buff)
end
--清除指定类型的buff
function Player:clearBuff(_type)
    local bIsClear=false
    for var=#self.m_buffArr,1,-1  do
        local _buff = self.m_buffArr[var]
        if _type == _buff:getType() then
            table.remove(self.m_buffArr,var)
            bIsClear=true
            break
        end
    end

    if bIsClear==true then
        if _type==PLAYER_STATE.StartSprint then
            if self.m_handler then
                Scheduler.unscheduleGlobal(self.m_handler)
                self.m_handler = nil
            end
            if not tolua.isnull(self.m_spdeffect) then
                self.m_spdeffect:removeFromParent()
                self.m_spdeffect = nil
            end
            self:toPlay(PLAYER_ACTION.Run)
            self:setPosition(cc.p(self.oldX,self.oldY))
            self.oldX,self.oldY = nil,nil
            MoveSpeed = self.initSpeed
            self.initSpeed = nil
            self.startSprintManget = false
            self.startSprintRadius = nil
            self:clearObstales()
        elseif _type == PLAYER_STATE.DeadSprint then
            if self.m_dHandler then
                Scheduler.unscheduleGlobal(self.m_dHandler)
                self.m_dHandler = nil
            end
            if not tolua.isnull(self.m_deadDffect) then
                self.m_deadDffect:removeFromParent()
                self.m_deadDffect = nil
            end
            self:toPlay(PLAYER_ACTION.Run)
            self:setScaleY(self.m_scaleY)
            if self.m_scaleY == 1 then
                self:setPosition(cc.p(display.cx-100,display.cy-240))
            else
                self:setPosition(cc.p(display.cx-100,display.cy+200))
            end
            MoveSpeed = self.deadSpeed
            self.deadSpeed = nil
            self.m_scaleY = nil
            self.deadSprintManget = false
            self.deadSprintRadius = nil
            self:deadContinueFlash()
            self:clearObstales()
        elseif _type == PLAYER_STATE.StartProtect then
            if not tolua.isnull(self.m_huduen) then
                self.m_huduen:removeFromParent()
                self.m_huduen = nil
            end
        
        elseif _type == PLAYER_STATE.MagnetProp then
            self.m_propManget = false
            if self.m_manHandler then
                Scheduler.unscheduleGlobal(self.m_manHandler)
                self.m_manHandler = nil
            end
            if not tolua.isnull(self.m_manget) then
                self.m_manget:removeFromParent()
                self.m_manget = nil
            end
            
        elseif _type == PLAYER_STATE.GrankDrink then
            if self.m_grankHandler then
                Scheduler.unscheduleGlobal(self.m_grankHandler)
                self.m_grankHandler = nil
            end
            self.m_armature:setScale(1)
            self.m_body:removeFromWorld()
            local offset
            if self:getScaleY() == -1 then
            	offset = cc.p(10,-50)
            else
                offset = self.p_offset
            end
            self:addBody(offset,self.pSize)
            self:clearObstales()
        elseif _type == PLAYER_STATE.LimitSprint then
            if self.m_limitHandler then
                Scheduler.unscheduleGlobal(self.m_limitHandler)
                self.m_limitHandler = nil
            end
            if not tolua.isnull(self.m_limitDffect) then
                self.m_limitDffect:removeFromParent()
                self.m_limitDffect = nil
            end
            self:toPlay(PLAYER_ACTION.Run)
            self:setScaleY(self.m_scaleY)
            if self.m_scaleY == 1 then
                self:setPosition(cc.p(display.cx-100,display.cy-240))
            else
                self:setPosition(cc.p(display.cx-100,display.cy+200))
            end
            MoveSpeed = self.limitSpeed
            self.limitSpeed = nil
            self.m_scaleY = nil
            self.limitSprintManget = false
            self.limitSprintRadius = nil
            self:clearObstales()
        elseif _type == PLAYER_STATE.TransformGold then
            if self.m_transHandler then
                Scheduler.unscheduleGlobal(self.m_transHandler)
                self.m_transHandler = nil
            end
        elseif _type == PLAYER_STATE.Slow then
            if self.originSpeed then
                MoveSpeed = self.originSpeed
                self.originSpeed = nil
            end
        elseif _type == PLAYER_STATE.Magnet then
            if not tolua.isnull(self.m_mangetSelf) then
                self.m_mangetSelf:removeFromParent()
                self.m_mangetSelf = nil
            end
        elseif _type == PLAYER_STATE.Defence then
            if not tolua.isnull(self.m_protectSkill) then
                self.m_protectSkill:removeFromParent()
                self.m_protectSkill = nil
            end
        elseif _type == PLAYER_STATE.GameDefence then
            if not tolua.isnull(self.m_protect) then
                self.m_protect:removeFromParent()
                self.m_protect = nil
            end
        end
    end

end

function Player:isPlayerDead()
    return self.m_isDead
end

--添加闪烁状态
function Player:blank(_par)
    --添加状态
    self:addBuff({type=PLAYER_STATE.DropLife,time=_par})
    local _time = _par
    self:toFlash(_time)
    self.m_dropLifeHandle = Tools.delayCallFunc(_time,function()
        self:toStopFlash()
        self:clearBuff(PLAYER_STATE.DropLife)
    end)
end

--掉生命时闪烁
function Player:toFlash(_time)
    self.m_isFlashed = true
    local toFadeOut
    toFadeOut = function(parameters)
        if not self.m_isFlashed then
            return
        end
        if not tolua.isnull(self.m_armature) then
            transition.fadeOut(self.m_armature,{time=Flash_Skeep_Time,onComplete=function()
                transition.fadeIn(self.m_armature,{time=Flash_Skeep_Time,onComplete=function()
                    toFadeOut()
                end})
            end})
        end
    end
    toFadeOut()
end


function Player:toStopFlash()
    self.m_isFlashed = false
    if not tolua.isnull(self.m_armature) then
        transition.stopTarget(self.m_armature)
        self.m_armature:setOpacity(255)
    end
end

function Player:pause(parameters)
    Tools.printDebug("角色游戏暂停")
    if not tolua.isnull(self.m_armature) then
        if self:isInState(PLAYER_STATE.MagnetProp) then
            Tools.printDebug("卸载吸铁石定时器")
            GameDataManager.setGamePauseTime(PLAYER_STATE.MagnetProp)
            if self.m_manHandler then
                Scheduler.unscheduleGlobal(self.m_manHandler)
                self.m_manHandler = nil
            end
        end
        if self:isInState(PLAYER_STATE.GrankDrink) then
            Tools.printDebug("卸载巨人定时器")
            GameDataManager.setGamePauseTime(PLAYER_STATE.GrankDrink)
            if  self.m_grankHandler then
                Scheduler.unscheduleGlobal(self.m_grankHandler)
                self.m_grankHandler = nil
            end
        end
        if self:isInState(PLAYER_STATE.StartSprint) then
            Tools.printDebug("卸载开局冲刺定时器")
            GameDataManager.setGamePauseTime(PLAYER_STATE.StartSprint)
            if  self.m_handler then
                Scheduler.unscheduleGlobal(self.m_handler)
                self.m_handler = nil
            end
        end
        if self:isInState(PLAYER_STATE.DeadSprint) then
            Tools.printDebug("卸载死亡冲刺定时器")
            GameDataManager.setGamePauseTime(PLAYER_STATE.DeadSprint)
            if  self.m_dHandler then
                Scheduler.unscheduleGlobal(self.m_dHandler)
                self.m_dHandler = nil
            end
        end
        if self:isInState(PLAYER_STATE.LimitSprint) then
            Tools.printDebug("卸载极限冲刺定时器")
            GameDataManager.setGamePauseTime(PLAYER_STATE.LimitSprint)
            if  self.m_limitHandler then
                Scheduler.unscheduleGlobal(self.m_limitHandler)
                self.m_limitHandler = nil
            end
        end
        if self:isInState(PLAYER_STATE.TransformGold) then
            Tools.printDebug("卸载金币转换定时器")
            GameDataManager.setGamePauseTime(PLAYER_STATE.TransformGold)
            if  self.m_transHandler then
                Scheduler.unscheduleGlobal(self.m_transHandler)
                self.m_transHandler = nil
            end
        end
        if self:isInState(PLAYER_STATE.Slow) then
            GameDataManager.setGamePauseTime(PLAYER_STATE.Slow)
            if  self.m_slowHandler then
                Scheduler.unscheduleGlobal(self.m_slowHandler)
                self.m_slowHandler = nil
            end
        end
    end
end

function Player:regain(parameters)
    Tools.printDebug("角色游戏恢复")
    if not tolua.isnull(self.m_armature) then
        if self:isInState(PLAYER_STATE.MagnetProp) then
            Tools.printDebug("重启吸铁石定时器")
            local leftTime = GameDataManager.getLeftTime(PLAYER_STATE.MagnetProp)
            GameDataManager.setGamePropTime(PLAYER_STATE.MagnetProp,leftTime)
            self.m_manHandler = Tools.delayCallFunc(leftTime,function()
                self:clearBuff(PLAYER_STATE.MagnetProp)
            end)
        end
        if self:isInState(PLAYER_STATE.GrankDrink) then
            Tools.printDebug("重启巨人定时器")
            local leftTime = GameDataManager.getLeftTime(PLAYER_STATE.GrankDrink)
            GameDataManager.setGamePropTime(PLAYER_STATE.GrankDrink,leftTime)
            self.m_grankHandler = Tools.delayCallFunc(leftTime,function()
                self:clearBuff(PLAYER_STATE.GrankDrink)
            end)
        end
        if self:isInState(PLAYER_STATE.StartSprint) then
            MoveSpeed = GameDataManager.getMapSpeed(PLAYER_STATE.StartSprint)
            local leftTime = GameDataManager.getLeftTime(PLAYER_STATE.StartSprint)
            GameDataManager.setGamePropTime(PLAYER_STATE.StartSprint,leftTime,MoveSpeed)
            self.m_handler = Tools.delayCallFunc(leftTime,function()
                self:clearBuff(PLAYER_STATE.StartSprint)
            end)
            Tools.printDebug("重启开局冲刺定时器",MoveSpeed)
        end
        if self:isInState(PLAYER_STATE.DeadSprint) then
            Tools.printDebug("重启死亡冲刺定时器")
            MoveSpeed = GameDataManager.getMapSpeed(PLAYER_STATE.DeadSprint)
            local leftTime = GameDataManager.getLeftTime(PLAYER_STATE.DeadSprint)
            GameDataManager.setGamePropTime(PLAYER_STATE.DeadSprint,leftTime,MoveSpeed)
            self.m_dHandler = Tools.delayCallFunc(leftTime,function()
                self:clearBuff(PLAYER_STATE.DeadSprint)
            end)
        end
        if self:isInState(PLAYER_STATE.LimitSprint) then
            Tools.printDebug("重启极限冲刺定时器")
            MoveSpeed = GameDataManager.getMapSpeed(PLAYER_STATE.LimitSprint)
            local leftTime = GameDataManager.getLeftTime(PLAYER_STATE.LimitSprint)
            GameDataManager.setGamePropTime(PLAYER_STATE.LimitSprint,leftTime,MoveSpeed)
            self.m_limitHandler = Tools.delayCallFunc(leftTime,function()
                self:clearBuff(PLAYER_STATE.LimitSprint)
            end)
        end
        if self:isInState(PLAYER_STATE.TransformGold) then
            Tools.printDebug("重启金币转换定时器")
            local leftTime = GameDataManager.getLeftTime(PLAYER_STATE.TransformGold)
            GameDataManager.setGamePropTime(PLAYER_STATE.TransformGold,leftTime)
            self.m_transHandler = Tools.delayCallFunc(leftTime,function()
                self:clearBuff(PLAYER_STATE.TransformGold)
            end)
        end
        if self:isInState(PLAYER_STATE.Slow) then
            MoveSpeed = GameDataManager.getMapSpeed(PLAYER_STATE.Slow)
            local leftTime = GameDataManager.getLeftTime(PLAYER_STATE.Slow)
            GameDataManager.setGamePropTime(PLAYER_STATE.Slow,leftTime,MoveSpeed)
            self.m_slowHandler = Tools.delayCallFunc(leftTime,function()
                self:clearBuff(PLAYER_STATE.Slow)
            end)
        end
    end
end

function Player:dispose()

    GameDispatcher:removeListenerByName(EventNames.EVENT_PLAYER_ATTACKED)
    GameDispatcher:removeListenerByName(EventNames.EVENT_START_SPRINT)
    GameDispatcher:removeListenerByName(EventNames.EVENT_DEAD_SPRINT)
    GameDispatcher:removeListenerByName(EventNames.EVENT_START_PROTECT)
    GameDispatcher:removeListenerByName(EventNames.EVENT_DEAD_RELAY)
    GameDispatcher:removeListenerByName(EventNames.EVENT_MANGET)
    GameDispatcher:removeListenerByName(EventNames.EVENT_GRANT_DRINK)
    GameDispatcher:removeListenerByName(EventNames.EVENT_PLAYER_PAUSE)
    GameDispatcher:removeListenerByName(EventNames.EVENT_PLAYER_REGAIN)
    GameDispatcher:removeListenerByName(EventNames.EVENT_LIMIT_SPRINT)
    GameDispatcher:removeListenerByName(EventNames.EVENT_TRANSFORM_GOLD)
    GameDispatcher:removeListenerByName(EventNames.EVENT_SLOW_SPEED)
    GameDispatcher:removeListenerByName(EventNames.EVENT_OBSCALE_SPRING)
    GameDispatcher:removeListenerByName(EventNames.EVENT_ROLE_REVIVE)
    GameDispatcher:removeListenerByName(EventNames.EVENT_GAME_PROTECT)
    
    self.m_isDead = false
    GameController.isDead = false
    self.m_jump = false
    self.m_run = true
    GameController.isWin = false
    
    if self.m_handler then
        Scheduler.unscheduleGlobal(self.m_handler)
        self.m_handler = nil
    end
    
    if self.m_dHandler then
        Scheduler.unscheduleGlobal(self.m_dHandler)
        self.m_dHandler = nil
    end
    
    if self.m_proHandler then
        Scheduler.unscheduleGlobal(self.m_proHandler)
        self.m_proHandler = nil
    end
    
    if self.m_manHandler then
        Scheduler.unscheduleGlobal(self.m_manHandler)
        self.m_manHandler = nil
    end
    if self.m_grankHandler then
        Scheduler.unscheduleGlobal(self.m_grankHandler)
        self.m_grankHandler = nil
    end
    if self.m_limitHandler then
        Scheduler.unscheduleGlobal(self.m_limitHandler)
        self.m_limitHandler = nil
    end
    if self.m_transHandler then
        Scheduler.unscheduleGlobal(self.m_transHandler)
        self.m_transHandler = nil
    end
    if self.m_slowHandler then
        Scheduler.unscheduleGlobal(self.m_slowHandler)
        self.m_slowHandler = nil
    end

    if self.m_dropLifeHandle then
        Scheduler.unscheduleGlobal(self.m_dropLifeHandle)
        self.m_dropLifeHandle=nil
    end
    
    if self.backHandler then
        Scheduler.unscheduleGlobal(self.backHandler)
        self.backHandler=nil
    end
    

    --清除所有buff
    for var=#self.m_buffArr,1,-1  do
        local _buff = self.m_buffArr[var]
        if _buff then
            self:clearBuff(_buff:getType())
        end
    end
    self.m_buffArr = {}

    GameController.stopDetect()

    self.super.dispose(self)
end


return Player
