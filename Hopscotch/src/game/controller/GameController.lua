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

--额外吸附类型（本身具有吸附金币与金币泡泡功能）
--额外吸附物品
GameController.Adsorb_Ex_Goods = 1
--额外吸附金蛋与物品
GameController.Adsorb_Ex_Goods_Eeg = 2

--得分倍数
GameController.Score_Rate = 1

--是否购买了开局炸弹
GameController.Goods_Bomb = false

--上次杀怪时间
GameController.Kill_Time = 0

--宠物得分倍数
GameController.petScore_Rate = 1
--宠物攻击力倍数
GameController.petAtt_Rate = 1

--角色炼金术技能
GameController.playerMoney_Rate = 1

local laserBtnBody = {}
local laserBody={}
local exitBody={}
local goldBody={}
local goodBody={}
local eggBody={}
local bubbleBody={}
local anotherBody={}
local diamonds={} --钻石对象
local obstacles={} --当前房间障碍物
local movingObjs={} --移动中的对象数组
--排行榜数据
local myRank={
    starRank = 0,--自己当前星星排名
    starNum = 0,--自己排名的星星数量
    scoreRank = 0,--自己当前分数排名
    scoreNum = 0,--自己当前排名分数
}
--星级排行数据，列表元素为RankVo
local starRank={}
--积分排行，列表元素为RankVo
local scoreRank={}

local _curMonster = {} --当前房间怪物

--当前房间数组
local rooms

--当前角色对象
local curPlayer

--用于刚进入战斗场景时碰撞拦截
local _canCollision = false
local _isPause = false
local _rewardCollision = true
--游戏暂停
function GameController.pauseGame()
    print("chjh 暂停游戏！")
    display.pause()
    _canCollision = false
    _isPause = true
    --	if GameDataManager.isMusicOpen() then
    --        audio.pauseMusic()
    --	end
    if GameDataManager.isSoundOpen() then
        audio.pauseAllSounds()
    end
end

--游戏恢复
function GameController.resumeGame()
    print("chjh 恢复游戏！")
    display.resume()
    _canCollision = true
    _isPause = false
    TimeUtil.init()
    --    if GameDataManager.isMusicOpen() then
    --        audio.resumeMusic()
    --    end
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

--设置当前是否碰撞(用于楼层奖励时所有刚体无碰撞)
function GameController.setRewardCollsion(_enable)
	_rewardCollision = _enable
end

function GameController.getRewardCollsion()
	return _rewardCollision
end


--添加金币
--_obj:金币对象    _isMoving:是否移动中
function GameController.addGoldBody(body,_isMoving)
    if _isMoving then
        table.insert(movingObjs,body)
    else
        table.insert(goldBody,body)
    end
end
--添加钻石对象
--_obj:钻石对象    _isMoving:是否移动中
function GameController.addDiamondObj(_obj,_isMoving)
    if _isMoving then
        table.insert(movingObjs,_obj)
    else
        table.insert(diamonds,_obj)
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
--    if #diamonds > 0 then
--        for var=#diamonds, 1,-1 do
--            local _diamond = diamonds[var]
--            if tolua.isnull(_diamond) then
--                table.remove(diamonds,var)
--            else
--                local target=_diamond:getTarget()
--                if not tolua.isnull(target) then
--                    local fromP=cc.p(_diamond:getPosition())
--                    local toP=cc.p(target:getPosition())
--                    GameController._coinCheckMove(_diamond,fromP,toP,var,diamonds)
--                else
--                    _diamond:dispose()
--                    table.remove(diamonds,var)
--                end
--            end
--        end
--    end
    for var=#goldBody,1,-1 do
        local gold=goldBody[var]
        if (not tolua.isnull(gold)) and (not gold:isDisposed()) then
            if not tolua.isnull(curPlayer) then
                local parent=curPlayer:getParent()
                local playP = cc.p(curPlayer:getPosition())
                local playSize = curPlayer:getSize()
                local goldPos=cc.p(gold:getPosition())
                local goldSize = gold:getSize()
                local playerRect = cc.rect(playP.x,playP.y,playSize.width,playSize.height)
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

--获取可视区域内最底层的一个房间
function GameController.getScreenRoom()
    --    local curRoomKey,minY,maxY
    -- local obstaclesArr = {}
    for i=#rooms,1,-1  do
        local _roomObj = rooms[i]
        if not tolua.isnull(_roomObj) then
            if (_roomObj:getPositionY()+64) >= GameController.CurCamaraY then
                return i
            end
        end
    end
    --    return curRoomKey
end

