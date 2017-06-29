--[[
游戏控制器
]]
local GameController = {}

--当前房间类型
GameController.CurRoomType = 0
--当前房间编号
GameController.CurRoomIdx = 0
--当前房间倒数编号
GameController.CurLastRoomIdx = 0

--当前摄像机左下角y坐标
GameController.CurCamaraY = 0

--额外吸附类型
--额外吸附物品
GameController.Adsorb_Ex_Goods = 1

--得分倍数
GameController.Score_Rate = 1

local goldBody={}
local goodBody={}
local anotherBody={}
local movingObjs={} --移动中的对象数组

--当前房间数组
local rooms

--当前角色对象
local curPlayer

--用于刚进入战斗场景时碰撞拦截
local _canCollision = true
local _isPause = false

--游戏暂停
function GameController.pauseGame()
    Tools.printDebug("chjh 暂停游戏！")
    display.pause()
    _canCollision = false
    _isPause = true
    if GameDataManager.isSoundOpen() then
        audio.pauseAllSounds()
    end
end

--游戏恢复
function GameController.resumeGame()
    Tools.printDebug("chjh 恢复游戏！")
    display.resume()
    _canCollision = true
    _isPause = false
    TimeUtil.init()
    if GameDataManager.isSoundOpen() then
        audio.resumeAllSounds()
    end
end

function GameController.isInPause()
    return _isPause
end

--设置当前是否发生碰撞
function GameController.setCollsionEnable(_enable)
    _canCollision = _enable
end
function GameController.getCollsionEnable()
    return _canCollision
end

--记录需要奖励物品的所有信息
function GameController.getAllReward()
    local rewardArr = {}
	for key, var in ipairs(DiamondConfig) do
		rewardArr[#rewardArr+1] = var
	end
	for key, var in ipairs(SceneConfig) do
		if not GameDataManager.getSceneModle(var.id) then
			rewardArr[#rewardArr+1] = var
		end
	end
	for key, var in ipairs(RoleConfig) do
		if not GameDataManager.getRoleModle(var.id) then
            rewardArr[#rewardArr+1] = var
		end
	end
	return rewardArr
end

--赋值房间数组
function GameController.setRooms(_rooms)
    rooms = _rooms
end
--清除房间数组
function GameController.clearRooms()
    rooms = nil
end
--根据房间号获取房间对象
function GameController.getRoomByIdx(_index)
    if rooms then
        for key, var in pairs(rooms) do
            if var:getRoomIndex() == _index then
                return var
            end
        end
    end
end
--获得缓存房间数组索引编号
function GameController.getChaceRoomKey(_roomIndx)
    if rooms then
        for key, var in pairs(rooms) do
            if var:getRoomIndex() == _roomIndx then
                return key
            end
        end
    end
end

--设置当前玩家对象
function GameController.setCurPlayer(_player)
    curPlayer = _player
end
--获取当前角色对象
function GameController.getCurPlayer()
    return curPlayer
end
--玩家是否处于某种状态
function GameController.isInState(_state)
    if not tolua.isnull(curPlayer) then
        return curPlayer:isInState(_state)
    end
    return false
end

--房间视觉
function GameController.setGameVisible(_enable)
	Game_Visible = _enable
	for key, var in pairs(rooms) do
	   if not tolua.isnull(var) then
	       for k, v in pairs(var:getAllOrnament()) do
                v:setVisible(Game_Visible)
           end
           if not Game_Visible then
                for ky, vr in pairs(var:getAllRoomBgs()) do
                    if not tolua.isnull(vr) then
                        vr:setSpriteFrame("Room_bg_2.png")
                    end
                end
           else
                local roombgArr = var:getAllRoomBgs()
                local windowbgArr = var:getWindowBgs()
                if #windowbgArr > 0 then
                    local pos = GameController.createRand(#windowbgArr,#roombgArr)
                    for var=1, #pos do
                        local wrr = Tools.Split("0"..windowbgArr[var],"#")
                        roombgArr[pos[var]]:setSpriteFrame(wrr[2])
                    end
                end
           end
	   end
	end
end

--生成不重复的随机数
function GameController.createRand(count,max)
    local randArr = {}
    local countArr = {}
--    Tools.printDebug("Hopscotch brj ----------随机数：",count,max)
    for i = 1,max do
        table.insert(countArr,i)
    end
    for var=1, count do
        local nNum = math.random(1,#countArr)
        table.insert(randArr,countArr[nNum])
        table.remove(countArr,nNum)
    end
    return randArr
end

--添加钻石
--_obj:钻石对象    _isMoving:是否移动中
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

--检测金币吸引
local isDetect = false
function GameController.detect(target,targetPos,radius,type)
    isDetect = true
    for var=#goldBody,1,-1 do
        local gold=goldBody[var]
        if not tolua.isnull(gold) and (not gold:isDisposed()) then
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
        _node:collision(true)
        table.remove(movingObjs,_index)
    end
end


--吸引金币
function GameController.attract(parameters)
    for var=#goldBody,1,-1 do
        local gold=goldBody[var]
        if (not tolua.isnull(gold)) and (not gold:isDisposed()) then
            if not tolua.isnull(curPlayer) then
                local parent=curPlayer:getParent()
                local playP = cc.p(curPlayer:getPosition())
                local playSize = curPlayer:getSize()
                local goldPos=cc.p(gold:getPosition())
                local goldSize = gold:getSize()
                local playerRect = cc.rect(playP.x-playSize.width*0.5,playP.y-playSize.height*0.5,playSize.width,playSize.height)
                local goldRect = cc.rect(goldPos.x,goldPos.y,goldSize.width,goldSize.height)
                if cc.rectIntersectsRect(goldRect,playerRect) then
                    gold:collision()
                    table.remove(goldBody,var)
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

function GameController.clearBody()

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