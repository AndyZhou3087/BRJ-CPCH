--[[
游戏数据管理类
]]

local GameDataManager = {}
local GoodsVo = require("game.data.GoodsVo")
local LevelVo = require("game.data.LevelVo")
local ModleVo = require("game.data.ModleVo")
local playerVo = clone(require("game.data.PlayerVo"))

--=================玩家数据
local userData = {}
local modleDic = {}--角色表
local curRoleID = 0 --当前出战角色id

local music=false
local sound=false

local totalGold = 0
local totalDiamond = 0
local totalGood = {}
local singleGood = {}

local totalGetGold = 0
local totalDistance = 0
local totalDayGood = {}

--初始化玩家数据
function GameDataManager.init()
    userData.gold = DataPersistence.getAttribute("user_gold")    --金币
    userData.diamond = DataPersistence.getAttribute("user_diamond") --钻石
    userData.power = DataPersistence.getAttribute("user_power")  --玩家体力
    userData.points = DataPersistence.getAttribute("user_score")  --玩家积分
    userData.record = DataPersistence.getAttribute("record")      --记录初始化
    
    music=DataPersistence.getAttribute("music")
    sound=DataPersistence.getAttribute("sound")
    --初始化角色数据
    curRoleID = DataPersistence.getAttribute("cur_roleID")
    
    local modleList = DataPersistence.getAttribute("modle_list")  --角色皮肤列表
    for key, var in pairs(modleList) do
        modleDic[var.roleId] = var
    end
    
    totalGold = DataPersistence.getAttribute("useGold_total")
    totalDiamond = DataPersistence.getAttribute("useDiamond_total")
    totalGood = DataPersistence.getAttribute("useGood_total")
    
    totalGetGold = DataPersistence.getAttribute("getGold_total")
    totalDayGood = DataPersistence.getAttribute("day_useGood_total")
    totalDistance = DataPersistence.getAttribute("run_distance")
    
    GameDataManager.initPlayerVo()
    
    --初始化关卡数据
    GameDataManager.initFightData()
--    --初始化物品数据
    GameDataManager.initGoodsData()
    --初始化签到信息
    GameDataManager.initSignData()
    --初始化游戏成就
    GameDataManager.initAchieveData()
    --初始化每日任务信息
    GameDataManager.initDailyTaskData()
    --初始化角色礼包信息
    GameDataManager.initGiftData()
end

function GameDataManager.isMusicOpen()
    return music
end

function GameDataManager.isSoundOpen()
    return sound
end

function GameDataManager.setMusic(isOpen)
    music=isOpen
end

function GameDataManager.setSound(isOpen)
    sound=isOpen
end

--减金币
function GameDataManager.costGold(_value)
    if userData.gold >= _value then
        userData.gold = userData.gold - _value
        Tools.printDebug("当前金币",GameDataManager.getGold())
        GameDispatcher:dispatch(EventNames.EVENT_UPDATE_GOLD)
        GameDispatcher:dispatch(EventNames.EVENT_ROLEUPGRADE_UPDATE)
        GameDataManager.saveUseGold(_value)
        GameDataManager.SaveData()
        return true
    else
        return false
    end
end

--增加金币
function GameDataManager.addGold(_value)
    userData.gold = userData.gold + _value
    Tools.printDebug("当前金币",GameDataManager.getGold())
    GameDispatcher:dispatch(EventNames.EVENT_UPDATE_GOLD)
    GameDispatcher:dispatch(EventNames.EVENT_ROLEUPGRADE_UPDATE)
    GameDataManager.saveGetGold(_value)
    GameDataManager.SaveData()
    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.GetGold_Sound)
    return true
end

--获取金币
function GameDataManager.getGold()
    return userData.gold
end

--减钻石
function GameDataManager.costDiamond(_value)
    if userData.diamond >= _value then
        userData.diamond = userData.diamond-_value
        Tools.printDebug("当前钻石",GameDataManager.getDiamond())
        GameDispatcher:dispatch(EventNames.EVENT_UPDATE_DIAMOND)
        GameDataManager.saveUseDiamond(_value)
        GameDataManager.SaveData()
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Diamond_Cost)
        return true
    else
        return false
    end
end

--增加钻石
function GameDataManager.addDiamond(_value)
    userData.diamond = userData.diamond+_value
    Tools.printDebug("当前钻石",GameDataManager.getDiamond())
    GameDispatcher:dispatch(EventNames.EVENT_UPDATE_DIAMOND)
    GameDataManager.SaveData()
    return true
end

--获取钻石
function GameDataManager.getDiamond()
    return userData.diamond
end

