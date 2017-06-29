--[[
游戏数据管理类
]]
local GameDataManager = {}

local ModleVo = require("game.data.ModleVo")
local GoodsVo = require("game.data.GoodsVo")
local SceneVo = require("game.data.SceneVo")
local playerVo = clone(require("game.data.PlayerVo"))

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")


--缓存当前正在使用的道具
local cacheGoodsDic = {}


--===================玩家数据相关=========================
local userData = {}
local modleDic = {}
local sceneDic = {}
local powerInfo={}   --体力恢复信息
local music=false
local sound=false
local curRoleID = 0 --当前出战角色id
local curSceneID = 0 --当前出战场景

local bossData = {}

--初始化玩家信息
function GameDataManager.initUserData()
    userData.diamond = DataPersistence.getAttribute("user_diamond") --钻石
    userData.record = DataPersistence.getAttribute("bestscore")      --记录初始化
    
    local modleList = DataPersistence.getAttribute("modle_list")  --角色皮肤列表
    for key, var in pairs(modleList) do
        modleDic[var.roleId] = var
    end
    
    curSceneID = DataPersistence.getAttribute("cur_sceneID")
    local sceneList = DataPersistence.getAttribute("scene_list")  --场景列表
    for key, var in pairs(sceneList) do
        sceneDic[var.sceneId] = var
    end

    music=DataPersistence.getAttribute("music")
    sound=DataPersistence.getAttribute("sound")

    local cacheGoods = DataPersistence.getAttribute("cacheGoods")
    for key, var in ipairs(cacheGoods) do
        cacheGoodsDic[var] = 1
    end
    

    --初始化角色数据
    curRoleID = DataPersistence.getAttribute("cur_roleID")
    GameDataManager.initPlayerVo()
    --初始化物品数据
    GameDataManager.initGoodsData()
    --初始化房间楼层权重
    GameDataManager.initRoomWeight()

    --初始化礼包信息
--    GameDataManager.initGift()

    --初始化排行榜数据
--    GameController.initRankData()
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

--扣除钻石
--@return:true扣除成功，false扣除失败
function GameDataManager.costDiamond(_value)
    if userData.diamond >= _value then
        userData.diamond = userData.diamond - _value
        --及时存档
        GameDataManager.saveGameData()
        GameDispatcher:dispatch(EventNames.EVENT_DIAMOND_CHANGE)
        return true
    else
        return false
    end
end
--增加钻石
function GameDataManager.addDiamond(_value)
    userData.diamond = userData.diamond + _value
    --及时存档
    GameDataManager.saveGameData()
    GameDispatcher:dispatch(EventNames.EVENT_DIAMOND_CHANGE)
    return true
end
--获取钻石
function GameDataManager.getDiamond()
    return userData.diamond
end

--解锁角色皮肤
function GameDataManager.unLockModle(_roleId)
    if modleDic[_roleId] then
        return
    end
    local _modleVo = clone(ModleVo)
    _modleVo.roleId = _roleId
    modleDic[_roleId] = _modleVo
    GameDataManager.setCurFightRole(_roleId)
    GameDispatcher:dispatch(EventNames.EVENT_UPDATE_ROLE,{id = _roleId})
end

--是否拥有相应角色
function GameDataManager.getRoleModle(_roleId)
    return modleDic[_roleId]
end

local points_game = 1
--增加分数(游戏内)(分数即为楼层)
function GameDataManager.setPoints(_value)
    points_game = _value
    GameDispatcher:dispatch(EventNames.EVENT_UPDATE_FLOOR)
    return true
end

--重置游戏分数
function GameDataManager.resetPoints()
    points_game = 1
    GameDispatcher:dispatch(EventNames.EVENT_UPDATE_FLOOR)
end

--获取分数
function GameDataManager.getPoints()
    return points_game
end

--保存最佳分数
function GameDataManager.saveRecord(_record)
    userData.record = _record
    GameDispatcher:dispatch(EventNames.EVENT_UPDATE_BEST)
    GameDataManager.saveGameData()
    Tools.printDebug("保存记录",_record)
end

--得到最高记录
function GameDataManager.getRecord()
    return userData.record
end

local diamond_game = 0
--添加游戏中得到的钻石(当前游戏)
function GameDataManager.addGameDiamond(_dia)
    diamond_game= diamond_game+_dia
    return true
end

--返回游戏中得到的钻石
function GameDataManager.getGameDiamond()
    return diamond_game
end

function GameDataManager.resetGameDiamond()
    diamond_game = 0
end

--===================End=========================


