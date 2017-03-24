--[[
游戏控制器
]]
local GameController = {}

GameController.doubleScore = 1

GameController.overFrame = false

GameController.isDead = false
GameController.isWin = false

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
    display.pause()
    _isPause=true
    MoveSpeed = 0  --地图移动速度
--    if isEvent then
--        GameController.setGoodsCurTime()
--        GameDispatcher:dispatch(EventNames.EVENT_PLAYER_PAUSE)
--    end
end

--游戏恢复
function GameController.resumeGame(isEvent)
    Tools.printDebug("恢复游戏！")
    display.resume()
    _isPause=false
    MoveSpeed = _curSpeed
    TimeUtil.init()
--    if isEvent then
--        GameDispatcher:dispatch(EventNames.EVENT_PLAYER_REGAIN)
--        GameController.reSetGoodsTime()
--    end
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
                local playerRect = cc.rect(playP.x,playP.y,playSize.width,playSize.height)
                local goldRect = cc.rect(goldPos.x,goldPos.y,goldSize.width,goldSize.height)
                if cc.rectIntersectsRect(goldRect,playerRect) then
                    gold:collision()
                    table.remove(goldBody,var)
                    return
                end
            end
            if not tolua.isnull(curPlayerL) then
                local parent=curPlayerL:getParent()
                local playP = cc.p(curPlayerL:getPosition())
                local playSize = curPlayerL:getAreaSize()
                local goldPos=gold:getParent():convertToWorldSpace(cc.p(gold:getPosition()))
                local goldSize = gold:getSize()
                local playerRect = cc.rect(playP.x,playP.y,playSize.width,playSize.height)
                local goldRect = cc.rect(goldPos.x,goldPos.y,goldSize.width,goldSize.height)
                if cc.rectIntersectsRect(goldRect,playerRect) then
                    gold:collision()
                    table.remove(goldBody,var)
                    return
                end
            end
            if not tolua.isnull(curPlayerR) then
                local parent=curPlayerR:getParent()
                local playP = cc.p(curPlayerR:getPosition())
                local playSize = curPlayerR:getAreaSize()
                local goldPos=gold:getParent():convertToWorldSpace(cc.p(gold:getPosition()))
                local goldSize = gold:getSize()
                local playerRect = cc.rect(playP.x,playP.y,playSize.width,playSize.height)
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
            local fromP,toP = cc.p(gold:getPosition())
            toP = cc.p(target:getPosition())
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


--=============================道具使用时间流程

--重置道具时间点
function GameController.reSetGoodsTime()
    if GameController.isInState(PLAYER_STATE.topfly) then
        GameController.setGoodsKeepTime(GOON_TAG.TopSpeed,GameController.getGoodsGoonTime(GOON_TAG.TopSpeed))
        GameController.setGoodsInitTime(GOON_TAG.TopSpeed)
    end
    if GameController.isInState(PLAYER_STATE.spring) then
        GameController.setGoodsKeepTime(GOON_TAG.Springs,GameController.getGoodsGoonTime(GOON_TAG.Springs))
        GameController.setGoodsInitTime(GOON_TAG.Springs)
    end
    if GameController.isInState(PLAYER_STATE.protect) then
        GameController.setGoodsKeepTime(GOON_TAG.Protect,GameController.getGoodsGoonTime(GOON_TAG.Protect))
        GameController.setGoodsInitTime(GOON_TAG.Protect)
    end

    if GameController.isInState(PLAYER_STATE.DropLife) then
        GameController.setGoodsKeepTime(GOON_TAG.DropLife,GameController.getGoodsGoonTime(GOON_TAG.DropLife))
        GameController.setGoodsInitTime(GOON_TAG.DropLife)
    end
end

--1
--设置道具的使用时间(1,道具编号（GameConfig中获得）,2,道具使用的时间)
function GameController.setGoodsKeepTime(_propId,_time)
    GOON_GOODS[_propId].keepTime = _time
    Tools.printDebug("当前使用的道具总时间",_time)
end

--初始化单个缓存的道具信息[持续时间]
function GameController.initGoodsKeepTime(_propId)
    GOON_GOODS[_propId].keepTime = 0
end

--2
--获取当前使用道具的时间截点
function GameController.setGoodsInitTime(_propId)
    Tools.printDebug("初始使用道具截点",math.ceil(Tools.getSysTime()))
    GOON_GOODS[_propId].initTime = math.ceil(Tools.getSysTime())
end

--初始化单个缓存的道具信息[初始时间]
function GameController.initGoodsTime(_propId)
    GOON_GOODS[_propId].initTime = 0
end

--3
--获取当前道具是否能继续使用(添加角色时跳过此步)
--得到道具是否可以继续使用
function GameController.getGoodsType(_propId)
    local curTime = GOON_GOODS[_propId].keepTime -(GameController.getGoodsCurTime()-GOON_GOODS[_propId].InitTime)
    if  curTime>0 then
        GOON_GOODS[_propId].type = true
    end
    Tools.printDebug("当前道具能否继续使用状态",GOON_GOODS[_propId].type)
    return GOON_GOODS[_propId].type
end

--4
--获取当前(还可以继续使用的时间)(添加角色时)
function GameController.getGoodsGoonTime(_propId)
    local m_Time = GOON_GOODS[_propId].keepTime -(GameController.getGoodsCurTime()-GOON_GOODS[_propId].initTime)
    Tools.printDebug("当前道具剩余时间",m_Time)
    return m_Time
end

function GameController.getGoodsLastTime(_propId)
    Tools.printDebug("当前道具剩余时间",GOON_GOODS[_propId].keepTime -(math.ceil(Tools.getSysTime())-GOON_GOODS[_propId].initTime))
    return GOON_GOODS[_propId].keepTime -(math.ceil(Tools.getSysTime())-GOON_GOODS[_propId].initTime)
end

--辅助 -- 得到当前时间
function GameController.getGoodsCurTime()
    return pauseTime
end

function GameController.setGoodsCurTime(parameters)
    pauseTime = math.ceil(Tools.getSysTime())
    Tools.printDebug("当前使用道具截点",pauseTime)
end

--初始化缓存的道具信息(全部道具)
function GameController.initGoodsPoolAll(_initMsg)
    if _initMsg == GOON_TAG.ALL then
        for var = 1,4 do
            GOON_GOODS[var].type=false
        end
    end
    if _initMsg == GOON_TAG.InitTime then
        for var = 1,4 do
            GOON_GOODS[var].initTime=0
        end
    end
    if _initMsg == GOON_TAG.KeepTime then
        for var = 1,4 do
            GOON_GOODS[var].keepTime =0
        end
    end
end

--初始化缓存的道具信息(单个)
function GameController.initGoodsPool(_goosId)
    GOON_GOODS[_goosId].type = true
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
end


return GameController