--扣除体力
--@return:true扣除成功，false扣除失败
function GameDataManager.costPower(_value)
    if userData.power >= _value then
        local oldCost = USER_POWER_MAX-userData.power

        userData.power = userData.power - _value

        local _endT = GameDataManager.getPowerEndTime()
        local _curT = TimeUtil.getTimeStamp()
        if _endT > 0 then
            GameDataManager.setPowerEndTime(_endT+_value*POWER_RECOVER_TIME)
        else
            _endT = _curT + _value*POWER_RECOVER_TIME
            GameDataManager.setPowerEndTime(_endT)
        end

        GameDispatcher:dispatch(EventNames.EVENT_POWER_CHANGE)
        return true
    else
        return false
    end
end
--增加体力
function GameDataManager.addPower(_value)
    local oldCost = USER_POWER_MAX-userData.power
    local _curT = TimeUtil.getTimeStamp()
    local _endT = GameDataManager.getPowerEndTime()
    local _pastT = _curT+oldCost*POWER_RECOVER_TIME-_endT   --已经流失的时间
    --此处主要是检测是时间到加的体力还是其它调用加体力，小于则为非时间恢复所加
    if _pastT < _value*POWER_RECOVER_TIME then
        GameDataManager.setPowerEndTime(_endT-_value*POWER_RECOVER_TIME)
    end

    userData.power = userData.power + _value
    if userData.power >= USER_POWER_MAX then
--        userData.power = USER_POWER_MAX
        GameDataManager.setPowerEndTime(0)
    end
    Tools.printDebug("~~~~~~~~~~ 当前体力: ",userData.power)
    Tools.delayCallFunc(0.1,function()
        GameDispatcher:dispatch(EventNames.EVENT_POWER_CHANGE)
    end)
    return userData.power
end

--获取体力
function GameDataManager.getPower()
    return userData.power
end

--设置体力回满结束时间
function GameDataManager.setPowerEndTime(_time)
    DataPersistence.updateAttribute("recover_power_endTime",_time) --距体力回满结束时间戳
end
function GameDataManager.getPowerEndTime()
    return DataPersistence.getAttribute("recover_power_endTime") --距体力回满结束时间戳
end

--===================道具相关
local goodsList={}
--初始化物品
function GameDataManager:initGoodsData()
    goodsList = DataPersistence.getAttribute("goods_list")  --物品列表
end

--[[添加道具
@param1 道具id
@param2 道具数量
]]
function GameDataManager.addGoods(_goodsId,_num)
    Tools.printDebug("添加道具----------------------------",_goodsId)
    _num = _num or 1
    for key, var in pairs(goodsList) do
        if var.id == _goodsId then
            var.num = var.num + _num
            GameDispatcher:dispatch(EventNames.EVENT_PROP_UPDATE,{goodsId = _goodsId})
            return
        end
    end
    local _goodsVo = clone(GoodsVo)
    _goodsVo.id = _goodsId
    _goodsVo.num = _num
    table.insert(goodsList,_goodsVo)
    GameDispatcher:dispatch(EventNames.EVENT_PROP_UPDATE,{goodsId = _goodsId})
    GameDataManager.SaveData()
end

--使用道具,此方法要检测玩家背包内是否拥有该道具(主动使用)
function GameDataManager.useGoods(_goodsId)
    Tools.printDebug("使用道具",_goodsId)
    for key, var in pairs(goodsList) do
        if var.id==_goodsId then
            if GameDataManager.useGoodsExp(_goodsId) then
                var.num = var.num - 1
                if var.num <= 0 then
                    table.remove(goodsList,key)
                end
                GameDataManager.SaveData()
                return true
            else
                return false
            end
        end
    end
    return false
end

--使用道具，此方法不检测背包内是否有该道具(场景内直接使用)
function GameDataManager.useGoodsExp(_goodsId)
    local goodsCon = GoodsConfig[_goodsId]
    if goodsCon then
        if goodsCon.type == GOODS_TYPE.StartSprint then
            Tools.printDebug("使用开局冲刺")
            GameController.setStartProp(_goodsId,false)
            GameDispatcher:dispatch(EventNames.EVENT_START_SPRINT,{time = goodsCon.time,speed = goodsCon.speed,radius = goodsCon.radius})
        elseif goodsCon.type == GOODS_TYPE.DeadSprint then
            Tools.printDebug("使用死亡冲刺")
            GameController.setStartProp(_goodsId,false)
            GameDispatcher:dispatch(EventNames.EVENT_DEAD_SPRINT,{time = goodsCon.time,speed = goodsCon.speed,radius = goodsCon.radius})
        elseif goodsCon.type == GOODS_TYPE.StartProtect then
            Tools.printDebug("使用开局护盾")
            GameController.setStartProp(_goodsId,false)
            GameDispatcher:dispatch(EventNames.EVENT_START_PROTECT,{time = goodsCon.time})
        elseif goodsCon.type == GOODS_TYPE.DeadComtinue then
            Tools.printDebug("死亡接力")
            GameController.setStartProp(_goodsId,false)
            GameDispatcher:dispatch(EventNames.EVENT_DEAD_RELAY)
        elseif goodsCon.type == GOODS_TYPE.Magnet then
            Tools.printDebug("吸铁石")
            GameDispatcher:dispatch(EventNames.EVENT_MANGET,{time = goodsCon.time,radius = goodsCon.radius})
        elseif goodsCon.type == GOODS_TYPE.GrantDrink then
            Tools.printDebug("巨人药水")
            GameDispatcher:dispatch(EventNames.EVENT_GRANT_DRINK,{time = goodsCon.time,scale = goodsCon.scale})
        elseif goodsCon.type == GOODS_TYPE.LimitSprint then
            Tools.printDebug("极限冲刺")
            GameDispatcher:dispatch(EventNames.EVENT_LIMIT_SPRINT,{time = goodsCon.time,speed = goodsCon.speed,radius = goodsCon.radius})
        elseif goodsCon.type == GOODS_TYPE.ConverGold then
            Tools.printDebug("金币转换")
            GameDispatcher:dispatch(EventNames.EVENT_TRANSFORM_GOLD,{time = goodsCon.time})
        elseif goodsCon.type == GOODS_TYPE.GameProtect then
            Tools.printDebug("护盾")
            GameDispatcher:dispatch(EventNames.EVENT_GAME_PROTECT,{time = goodsCon.time})
        end
        GameDataManager.saveUseProp(_goodsId,1)
        GameDataManager.saveSingleProp(_goodsId,1)
        GameDataManager.saveDayUseProp(_goodsId,1)
        return true
    else
        printf(" error 找不到id=%d的道具配置",_goodsId)
        return false
    end
