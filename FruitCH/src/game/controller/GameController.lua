--[[
游戏控制器
]]
local GameController = {}

GameController.doubleScore = 1

GameController.overFrame = false

GameController.isDead = false
GameController.isWin = false

--额外吸附物品
GameController.Adsorb_Ex_Goods = 1

local _isPause = false
local _curSpeed = 0

--设置暂停时间节点
local pauseTime = 0

--当前中角色对象
local curPlayer
--当前场景层
local curMapLayer

local movingObjs={} --移动中的对象数组
local goldBody={}
local goodBody={}

local signPop = false
--设置签到弹出
function GameController.setSignPop(isPop)
	signPop = isPop
end
function GameController.getSignPop(parameters)
	return signPop
end

--设置地图滚动速度
function GameController.setSpeed(_speed)
    _curSpeed = _speed
end

--得到游戏速度
function GameController.getSpeed()
    return _curSpeed
end


--游戏暂停
function GameController.pauseGame(isEvent)
    Tools.printDebug("暂停游戏！")
--    display.pause()
    _isPause=true
    MoveSpeed = 0  --地图移动速度
    if isEvent then
        GameDispatcher:dispatch(EventNames.EVENT_PLAYER_PAUSE)
        GameDispatcher:dispatch(EventNames.EVENT_OBSCALE_FLYPAUSE)
    end
end

--游戏恢复
function GameController.resumeGame(isEvent)
    Tools.printDebug("恢复游戏！")
--    display.resume()
    _isPause=false
    MoveSpeed = _curSpeed
    TimeUtil.init()
    if isEvent then
        GameDispatcher:dispatch(EventNames.EVENT_PLAYER_REGAIN)
        GameDispatcher:dispatch(EventNames.EVENT_OBSCALE_FLYRESUM)
    end
end

function GameController.isInPause()
    return _isPause
end


--设置当前玩家对象
function GameController.setCurPlayer(_player)
    curPlayer = _player
end

--获取当前角色对象
function GameController.getCurPlayer(parameters)
    return curPlayer
end
--玩家是否处于某种状态
function GameController.isInState(_state)
    if not tolua.isnull(curPlayer) then
        return curPlayer:isInState(_state)
    end
    return false
end
--玩家是否死亡
function GameController.isPlayerDead()
    if not tolua.isnull(curPlayer) then
        return curPlayer:getVo().m_hp<=0
    end
    return true
end

--设置当前map
function GameController.setCurMapLayer(_layer)
	curMapLayer = _layer
end
function GameController.getCurMap(parameters)
	return curMapLayer
end

--已选中开局道具
local startProp = {}
function GameController.setStartProp(id,_enable)
    if not startProp[id] then
    	startProp[id] = {}
    end
    startProp[id].id = id
    startProp[id].isSelect = _enable
end
function GameController.getStartPropById(id)
    if not startProp[id] then
    	return false
    end
    return startProp[id].isSelect
end
function GameController.getStartProp(parameters)
    return startProp
end
function GameController.resetStartProp(parameters)
	startProp = {}
end

--组合排序
function GameController.getSorting(arr)
   local configArr = {}
   for key, var in pairs(arr) do
        table.insert(configArr,var)
   end
   for vr=1, #configArr do
        for var=vr+1, #configArr do
            if configArr[vr].probability > configArr[var].probability then
            	local temp
                temp = configArr[vr]
                configArr[vr] = configArr[var]
                configArr[var] = temp
            end
        end
   end
   return configArr
end
--组合总权重
function GameController.getTotalWeight(arr)
	local _weight = 0
	for var=1, #arr do
        _weight = _weight + arr[var].probability
	end
	return _weight
end
--按权重抽取一组数据
function GameController.getDataIdByWeight(_wegt,sorArr)
    local weight = math.random(1,_wegt)
    local t = 0
    --得到当前id
    local id = 0
    for var=1, #sorArr do
        t = t + sorArr[var].probability
        if t >= weight then
            id = sorArr[var]._id
            return id
        end
    end
    return id
end


--添加金币
function GameController.addGoldBody(body,_isMoving)
    if _isMoving then
        table.insert(movingObjs,body)
    else
        table.insert(goldBody,body)
    end
end

--添加道具
function GameController.addGoodBody(body)
    table.insert(goodBody,body)
end