--===================角色信息相关=========================
--初始化角色信息
function GameDataManager.initPlayerVo()
    local roleConfig = RoleConfig[curRoleID]
    if roleConfig then
        playerVo.m_lifeNum = roleConfig.lifeNum
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
--减生命值
function GameDataManager.costLife(value)
    if curPlyaerVo.m_lifeNum>=value then
        curPlyaerVo.m_lifeNum=curPlyaerVo.m_lifeNum - value
--        GameDispatcher:dispatch(EventNames.EVENT_MAIN_LIFE_CHANGE)
    else
        curPlyaerVo.m_lifeNum = 0
    end
    return curPlyaerVo.m_lifeNum
end
--加生命值
function GameDataManager.addLife(value)
    curPlyaerVo.m_lifeNum=curPlyaerVo.m_lifeNum+value

    if curPlyaerVo.m_lifeNum>6 then
        curPlyaerVo.m_lifeNum=6
    end
    GameDispatcher:dispatch(EventNames.EVENT_MAIN_LIFE_CHANGE)
end

--获取生命值
function GameDataManager.getLife()
    return  curPlyaerVo.m_lifeNum
end
--===================End=========================

--===================场景信息相关=========================
--解锁新场景
function GameDataManager.unLockScene(_sceneId)
    if sceneDic[_sceneId] then
        return
    end
    local _sceneVo = clone(SceneVo)
    _sceneVo.sceneId = _sceneId
    sceneDic[_sceneId] = _sceneVo
    GameDataManager.setCurFightScene(_sceneId)
    GameDispatcher:dispatch(EventNames.EVENT_UPDATE_SCENE,{id = _sceneId})
end

--是否拥有相应场景
function GameDataManager.getSceneModle(_sceneId)
    return sceneDic[_sceneId]
end

--设置当前出战场景id
function GameDataManager.setCurFightScene(_sceneId)
    curSceneID = _sceneId
end

--获取当前出战场景id
function GameDataManager.getFightScene()
    return curSceneID
end

--===================End=========================

--===================使用道具相关=========================
local goodsList = {}
--初始化物品信息
function GameDataManager.initGoodsData()
    goodsList = DataPersistence.getAttribute("goods_list")  --物品列表
end
--获得一个道具
--@param1:道具id
--@param2:道具数量,默认为1
function GameDataManager.addGoods(_goodsId,_num)
    _num = _num or 1
    for key, var in pairs(goodsList) do
        if var.id == _goodsId then
            var.num = var.num + _num
--            GameDispatcher:dispatch(EventNames.EVENT_CHANGE_PROPS)
--            GameDispatcher:dispatch(EventNames.EVENT_UPDATE_PROP)
            return
        end
    end
    local _goodsVo = clone(GoodsVo)
    _goodsVo.id = _goodsId
    _goodsVo.num = _num
    table.insert(goodsList,_goodsVo)
    GameDataManager.saveGameData()
--    GameDispatcher:dispatch(EventNames.EVENT_CHANGE_PROPS)
--    GameDispatcher:dispatch(EventNames.EVENT_UPDATE_PROP)
end

--使用道具,此方法要检测玩家背包内是否拥有该道具
function GameDataManager.useGoods(_goodsId)
    for key, var in pairs(goodsList) do
        if var.id==_goodsId then
            if GameDataManager.useGoodsExp(_goodsId) then
                var.num = var.num - 1
                if var.num <= 0 then
                    table.remove(goodsList,key)
                end
                GameDataManager.saveGameData()
                return true
            else
                return false
            end
        end
    end
    return false
end
--使用道具，此方法不检测背包内是否有该道具
function GameDataManager.useGoodsExp(_goodsId)
    local goodsCon = GoodsConfig[_goodsId]
    if goodsCon then
        if goodsCon.type == GOODS_TYPE.Magnet then
            Tools.printDebug("brj 处理磁铁类型道具")
--            GameDispatcher:dispatch(EventNames.EVENT_USE_MAGNATE,{time=goodsCon.time+GameDataManager.getPlayerVo().m_magnetTime,radius=goodsCon.radius})
        elseif goodsCon.type == GOODS_TYPE.Phantom then
            Tools.printDebug("brj 幻影药水")
--            GameDispatcher:dispatch(EventNames.EVENT_USE_SHIELD,{type=2,time=goodsCon.time,damageArea=goodsCon.damageArea})
        elseif goodsCon.type == GOODS_TYPE.Rocket then
            Tools.printDebug("brj 冲刺火箭")