end

--获取物品数量
function GameDataManager.getGoodsNum(_goodsId)
    for key, var in pairs(goodsList) do
        if var.id==_goodsId then
            return var.num
        end
    end
    return 0
end

--重置物品数量
function GameDataManager.resetGoodsNum(_goodsId)
   local _resetNum = 0 
    for key, var in pairs(goodsList) do
        if var.id == _goodsId then
            var.num = _resetNum
            return
        end
    end
    local _goodsVo = clone(GoodsVo)
    _goodsVo.id = _goodsId
    _goodsVo.num = _resetNum
    table.insert(goodsList,_goodsVo)
    GameDataManager.SaveData()
end

--===================场景道具暂停恢复=====================
local gameProp = {}
function GameDataManager.setGamePropTime(_type,originTime,_speed)
    local pTime = math.ceil(Tools.getSysTime())
    if not gameProp[_type] then
        gameProp[_type] = {}
    end
    gameProp[_type].time = pTime
    gameProp[_type].m_Time = originTime
    if _speed then
        gameProp[_type].speed = _speed
    end
    Tools.printDebug("FruitPaoku..初始时间：",_type,gameProp[_type].m_Time,gameProp[_type].time)
end

function GameDataManager.setGamePauseTime(_type)
    local pTime = math.ceil(Tools.getSysTime())
    gameProp[_type].pTime = pTime
    Tools.printDebug("FruitPaoku..暂停时间：",_type,gameProp[_type].pTime)
end

function GameDataManager.getLeftTime(_type)
    if not gameProp[_type] then
		return 0
	end
    local leftTime = gameProp[_type].m_Time - (gameProp[_type].pTime - gameProp[_type].time)
    Tools.printDebug("FruitPaoku..剩余时间：",_type,leftTime)
    return leftTime
end

function GameDataManager.getMapSpeed(_type)
    if not gameProp[_type] then
        return 0
    end
    if not gameProp[_type].speed then
    	return 0
    end
    return gameProp[_type].speed
end

function GameDataManager.resetGameTime(parameters)
	gameProp = {}
end

--=====================end=============================

--===================角色信息相关=========================
--初始化角色信息
function GameDataManager.initPlayerVo()
    local roleConfig = RoleConfig[curRoleID]
    if roleConfig then
        local _lv = GameDataManager.getRoleModle(curRoleID).roleLv
        playerVo.m_roleId = curRoleID
        playerVo.m_level = _lv
        playerVo.m_hp = roleConfig.hp     --血量
        playerVo.m_att = roleConfig.att           -- 攻击力
        playerVo.m_score_rate = GameDataManager.getScoreRate(curRoleID,_lv)   --分数加成
        playerVo.m_coin_rate = GameDataManager.getMoneyRate(curRoleID,_lv)    --金币加成
        playerVo.m_sprintTime = roleConfig.sprintTime    --冲刺时间
        playerVo.m_magnetTime = roleConfig.magnetTime   --磁铁时间
        playerVo.m_giantTime = roleConfig.giantTime   --巨人时间
        playerVo.m_transTime = roleConfig.transTime   --转换时间
        playerVo.m_cloudTime = roleConfig.cloudTime    --浮云时间
    end
end

--解锁(获得)角色皮肤
function GameDataManager.unLockModle(_roleId)
    if modleDic[_roleId] then
        return
    end
    local _modleVo = clone(ModleVo)
    _modleVo.roleId = _roleId
    modleDic[_roleId] = _modleVo
    _modleVo.level = GameDataManager.updateUserLv(_roleId,RoleConfig[_roleId].initLv)
    GameDispatcher:dispatch(EventNames.EVENT_ROLE_CHANGEDATA,_roleId)