function GameController.attract(parameters)
    for var=#goldBody,1,-1 do
        local gold=goldBody[var]
        if not tolua.isnull(gold) and not gold:isDisposed() and not tolua.isnull(gold:getParent()) then
            if not tolua.isnull(curPlayer) then
                local parent=curPlayer:getParent()
                local playP = cc.p(curPlayer:getPosition())
                local playSize = curPlayer:getAreaSize()
                local goldPos=gold:getParent():convertToWorldSpace(cc.p(gold:getPosition()))
                local goldSize = gold:getSize()
                local playerOffset = curPlayer:getOffset()
                local playerRect = cc.rect(playP.x-playSize.width*0.5,playP.y,playSize.width,playSize.height)
                local goldRect = cc.rect(goldPos.x,goldPos.y,goldSize.width,goldSize.height)
                if cc.rectIntersectsRect(goldRect,playerRect) then
                    gold:collision()
                    table.remove(goldBody,var)
                    return
                end
            end
        else
            table.remove(goldBody,var)
        end
    end
    
    for var=#movingObjs,1,-1 do
        local _obj = movingObjs[var]
        if tolua.isnull(_obj) then
            table.remove(movingObjs,var)
        else
            local target=_obj:getTarget()
            if not tolua.isnull(target) then
                local fromP=cc.p(_obj:getPosition())
                local toP=cc.p(target:getPosition())
                GameController._coinCheckMove(_obj,fromP,toP,var,movingObjs)
            else
                _obj:dispose()
                table.remove(movingObjs,var)
            end
        end
    end
end

--检测金币吸引
local isDetect = false
function GameController.detect(target,targetPos,radius,type)
    isDetect = true
    for var=#goldBody,1,-1 do
        local gold=goldBody[var]
        if not tolua.isnull(gold) and not gold:isDisposed() then
            local fromP = cc.p(gold:getPosition())
            local toP = cc.p(target:getPosition())
            if cc.pGetDistance(fromP,toP)<=radius then
                gold:setAttract(target)
                table.insert(movingObjs,gold)
                table.remove(goldBody,var)
                GameController._coinCheckMove(gold,fromP,toP,var,goldBody)
            end
        else
            table.remove(goldBody,var)
        end
    end

    if type == GameController.Adsorb_Ex_Goods then
        for var=#goodBody,1,-1 do
            local good=goodBody[var]
            if not tolua.isnull(good) then
                local fromP,toP
                local parent=target:getParent()
                local pw= good:convertToWorldSpace(cc.p(0,0))
                fromP=parent:convertToNodeSpace(pw)
                toP=targetPos
                if cc.pGetDistance(fromP,toP)<=radius then
                    good:setAttract(target)
                    good:setRetain()
                    good:removeFromParent(false)

                    parent:addChild(good,MAP_ZORDER_MAX)
                    good:setPosition(fromP.x,fromP.y)

                    table.insert(movingObjs,good)
                    table.remove(goodBody,var)

                    GameController._coinCheckMove(good,fromP,toP,var,goodBody)
                end
            else
                table.remove(goodBody,var)
            end
        end
    end
    
end

function GameController.stopDetect()
    isDetect = false
end


--金币距目标距离更新位置
function GameController._coinCheckMove(_node,_fromP,_toP,_index,_table)
    local dis=cc.pGetDistance(_fromP,_toP)
    if dis>30 then
        if (dis-30) < 300 then
            if dis>GOLD_SPEED then
                dis=GOLD_SPEED
            end
        else
            dis = dis-30
        end

        local vect=cc.pSub(_toP,_fromP)

        local angel=cc.pGetAngle(cc.p(0,0),vect)
        local to=cc.p(_fromP.x+dis*math.cos(angel),_fromP.y+dis*math.sin(angel))
        _node:setPosition(to.x,to.y)
    else
        _node:collision()
        table.remove(movingObjs,_index)
    end
end

function GameController.clearBody(parameters)
    for var=#goldBody,1,-1 do
        local body=goldBody[var]
        if not tolua.isnull(body) then
            body:dispose()
        end
    end
    goldBody={}

    for var=#goodBody,1,-1 do
        local body=goodBody[var]
        if not tolua.isnull(body) then
            body:dispose()
        end
    end
    goodBody={}
    
    if movingObjs then
        for var=#movingObjs, 1,-1 do
            local _node = movingObjs[var]
            if not tolua.isnull(_node) then
                _node:dispose()
            end
        end
        movingObjs={}
    end
end


return GameController