--            GameDispatcher:dispatch(EventNames.EVENT_USE_DRINK,{time=goodsCon.time+GameDataManager.getPlayerVo().m_invincibleTime,att=goodsCon.att,damageArea=goodsCon.damageArea})
        elseif goodsCon.type == GOODS_TYPE.SlowPotion then
            Tools.printDebug("brj 迟钝药水")
        elseif goodsCon.type == GOODS_TYPE.TokenAdd then
            Tools.printDebug("brj 获得一代币")
        end
        return true
    else
        printf("brj error 找不到id=%d的道具配置",_goodsId)
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
--=======================end==============================

--======================随机获取房间类型======================
local configArrD = {}
local _weightD = 0
local configArrC = {}
local _weightC = 0
local configArrB = {}
local _weightB = 0
local configArrA = {}
local _weightA = 0
local configArrS = {}
local _weightS = 0
local configArrR = {}
local _weightR = 0
local configArrF = {}
local _weightF = 0
function GameDataManager.initRoomWeight()
    configArrD,_weightD = GameDataManager.getSorting(MapGroupConfigD)
    configArrC,_weightC = GameDataManager.getSorting(MapGroupConfigC)
    configArrB,_weightB = GameDataManager.getSorting(MapGroupConfigB)
    configArrA,_weightA = GameDataManager.getSorting(MapGroupConfigA)
    configArrS,_weightS = GameDataManager.getSorting(MapGroupConfigS)
    configArrR,_weightR = GameDataManager.getSorting(MapRunningConfig)
    configArrF,_weightF = GameDataManager.getSorting(MapFirstGroup)
end

--组合排序
function GameDataManager.getSorting(arr)
    local configArr = {}
    local _weight = 0
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
    for var=1, #arr do
        _weight = _weight + arr[var].probability
    end
    return configArr,_weight
end

--按权重抽取一组数据
function GameDataManager.getDataIdByWeight(_type)
    local _weight,configArr
    if not _type then
        configArr = configArrR
        _weight = _weightR
    else
        if _type == Map_Grade.floor_D then
            configArr = configArrD
            _weight = _weightD
        elseif _type == Map_Grade.floor_C then
            configArr = configArrC
            _weight = _weightC
        elseif _type == Map_Grade.floor_B then
            configArr = configArrB
            _weight = _weightB
        elseif _type == Map_Grade.floor_A then
            configArr = configArrA
            _weight = _weightA
        elseif _type == Map_Grade.floor_S then
            configArr = configArrS
            _weight = _weightS
        else
            configArr = configArrF
            _weight = _weightF
        end 
    end
    local _wegt = math.random(1,_weight)
    Tools.printDebug("brj Hopscotch 随机权重值：",_wegt,_weight)
    local t = 0
    --得到当前id
    local id = 0
    for var=1, #configArr do
        t = t + configArr[var].probability
        if t >= _wegt then
            id = configArr[var]._id
            return id
        end
    end
    return id
end

--========================end==============================

--=======================礼包相关==============================
--礼包数据初始化
local VIPGiftData = {
    --最近一次领取日期
    r_stamp = 0,--时间戳
    r_year = 0,
    r_month = 0,
    r_day = 0,
    --有效日期
    e_stamp = 0,--时间戳
    e_year = 0,
    e_month = 0,
    e_day = 0,
    --剩余可领取天数,如果为负数则需要重新购买vip，为0则为刚好用完
    lastCount = -1,
}
function GameDataManager.initGift()
    local vipObj = DataPersistence.getAttribute("vip_gift")    --
    if vipObj.getDate > 0 then
        local rDate = os.date("*t",vipObj.getDate)
        VIPGiftData.r_stamp = vipObj.getDate
        VIPGiftData.r_year = rDate.year
        VIPGiftData.r_month = rDate.month
        VIPGiftData.r_day = rDate.day
    end
    if vipObj.endDate > 0 then
        local eDate = os.date("*t",vipObj.endDate)
        VIPGiftData.e_stamp = vipObj.endDate
        VIPGiftData.e_year = eDate.year
        VIPGiftData.e_month = eDate.month
        VIPGiftData.e_day = eDate.day
    end
    GameDataManager.updateVipData()