end
--角色皮肤数
function GameDataManager.getRoleModelCount()
	return #modleDic
end

--是否拥有相应角色
function GameDataManager.getRoleModle(_roleId)
    return modleDic[_roleId]
end
--检测是否有新的解锁皮肤
function GameDataManager.toCheckLockedModle(_lv)
    for key, var in pairs(RoleConfig) do
        if (not GameDataManager.getRoleModle(var.id)) and (_lv>=var.openLv) then
            GameDataManager.unLockModle(var.id)
        end
    end
end

--更换角色
function GameDataManager.changeRole(_roleId)
    if curRoleID == _roleId then
        return
    end
    local roleConfig = RoleConfig[_roleId]
    if roleConfig then
        curRoleID = _roleId
        GameDataManager.initPlayerVo()
        GameDispatcher:dispatch(EventNames.EVENT_ROLE_CHANGE)
    else
        printf("chjh erro 找不到id=%d的角色皮肤配置",_roleId)
    end
end

--设置当前出战角色id
function GameDataManager.setCurFightRole(_roleID)
    curRoleID = _roleID
end

--获取当前出战角色ID
function GameDataManager.getFightRole()
    return curRoleID
end

--获取等级分数加成
function GameDataManager.getScoreRate(_roleId,_lv)
    Tools.printDebug(_roleId,_lv)
    local _roleLvObj = RoleLvs[_roleId][_lv]
    if _roleLvObj then
        return _roleLvObj.scoreRate
    else
        return 0
    end
end

--获取等级金币加成
function GameDataManager.getMoneyRate(_roleId,_lv)
    local _roleLvObj = RoleLvs[_roleId][_lv]
    if _roleLvObj then
        return _roleLvObj.coinRate
    else
        return 0
    end
end

--获取当前角色被动技能时间
function GameDataManager.getUnActSkillTime(_roleId,_lv,type)
    local _roleLvObj = RoleLvs[_roleId][_lv]
    local _basic
    local _roleLvTime
    if type == GOODS_TYPE.Magnet then
        _basic = RoleConfig[_roleId].magnetTime
        _roleLvTime = _roleLvObj.magnetTime+_basic
    elseif type == GOODS_TYPE.GrantDrink then
        _basic = RoleConfig[_roleId].giantTime
        _roleLvTime = _roleLvObj.giantTime+_basic
    elseif type == GOODS_TYPE.ConverGold then
        _basic = RoleConfig[_roleId].transTime
        _roleLvTime = _roleLvObj.transTime+_basic
    elseif type == GOODS_TYPE.LimitSprint then
        _basic = RoleConfig[_roleId].sprintTime
        _roleLvTime = _roleLvObj.sprintTime+_basic
    elseif type == GOODS_TYPE.CloudLadder then
        _basic = RoleConfig[_roleId].cloudTime
        _roleLvTime = _roleLvObj.cloudTime+_basic
    end
--    Tools.printDebug("---角色技能时间:",_roleLvTime)
    if _roleLvObj then
        return _roleLvTime
    else
        return 0
    end
end

--获取等级攻击力
function GameDataManager.getPlayerVoAtt(_roleId)
    local _roleLvObj = RoleConfig[_roleId]
    if _roleLvObj then
        return _roleLvObj.att
    else
        return 0
    end
end


--更新角色等级
function GameDataManager.updateUserLv(_roleId,_lv)
    local _modleVo = modleDic[_roleId]
    if _modleVo then
        local roleCon = RoleConfig[_roleId]
        if roleCon then
            _modleVo.roleLv = _lv
            playerVo.m_level = _lv
            playerVo.m_score_rate = GameDataManager.getScoreRate(_roleId,_lv)   --分数加成
            playerVo.m_coin_rate = GameDataManager.getMoneyRate(_roleId,_lv)    --金币加成
        else
            printf("chjh error 找不到id=%d的角色配置",_roleId)
        end
    else
        printf("chjh error id=%d的角色你暂未拥有，不能升级",_roleId)
    end
    GameDispatcher:dispatch(EventNames.EVENT_ROLEUPGRADE_UPDATE)
end

function GameDataManager.getRoleLevel(_roleId)
    local _modleVo = modleDic[_roleId]
    if _modleVo then
        local roleCon = RoleConfig[_roleId]
        if roleCon then
            return _modleVo.roleLv
        else
            return 1
        end
    else
        return 1
    end
end

--获取原始角色数据对象
function GameDataManager.getOriginPlayerVo()
    return playerVo
end
--获取当前使用角色数据对象
local curPlyaerVo = nil
function GameDataManager.generatePlayerVo()
    curPlyaerVo = clone(playerVo)
end
function GameDataManager.getPlayerVo()
    return curPlyaerVo
end
--===================End=========================

