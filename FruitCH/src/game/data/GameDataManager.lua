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
    GameDataManager.initPlayerVo()
    
    --初始化关卡数据
    GameDataManager.initFightData()
--    --初始化物品数据
    GameDataManager.initGoodsData()
    --初始化签到信息
--    GameDataManager.initSignData()
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
    GameDataManager.SaveData()
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
        GameDataManager.SaveData()
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
            return
        end
    end
    local _goodsVo = clone(GoodsVo)
    _goodsVo.id = _goodsId
    _goodsVo.num = _num
    table.insert(goodsList,_goodsVo)
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
                return true
            else
                return false
            end
        end
    end
    GameDataManager.SaveData()
    return false
end

--使用道具，此方法不检测背包内是否有该道具(场景内直接使用)
function GameDataManager.useGoodsExp(_goodsId)
    local goodsCon = GoodsConfig[_goodsId]
    if goodsCon then
        if goodsCon.type == GOODS_TYPE.StartSprint then
            Tools.printDebug("使用开局冲刺")
            GameDispatcher:dispatch(EventNames.EVENT_START_SPRINT,{time = goodsCon.time,speed = goodsCon.speed})
        elseif goodsCon.type == GOODS_TYPE.TopSpeed then
            Tools.printDebug("使用急速飞行")
            GameDispatcher:dispatch(EventNames.EVENT_TOP_FLY,{time = goodsCon.time,index = goodsCon.speedIndex,radius = goodsCon.radius})
        elseif goodsCon.type == GOODS_TYPE.DoubleScore then
            Tools.printDebug("使用双倍得分")
            GameController.doubleScore = 2
        elseif goodsCon.type == GOODS_TYPE.Relive then
            Tools.printDebug("生命接力")
            --  GameDataManager.addGoods(_goodsId,1)
            GameDispatcher:dispatch(EventNames.EVENT_LIFE,{time = goodsCon.time})
        elseif goodsCon.type == GOODS_TYPE.Protect then
            Tools.printDebug("使用保护罩")
            GameDispatcher:dispatch(EventNames.EVENT_PROTECT,{time = goodsCon.time})
        end
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
        playerVo.m_transTime = roleConfig.transTime   --转黄时间
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

--获取当前角色被动技能磁铁时间
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

--增加当前关卡获得金币(此时不含加成)
local curLevelCoin = 0
function GameDataManager.addLevelCoin(_coin)
    curLevelCoin = curLevelCoin + _coin
    GameDispatcher:dispatch(EventNames.EVENT_FIGHT_UPDATE_GOLD,{coin=curLevelCoin,animation=true})
    return curLevelCoin
end
function GameDataManager.getLevelCoin()
    return curLevelCoin
end

--存储关卡数据
--return1:是否首次过关，return2:当前星级
function GameDataManager.saveLevelData()
    local isFirst=false
    local _data = fightData[curLevelId]
    if not _data then
        _data = clone(LevelVo)
        fightData[curLevelId] = _data
        isFirst=true
    end

    local _levCon = SelectLevel[curLevelId]
    if _levCon then
        _data.id = curLevelId
        --如果此次得分高于上次则记录
        local old=_data.score
        if old < GameDataManager.getAllScore() then
            _data.score = GameDataManager.getAllScore()
        end
        --保存游戏最高分数(更适用于无尽模式)
--        if GameDataManager.getAllScore() > GameDataManager.getRecord()then
--            Tools.printDebug("刷新记录",GameDataManager.getAllScore())
--            GameDataManager.saveRecord(GameDataManager.getAllScore())
--        end
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

function GameDataManager.reward(parameters)
    signList.curTable.m_rand = math.random(1,table.getn(SignReward))
end

function GameDataManager.getReward(parameters)
    return signList.curTable.m_rand
end

--初始化签到信息
function GameDataManager.initSignData()
    signList.curTable = DataPersistence.getAttribute("user_sign")
    signList.curTable.m_rand = DataPersistence.getAttribute("sign_reward")
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
--当天是否签到
function GameDataManager.isDateSign()
    if signList.curTable.day==TimeUtil.getDate().day and signList.curTable.month==TimeUtil.getDate().month and signList.curTable.year==TimeUtil.getDate().year then
        return true
    else

        --       GameDataManager.setWarning("sign")
        GameDispatcher:dispatch(EventNames.EVENT_UPDATE_SIGNSTART)
        return false
    end
end
--获得签到的次数
function GameDataManager.getSignCount()
    return signList.curTable.signs
end

--更新签到
function GameDataManager.updateSign()
    signList.curTable.day = TimeUtil.getDate().day
    signList.curTable.month = TimeUtil.getDate().month
    signList.curTable.year = TimeUtil.getDate().year
    signList.curTable.signs = signList.curTable.signs+1
end
--===================End=========================

--=============================================================礼包相关
local oem={}

--初始礼包信息
function GameDataManager.initOemData()
    oem.curTable = DataPersistence.getAttribute("oem")
end

--购买礼包
function GameDataManager.buyGift()
    local _curTime = TimeUtil.getDate()
	--购买日期记录
    oem.curTable.year = _curTime.year
    oem.curTable.month = _curTime.month
    oem.curTable.day = _curTime.day-1
    --领取次数记录
    oem.curTable.numS=30
    GameDataManager.SaveData()
    Tools.printDebug("礼包购买日期",oem.curTable.year,oem.curTable.month,oem.curTable.day,"剩余领取次数",oem.curTable.numS)
end

--领取礼包
function GameDataManager.updateGift()
    local _curTime = TimeUtil.getDate()
    --领取日期记录
    oem.curTable.year = _curTime.year
    oem.curTable.month = _curTime.month
    oem.curTable.day = _curTime.day
    --领取次数记录
    oem.curTable.numS=oem.curTable.numS-1
    GameDataManager.SaveData()
    Tools.printDebug("领取礼包日期",oem.curTable.year,oem.curTable.month,oem.curTable.day,"剩余领取次数",oem.curTable.numS)
end

--当天是否领取了礼包
function GameDataManager.isDateGift()
    if oem.curTable.day==TimeUtil.getDate().day and oem.curTable.month==TimeUtil.getDate().month and oem.curTable.year==TimeUtil.getDate().year then 
        return true
    else
        return false
    end
end

--获得礼包的领取次数 
function GameDataManager.getGiftCount()

    if oem.curTable.numS <=0 then
        --Tools.printDebug("没有开通时直接返回")
        return oem.curTable.numS
    else
        local old = os.time({year=oem.curTable.year,month=oem.curTable.month,day=oem.curTable.day,hour=0})
        local cur = os.time({year=TimeUtil.getDate().year,month=TimeUtil.getDate().month,day=TimeUtil.getDate().day,hour=0})  
        local pass = math.floor((cur-old)/(3600*24))
        
        if pass>oem.curTable.numS or pass<0 then
        	oem.curTable.numS= 0
        elseif pass==1 or pass==0 then 
            return oem.curTable.numS 
        elseif pass>1 then 
            oem.curTable.numS=oem.curTable.numS-pass+1
            oem.curTable.year = TimeUtil.getDate().year
            oem.curTable.month =TimeUtil.getDate().month
            oem.curTable.day = TimeUtil.getDate().day-1
            GameDataManager.SaveData()
        end
        return oem.curTable.numS         
    end                 
end

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

    --物品相关
    DataPersistence.updateAttribute("goods_list",goodsList)

    DataPersistence.updateAttribute("music",music)
    DataPersistence.updateAttribute("sound",sound)

    DataPersistence.toSaveData()
end

return GameDataManager