function GameController.clearBody()
    for var=#laserBtnBody,1,-1 do
        local body=laserBtnBody[var]

        if not tolua.isnull(body) then
            body:dispose()
        end
    end
    laserBtnBody={}

    for var=#laserBody,1,-1 do
        local body=laserBody[var]

        if not tolua.isnull(body) then
            body:dispose()
        end

    end
    laserBody={}

    for var=#exitBody,1,-1 do
        local body=exitBody[var]

        if not tolua.isnull(body) then
            body:dispose()
        end
    end
    exitBody={}

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

    for var=#eggBody,1,-1 do
        local body=eggBody[var]

        if not tolua.isnull(body) then
            body:dispose()
        end
    end
    eggBody={}

    for var=#anotherBody,1,-1 do
        local body=anotherBody[var]

        if not tolua.isnull(body) then
            body:dispose()
        end
    end
    anotherBody={}

    for var=#bubbleBody,1,-1 do
        local body=bubbleBody[var]

        if not tolua.isnull(body) then
            body:dispose()
        end
    end
    bubbleBody={}

    if #diamonds > 0 then
        for var=#diamonds, 1,-1 do
            local _diamond = diamonds[var]
            if not tolua.isnull(_diamond) then
                _diamond:dispose()
            end
        end
        diamonds={}
    end
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
--根据房间号获取房间对象
function GameController.getRoomByKey(_key)
    if rooms then
        return rooms[_key]
    end
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
--代步机是否死亡
function GameController.isWalkDead()
    if not tolua.isnull(curPlayer) then
        return curPlayer:getWalk()
    end 
end


--初始化排行榜数据
local RANK_URL = "http://client.bpbjj.tysoul.com/charts/get/"
function GameController.initRankData()
--    if string.len(GameDataManager.AccountName) < 1 then
--    	return
--    end
    local function _onResponse(event)
        local request = event.request
        if event.name == "completed" then
            local _netData = request:getResponseData()
            local _resData = json.decode(_netData)
            if not _resData then
            	return
            end
            if GameDataManager.AccountId==0 and _resData.newPlayerId then
                GameDataManager.AccountId = _resData.newPlayerId
            end
            if _resData.playerStar then
                myRank.starRank = tonumber(_resData.playerStar.ranking)
                myRank.starNum = tonumber(_resData.playerStar.star)
            end
            if _resData.playerScore then
                myRank.scoreRank = tonumber(_resData.playerScore.ranking)
                myRank.scoreNum = tonumber(_resData.playerScore.score)
            end
            if _resData.starList then
                for var=1, #_resData.starList do
                    local _data = _resData.starList[var]
                    local _vo = clone(RankVo)
                    _vo.playerId = _data.playerId
                    _vo.playerName = _data.playerName
                    _vo.rankValue = _data.star
                    table.insert(starRank,_vo)
            	end
            end
            if _resData.scoreList then
                for var=1, #_resData.scoreList do
                    local _data = _resData.scoreList[var]
                    local _vo = clone(RankVo)
                    _vo.playerId = _data.playerId
                    _vo.playerName = _data.playerName
                    _vo.rankValue = _data.score
                    table.insert(scoreRank,_vo)
                end
            end
--        else
--            print("chjh net error 请求排行榜数据错误")
        end
    end
    local request = cc.HTTPRequest:createWithUrl(function(event)
        _onResponse(event)
    end, RANK_URL..GameDataManager.AccountId, cc.kCCHTTPRequestMethodGET)
    if request then
        request:setTimeout(20)
        request:start()
    else
        print("chjh error 初始化网络错误")
    end

--    --以下为测试数据
--    myRank.starNum = 10
--    myRank.scoreNum = 50
--    for var=1, 100 do
--        local _vo = clone(RankVo)
--        _vo.playerId = 1000+var
--        _vo.rankValue = math.random(1,200)
--        table.insert(starRank,_vo)
--    end
--    for var=1, 5 do
--        local _vo = clone(RankVo)
--        _vo.playerId = 1000+var
--        _vo.rankValue = math.random(200,10000)
--        table.insert(scoreRank,_vo)
--    end
end
--上传自己当前星级与积分
local RANK_UP_URL = "http://client.bpbjj.tysoul.com/charts/put"
function GameController.saveSelfScore(parameters)
    if GameDataManager.AccountId == 0 then
        return
    end
    local _star,_score = GameDataManager.getTotalStar_Score()
    local request = cc.HTTPRequest:createWithUrl(function(event)
        local request = event.request
        if event.name == "completed" then
            print("chjh 上传排行数据成功")
        else
            print("chjh 上传排行数据失败")
        end
    end, RANK_UP_URL, cc.kCCHTTPRequestMethodPOST)
    if request then
        request:addPOSTValue("playerId",GameDataManager.AccountId)
        request:addPOSTValue("playerName",GameDataManager.AccountName)
        request:addPOSTValue("star",_star)
        request:addPOSTValue("score",_score)
        request:setTimeout(20)
        request:start()
    else
        print("chjh error 初始化网络错误")
    end
end
--获取自己的排行
function GameController.getMyRank(parameters)
    return myRank
end
--获取排行榜数据
--@return:星级排行数据，得分排行数据
function GameController.getRankData(parameters)
    return starRank,scoreRank
end

--=============================引导相关==========================
local mainGuide = 0
--设置主界面引导功能
--_funcType功能类型，参见GameConfig之FUNC_TYPE
function GameController.setMainGuide(_funcType)
    mainGuide = _funcType
end
function GameController.getMainGuide()
    return mainGuide
end
--=============================End==========================

return GameController