--===================关卡相关=========================
local fightData = {}
--初始化战斗数据
function GameDataManager.initFightData()
    local fightArr = DataPersistence.getAttribute("fight_data")  --
    for key, var in pairs(fightArr) do
        fightData[var.id] = var
    end
end
--获取当前关卡战斗数据，没战斗过则返回空
function GameDataManager.getFightData(_levelId)
    return fightData[_levelId]
end
--获取当前已经解锁关卡数量
--function GameDataManager.getUlockLevelsNum(_chapId)
function GameDataManager.getUlockLevelsNum()
    return #fightData
end
--当前关卡id
local curLevelId = 0
--当前关卡id索引
local levelIdx = 0
--设置当前关卡id
function GameDataManager.setCurLevelId(_id,_index)
    curLevelId = _id
    levelIdx = _index
end
--获取当前关卡id
function GameDataManager.getCurLevelId()
    return curLevelId,levelIdx
end
--获取当前未开始关卡数据id
function GameDataManager.getNextFightDataId()
    if not fightData[#fightData] then
    	return 1
    end
    return fightData[#fightData].id+1
end
--增加当前关卡得分
local curLevelScore = 0
--_score:当前获得积分,_noRate:不需要加成,默认为nil即计算加成
function GameDataManager.addLevelScore(_score,_noRate)
    curLevelScore = _score
    GameDispatcher:dispatch(EventNames.EVENT_UPDATE_SCORE,curLevelScore)
    return curLevelScore
end
function GameDataManager.getLevelScore()
    return curLevelScore
end

function GameDataManager.getHistoryScore(_levelId)
    if not fightData[_levelId] then
		return 0
	end
    return fightData[_levelId].score
end

--增加当前关卡获得铜币(此时不含加成)
local curLevelCoin = 0
function GameDataManager.addLevelCoin(_coin)
    curLevelCoin = curLevelCoin + _coin
    GameDispatcher:dispatch(EventNames.EVENT_FIGHT_UPDATE_GOLD,{coin=curLevelCoin,animation=true})
    return curLevelCoin
end
function GameDataManager.getLevelCoin()
    return curLevelCoin
end

--获取当前关卡星级
function GameDataManager.getLevelStar(_levelId)
    local _data = fightData[_levelId]
    if _data then
        return _data.star
    end
    return 0
end

--存储关卡数据
--return1:是否首次过关，return2:当前星级
function GameDataManager.saveLevelData()
    local isFirst=false
    local curStar = 1
    local _data = fightData[curLevelId]
    if not _data then
        _data = clone(LevelVo)
        fightData[curLevelId] = _data
        isFirst=true
        GameDataManager.reachStandardLevel(curLevelId)
    end
    
    local _levCon = SelectLevel[curLevelId]
    if _levCon then
        _data.id = curLevelId
        --如果此次得分高于上次则记录
        local old=_data.score
        if old < GameDataManager.getAllScore() then
            _data.score = GameDataManager.getAllScore()
        end
        
        curStar = _levCon.getStar(GameDataManager.getAllScore())
        
        --如果此次星级高于上次则记录
        if curStar > _data.star then
            _data.star = curStar
        end
        _data.isPass = true
    end

    return isFirst
end

--重置关卡数据
function GameDataManager.resetLevelData()
    curLevelScore = 0
    curLevelCoin = 0
end

--保存最高记录
function GameDataManager.saveRecord(_record)
    userData.record = _record
    GameDataManager.SaveData()
    print("保存记录",_record)
end

--得到最高记录
function GameDataManager.getRecord()
    return userData.record
end

function GameDataManager.getAllScore()
    local _score = GameDataManager.getCountByCurrency(Coin_Type.Coin_Copper)*1+GameDataManager.getCountByCurrency(Coin_Type.Coin_Silver)*5
        +GameDataManager.getCountByCurrency(Coin_Type.Coin_Gold)*10+GameDataManager.getLevelScore()
    _score = math.ceil(_score*(1+curPlyaerVo.m_score_rate*0.01))
    --分数取整(GameController.doubleScore为是否使用双倍道具)
    _score=math.ceil(_score*GameController.doubleScore)
    return _score
end

--游戏中获得的总金币数
function GameDataManager.getAllFightCoins()
    local _coin = math.floor(GameDataManager.getLevelCoin()/3)
    _coin = math.ceil(_coin*(1+curPlyaerVo.m_coin_rate*0.01))
    return _coin
end

--游戏中获得币种数量
local currency = {}
function GameDataManager.addCurrencyCount(type,count)
    if not currency[type] then
    	currency[type] = {}
    	currency[type].count = 0
    end
    currency[type].count = currency[type].count + count
end

function GameDataManager.getCountByCurrency(type)
    if not currency[type] then
    	return 0
    end
    return currency[type].count
end

--===================签到信息=========================
local signList={}

--初始化签到信息
function GameDataManager.initSignData()
    signList.curTable = DataPersistence.getAttribute("user_sign")
    signList.m_rand = DataPersistence.getAttribute("sign_reward")
end

--当天是否签到
function GameDataManager.isDateSign()
    if signList.curTable.year==TimeUtil.getDate().year and signList.curTable.month==TimeUtil.getDate().month and signList.curTable.day==TimeUtil.getDate().day then
        return true
    else
        return false
    end
end
--获得签到的次数
function GameDataManager.getSignCount()
    if not signList.curTable.signs then
    	return 0
    end
    return signList.curTable.signs
end

--更新签到
function GameDataManager.updateSign()
    signList.curTable.day = TimeUtil.getDate().day
    signList.curTable.month = TimeUtil.getDate().month
    signList.curTable.year = TimeUtil.getDate().year
    signList.curTable.signs = signList.curTable.signs+1
end

function GameDataManager.resetSign()
    signList.curTable.day = TimeUtil.getDate().day
    signList.curTable.month = TimeUtil.getDate().month
    signList.curTable.year = TimeUtil.getDate().year
end

function GameDataManager.reward()
    signList.m_rand = math.random(1,#SignReward)
end

--获取奖励组
function GameDataManager.getReward()
    if not SignReward[signList.m_rand] then
        Tools.printDebug("------找不到此签到奖励组",signList.m_rand)
    	return
    end
    return SignReward[signList.m_rand]
end

function GameDataManager.resetSign()   --签到7天重置
    if signList.curTable.signs == 7 and (signList.curTable.day~=TimeUtil.getDate().day or signList.curTable.month~=TimeUtil.getDate().month or signList.curTable.year~=TimeUtil.getDate().year) then
        signList.curTable.day = TimeUtil.getDate().day
        signList.curTable.month = TimeUtil.getDate().month
        signList.curTable.year = TimeUtil.getDate().year
        signList.curTable.signs = 0
        GameDataManager.reward()
        return true
    else
        return false
    end
end
--===================End=========================

--===================游戏成就====================
local achieve = {}
function GameDataManager.initAchieveData(parameters)
	local achieveArr = DataPersistence.getAttribute("achieve")
    for key, var in pairs(achieveArr) do
        achieve[var.id] = var
    end
end

function GameDataManager.setFinishAchieveData(id,_state)
    if not achieve[id] then
		achieve[id] = {}
	end
	achieve[id].id = id
    achieve[id].state = _state
    GameDispatcher:dispatch(EventNames.EVENT_GET_ACHIEVE,{id = id,state = _state})
    GameDispatcher:dispatch(EventNames.EVENT_ACHIEVE_UPDATE)
end

function GameDataManager.getAchieveState(id)
    if not achieve[id] then
		return ACHIEVE_STATE.Unfinished
	end
    return achieve[id].state
end

--是否有领取状态
function GameDataManager.isHaveReciveState(parameters)
    for key, var in pairs(achieve) do
        if var.state == ACHIEVE_STATE.Finished then
			return true
		end
	end
	return false
end

--保存累计使用金币
function GameDataManager.saveUseGold(_cost)
    totalGold = totalGold + _cost
    GameDataManager.reachStandardGold(totalGold)
end
--获取总累计使用金币
function GameDataManager.getTotalUseGold()
    return totalGold
end

--保存累计使用钻石
function GameDataManager.saveUseDiamond(_cost)
    totalDiamond = totalDiamond + _cost
    GameDataManager.reachStandardDiamond(totalDiamond)
end
--获取总累计使用钻石
function GameDataManager.getTotalUseDiamond()
    return totalDiamond
end

--保存累计使用道具
function GameDataManager.saveUseProp(id,_cost)
    if not totalGood[id] then
    	totalGood[id] = {}
    	totalGood[id].id = id
    	totalGood[id].count = 0
    end
    totalGood[id].count = totalGood[id].count + _cost
    GameDataManager.reachStandardGoods(id,totalGood[id].count)
end
--获取总累计使用道具
function GameDataManager.getTotalUseProp(id)
    if not totalGood[id] then
    	return 0
    end
    return totalGood[id].count
end

function GameDataManager.saveSingleProp(id,_cost)
    if not singleGood[id] then
		singleGood[id] = {}
        singleGood[id].id = id
        singleGood[id].count = 0
	end
    singleGood[id].count = singleGood[id].count + _cost
    GameDataManager.reachStandardGoods(id,singleGood[id].count)
end
--关卡结束重置
function GameDataManager.resetSingleProp()
	singleGood = {}
end

--是否达到成就道具类型标准
function GameDataManager.reachStandardGoods(goodId,count)
    for var=1, #Tables.Achieve[CONDITION_TYPE.TotalProp] do
        local info = Tables.Achieve[CONDITION_TYPE.TotalProp][var]
        if GameDataManager.getAchieveState(info.id)== ACHIEVE_STATE.Unfinished and info.useGoodsId == goodId
            and info.useGoodsCount == count then
            GameDataManager.setFinishAchieveData(info.id,ACHIEVE_STATE.Finished)
            break
        end
    end
end

--是否达到成就金币类型标准
function GameDataManager.reachStandardGold(count)
    for var=1, #Tables.Achieve[CONDITION_TYPE.TotalGold] do
        local info = Tables.Achieve[CONDITION_TYPE.TotalGold][var]
        if GameDataManager.getAchieveState(info.id)== ACHIEVE_STATE.Unfinished and info.useGold <= count then
            GameDataManager.setFinishAchieveData(info.id,ACHIEVE_STATE.Finished)
        	break
        end
	end
end
--是否达到成就钻石类型标准
function GameDataManager.reachStandardDiamond(count)
    for var=1, #Tables.Achieve[CONDITION_TYPE.TotalDiamond] do
        local info = Tables.Achieve[CONDITION_TYPE.TotalDiamond][var]
        if GameDataManager.getAchieveState(info.id)== ACHIEVE_STATE.Unfinished and info.useDiamond <= count then
            GameDataManager.setFinishAchieveData(info.id,ACHIEVE_STATE.Finished)
            break
        end
    end
end
--是否闯关成功
function GameDataManager.reachStandardLevel(level)
    for var=1, #Tables.Achieve[CONDITION_TYPE.Challenge] do
        local info = Tables.Achieve[CONDITION_TYPE.Challenge][var]
        if GameDataManager.getAchieveState(info.id)== ACHIEVE_STATE.Unfinished and info.levels == level then
            GameDataManager.setFinishAchieveData(info.id,ACHIEVE_STATE.Finished)
            break
        end
    end
end

--===================end=========================

--===================每日任务====================
local DailyTask = {}
local dailyTime = {}
function GameDataManager.initDailyTaskData(parameters)
    local taskArr = DataPersistence.getAttribute("dailyTasks")
    for key, var in pairs(taskArr) do
        DailyTask[var.id] = var
    end
    dailyTime = DataPersistence.getAttribute("daily_time")
    if GameDataManager.isNewDay() then
    	GameDataManager.resetDailyTask()
    end
end

function GameDataManager.setFinishTaskData(id,_state)
    if not DailyTask[id] then
        DailyTask[id] = {}
    end
    DailyTask[id].id = id
    DailyTask[id].state = _state
    GameDispatcher:dispatch(EventNames.EVENT_GET_ACHIEVE,{id = id,state = _state})
end

function GameDataManager.getTaskState(id)
    if not DailyTask[id] then
        return ACHIEVE_STATE.Unfinished
    end
    return DailyTask[id].state
end

--保存每日累计获得金币
function GameDataManager.saveGetGold(_cost)
    totalGetGold = totalGetGold + _cost
    GameDataManager.reachStandardDayGold(totalGold)
end
--获取每日累计获得金币
function GameDataManager.getTotalGetGold()
    return totalGetGold
end

--保存每日累计使用道具
function GameDataManager.saveDayUseProp(id,_cost)
    if not totalDayGood[id] then
        totalDayGood[id] = {}
        totalDayGood[id].id = id
        totalDayGood[id].count = 0
    end
    totalDayGood[id].count = totalDayGood[id].count + _cost
    GameDataManager.reachStandardDayGoods(id,totalDayGood[id].count)
end
--获取总累计使用道具
function GameDataManager.getTotalDayUseProp(id)
    if not totalDayGood[id] then
        return 0
    end
    return totalDayGood[id].count
end

function GameDataManager.saveDayRunDistance(_dis)
    totalDistance = totalDistance + _dis
    GameDataManager.reachStandardRunDistance(totalDistance)
end
function GameDataManager.getDayRunDistance()
	return totalDistance
end

--每日零点重置
function GameDataManager.resetDailyTask()
    DailyTask = {}
    dailyTime.day = TimeUtil.getDate().day
    dailyTime.month = TimeUtil.getDate().month
    dailyTime.year = TimeUtil.getDate().year
end

function GameDataManager.isNewDay()
    if dailyTime.year==TimeUtil.getDate().year and dailyTime.month==TimeUtil.getDate().month and dailyTime.day==TimeUtil.getDate().day then
        return false
    else
        return true
    end
end

--是否达到每日使用道具任务类型标准
function GameDataManager.reachStandardDayGoods(goodId,count)
    for var=1, #Tables.DailyTask[TASKCONDITION_TYPE.TotalProp] do
        local info = Tables.DailyTask[TASKCONDITION_TYPE.TotalProp][var]
        if GameDataManager.getTaskState(info.id)== ACHIEVE_STATE.Unfinished and info.useGoodsId == goodId
            and info.useGoodsCount == count then
            GameDataManager.setFinishTaskData(info.id,ACHIEVE_STATE.Finished)
            break
        end
    end
end

--是否达到每日获得金币类型标准
function GameDataManager.reachStandardDayGold(count)
    for var=1, #Tables.DailyTask[TASKCONDITION_TYPE.TotalGold] do
        local info = Tables.DailyTask[TASKCONDITION_TYPE.TotalGold][var]
        if GameDataManager.getTaskState(info.id)== ACHIEVE_STATE.Unfinished and info.getGold <= count then
            GameDataManager.setFinishTaskData(info.id,ACHIEVE_STATE.Finished)
            break
        end
    end
end

--是否达到每日奔跑类型标准
function GameDataManager.reachStandardRunDistance(count)
    for var=1, #Tables.DailyTask[TASKCONDITION_TYPE.RunDistance] do
        local info = Tables.DailyTask[TASKCONDITION_TYPE.RunDistance][var]
        if GameDataManager.getTaskState(info.id)== ACHIEVE_STATE.Unfinished and info.distance <= count then
            GameDataManager.setFinishTaskData(info.id,ACHIEVE_STATE.Finished)
            break
        end
    end
end

--===================end=========================

--=========================角色礼包相关=========================
local gift={}

--初始礼包信息
function GameDataManager.initGiftData()
    local giftArr = DataPersistence.getAttribute("gift")
    for key, var in pairs(giftArr) do
        gift[var.giftId] = var
    end
end

--购买礼包
function GameDataManager.buyGift(giftId)
    if not gift[giftId] then
    	gift[giftId] = {}
    end
    local _curTime = TimeUtil.getDate()
	--购买日期记录
    gift[giftId].year = _curTime.year
    gift[giftId].month = _curTime.month
    gift[giftId].day = _curTime.day
    --领取id记录
    gift[giftId].giftId=giftId
    gift[giftId].dayDiamond = GiftConfig[giftId].reward.dayDiamond
    GameDataManager.addDiamond(gift[giftId].dayDiamond)
    GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="已获得"..gift[giftId].dayDiamond.."钻石"})
end

--领取礼包
function GameDataManager.updateGift()
    local _curTime = TimeUtil.getDate()
    for key, var in pairs(gift) do
        if var.year==_curTime.year and var.month==_curTime.month and var.day==_curTime.day then
        	
        else
            var.year = _curTime.year
            var.month = _curTime.month
            var.day = _curTime.day
            GameDataManager.addDiamond(var.dayDiamond)
            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="已获得"..var.dayDiamond.."钻石"})
        end
    end