end
--更新vip月礼包领取信息
function GameDataManager.updateVipData()
    if VIPGiftData.e_stamp > 0 then
        local curDate = TimeUtil.getDate()
        local curStamp = os.time({year=curDate.year,month=curDate.month,day=curDate.day,hour=0})
        local lastCount
        if curStamp > VIPGiftData.e_stamp then
            --vip已经失效
            lastCount = -1
            VIPGiftData.r_stamp = 0
            VIPGiftData.r_year = 0
            VIPGiftData.r_month = 0
            VIPGiftData.r_day = 0
            VIPGiftData.e_stamp = 0
            VIPGiftData.e_year = 0
            VIPGiftData.e_month = 0
            VIPGiftData.e_day = 0
        else
            lastCount =  math.floor((VIPGiftData.e_stamp-curStamp)/(3600*24))+1
            if curStamp == VIPGiftData.r_stamp then
                lastCount = lastCount - 1  --今天已经领取过，所以剩余天数减去一天
            end
        end
        VIPGiftData.lastCount = lastCount
    end
end
--获取首充大礼包状态
--return 0:不可领取     1:可领取     2:已领取
function GameDataManager.getChargeGiftState()
    local freshMark = DataPersistence.getAttribute("charge_gift")
    return tonumber(freshMark)
end
--领取新手礼包
function GameDataManager.toGetChargeGift()
    DataPersistence.updateAttribute("charge_gift",2)
    return true
end

--领取vip礼包
function GameDataManager.toGetVipGift()
    if VIPGiftData.lastCount <= 0 then
        Tools.printDebug("领取次数已经用完")
        return false
    end
    local curDate = TimeUtil.getDate()
    local curStamp = os.time({year=curDate.year,month=curDate.month,day=curDate.day,hour=0})

    VIPGiftData.r_stamp = curStamp
    VIPGiftData.r_year = curDate.year
    VIPGiftData.r_month = curDate.month
    VIPGiftData.r_day = curDate.day
    VIPGiftData.lastCount = VIPGiftData.lastCount - 1

    -- VIP修改为最后一天领取完后  可立即在次购买领取  2016-3-3 21:45:19
    if VIPGiftData.lastCount <= 0 then
        VIPGiftData.lastCount = -1
        VIPGiftData.r_year = VIPGiftData.r_year - 1
        VIPGiftData.e_stamp = VIPGiftData.e_stamp - 3600*25
    end
    return true
end
--购买vip礼包
function GameDataManager.toBuyVipGift()
    local curDate = TimeUtil.getDate()
    local curStamp = os.time({year=curDate.year,month=curDate.month,day=curDate.day,hour=0})

    VIPGiftData.e_stamp = curStamp+(VIP_DAYS-1)*24*3600
    local endDate = os.date("*t",VIPGiftData.e_stamp)
    VIPGiftData.e_year = endDate.year
    VIPGiftData.e_month = endDate.month
    VIPGiftData.e_day = endDate.day
    VIPGiftData.lastCount = VIP_DAYS
end
--获取vip礼包领取次数
function GameDataManager.getVipGiftCount()
    GameDataManager.updateVipData()
    return VIPGiftData.lastCount
end
--今日是否已经领取
function GameDataManager.isTodayGet()
    local curDate = TimeUtil.getDate()
    return curDate.year==VIPGiftData.r_year and curDate.month==VIPGiftData.r_month and curDate.day==VIPGiftData.r_day
end
--=======================end==============================

--存储游戏数据
function GameDataManager.saveGameData()
--    if app:getUserState() <= USER_STATE.Login_State then
--        --还没进入游戏，不需存盘
--        return
--    end

    DataPersistence.updateAttribute("user_diamond",userData.diamond)
    DataPersistence.updateAttribute("bestscore",userData.record)
    DataPersistence.updateAttribute("cur_roleID",curRoleID)
    DataPersistence.updateAttribute("cur_sceneID",curSceneID)

    local modleList = {}
    for key, var in pairs(modleDic) do
        table.insert(modleList,var)
    end
    DataPersistence.updateAttribute("modle_list",modleList)
    
    local sceneList = {}
    for key, var in pairs(sceneDic) do
        table.insert(sceneList,var)
    end
    DataPersistence.updateAttribute("scene_list",sceneList)

    local cacheArr = {}
    for key, var in pairs(cacheGoodsDic) do
        table.insert(cacheArr,key)
    end
    DataPersistence.updateAttribute("cacheGoods",cacheArr)

    --物品相关
    DataPersistence.updateAttribute("goods_list",goodsList)

    DataPersistence.updateAttribute("music",music)
    DataPersistence.updateAttribute("sound",sound)

--    DataPersistence.updateAttribute("vip_gift",{getDate=VIPGiftData.r_stamp,endDate=VIPGiftData.e_stamp})

    DataPersistence.toSaveData()
end

return GameDataManager