end
--================================End==============================


--游戏数据保存
function GameDataManager.SaveData(parameters)
--    if app:getUserState() <= USER_STATE.Login_State then
--        --还没进入游戏，不需存盘
--        return
--    end

    DataPersistence.updateAttribute("user_gold",userData.gold)
    DataPersistence.updateAttribute("user_diamond",userData.diamond)
    DataPersistence.updateAttribute("user_power",userData.power)
    DataPersistence.updateAttribute("user_score",userData.points)    --玩家积分
    DataPersistence.updateAttribute("cur_roleID",playerVo.m_roleId)
    
    DataPersistence.updateAttribute("user_sign",signList.curTable)--存储签到数据
    DataPersistence.updateAttribute("sign_reward",signList.m_rand)
    
    DataPersistence.updateAttribute("useGold_total",totalGold)
    DataPersistence.updateAttribute("useDiamond_total",totalDiamond)
    
    local propArr = {}
    for key, var in pairs(totalGood) do
        table.insert(propArr,var)
    end
    DataPersistence.updateAttribute("useGood_total",propArr)
    
    DataPersistence.updateAttribute("getGold_total",totalGetGold)
    DataPersistence.updateAttribute("run_distance",totalDistance)
    
    local GoodArr = {}
    for key, var in pairs(totalDayGood) do
        table.insert(GoodArr,var)
    end
    DataPersistence.updateAttribute("day_useGood_total",GoodArr)

    local modleList = {}
    for key, var in pairs(modleDic) do
        table.insert(modleList,var)
    end
    DataPersistence.updateAttribute("modle_list",modleList)

    local fightArr = {}
    for key, var in pairs(fightData) do
        table.insert(fightArr,var)
    end
    DataPersistence.updateAttribute("fight_data",fightArr)
    --成就
    local achieveArr = {}
    for key, var in pairs(achieve) do
        table.insert(achieveArr,var)
    end
    DataPersistence.updateAttribute("achieve",achieveArr)
    --每日任务
    local taskArr = {}
    for key, var in pairs(DailyTask) do
        table.insert(taskArr,var)
    end
    DataPersistence.updateAttribute("dailyTasks",taskArr)
    
    DataPersistence.updateAttribute("daily_time",dailyTime)
    
    --角色礼包
    local giftArr = {}
    for key, var in pairs(gift) do
        table.insert(giftArr,var)
    end
    DataPersistence.updateAttribute("gift",giftArr)

    --物品相关
    DataPersistence.updateAttribute("goods_list",goodsList)

    DataPersistence.updateAttribute("music",music)
    DataPersistence.updateAttribute("sound",sound)

    DataPersistence.toSaveData()
end

return GameDataManager