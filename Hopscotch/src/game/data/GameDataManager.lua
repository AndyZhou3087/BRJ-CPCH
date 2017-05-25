--[[
游戏数据管理类
]]
local GameDataManager = {}

local ModleVo = require("game.data.ModleVo")
local GoodsVo = require("game.data.GoodsVo")
local playerVo = clone(require("game.data.PlayerVo"))

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")


--缓存当前正在使用的道具
local cacheGoodsDic = {}


--===================玩家数据相关=========================
local userData = {}
local modleDic = {}
local powerInfo={}   --体力恢复信息
local music=false
local sound=false
local curRoleID = 0 --当前出战角色id

local bossData = {}

--初始化玩家信息
function GameDataManager.initUserData()
    userData.gold = DataPersistence.getAttribute("user_gold")    --金币
    userData.diamond = DataPersistence.getAttribute("user_diamond") --钻石
    userData.points = DataPersistence.getAttribute("user_points")  --玩家积分
    local modleList = DataPersistence.getAttribute("modle_list")  --角色皮肤列表
    for key, var in pairs(modleList) do
        modleDic[var.roleId] = var
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

    --初始化签到信息
--    GameDataManager.initSignData()
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

--扣除金币
--@return:true扣除成功，false扣除失败
function GameDataManager.costGold(_value)
    if userData.gold >= _value then
        userData.gold = userData.gold - _value
--        GameDispatcher:dispatch(EventNames.EVENT_GOLD_CHANGE)
        return true
    else
        return false
    end
end
--增加金币
function GameDataManager.addGold(_value)
    userData.gold = userData.gold + _value
--    GameDispatcher:dispatch(EventNames.EVENT_GOLD_CHANGE)
    return true
end
--获取金币
function GameDataManager.getGold()
    return userData.gold
end
--扣除钻石
--@return:true扣除成功，false扣除失败
function GameDataManager.costDiamond(_value)
    if userData.diamond >= _value then
        userData.diamond = userData.diamond - _value
        --及时存档
        GameDataManager.saveGameData()
--        GameDispatcher:dispatch(EventNames.EVENT_DIAMOND_CHANGE)
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
--    GameDispatcher:dispatch(EventNames.EVENT_DIAMOND_CHANGE)
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

--增加积分
function GameDataManager.addPoints(_value)
    userData.points = userData.points + _value
--    GameDispatcher:dispatch(EventNames.EVENT_POINTS_CHANGE)
    return true
end

--扣除积分
--@return:true扣除成功，false扣除失败
function GameDataManager.costPoints(_value)
    if userData.points >= _value then
        userData.points = userData.points - _value
--        GameDispatcher:dispatch(EventNames.EVENT_POINTS_CHANGE)
        return true
    else
        return false
    end
end
--获取积分
function GameDataManager.getPoints()
    return userData.points
end

--===================End=========================

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


--===================角色信息相关=========================
--初始化角色信息
function GameDataManager.initPlayerVo()
    local roleConfig = RoleConfig[curRoleID]
    if roleConfig then
        local _lv = GameDataManager.getRoleModle(curRoleID).roleLv
        playerVo.m_roleId = curRoleID
        playerVo.m_level = _lv
        playerVo.m_lifeNum = roleConfig.lifeNum
        playerVo.m_hp = roleConfig.hp     --血量
        playerVo.m_att = roleConfig.att           -- 攻击力
        playerVo.m_score_rate = GameDataManager.getScoreRate(curRoleID,_lv)   --分数加成
        playerVo.m_coin_rate = GameDataManager.getMoneyRate(curRoleID,_lv)    --金币加成
        playerVo.m_jump = roleConfig.jump --弹跳值
        playerVo.m_damageArea = roleConfig.damageArea    --破坏面积（以角色中心点向外扩散的矩形区域长宽半径）
        playerVo.m_sprintTime = roleConfig.sprintTime   --冲刺时间
        playerVo.m_magnetTime = roleConfig.magnetTime   --磁铁时间
        playerVo.m_invincibleTime = roleConfig.invincibleTime   --无敌时间
        playerVo.m_rocketTime = roleConfig.rocketTime
        playerVo.m_superRocketTime = roleConfig.superRocketTime
        playerVo.m_leisheqiang = roleConfig.role_qiang  --镭射枪
        playerVo.m_daibuji = roleConfig.role_daibuji  --代步机
        playerVo.m_roleArm  = roleConfig.armatureName   --角色原动画
        playerVo.m_sprintTimeAdd= roleConfig.sprintTimeAdd   --冲刺时间延长 (s)
        playerVo.m_invincibleTimeAdd=roleConfig.invincibleTimeAdd   --无敌时间延长(s)
        playerVo.m_protectTimeAdd=roleConfig.protectTimeAdd       --护盾时间延长(s)
        playerVo.m_speed = roleConfig.speed    --移动速度
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
        if goodsCon.type == GoodsType.Magnet_Type then
            print("chjh 处理磁铁类型道具")
            GameDispatcher:dispatch(EventNames.EVENT_USE_MAGNATE,{time=goodsCon.time+GameDataManager.getPlayerVo().m_magnetTime,radius=goodsCon.radius})
        elseif goodsCon.type == GoodsType.Defend_Type then
            print("chjh 处理防护罩类型道具")
            GameDispatcher:dispatch(EventNames.EVENT_USE_SHIELD,{type=2,time=goodsCon.time,damageArea=goodsCon.damageArea})
        elseif goodsCon.type == GoodsType.Drink_Type then
            print("chjh 处理化学饮料类型道具")
            GameDispatcher:dispatch(EventNames.EVENT_USE_DRINK,{time=goodsCon.time+GameDataManager.getPlayerVo().m_invincibleTime,att=goodsCon.att,damageArea=goodsCon.damageArea})
        elseif goodsCon.type == GoodsType.Thor_Type then
            print("chjh 处理雷神之锤类型道具")
        end
        return true
    else
        printf("chjh error 找不到id=%d的道具配置",_goodsId)
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
        print("领取次数已经用完")
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

    DataPersistence.updateAttribute("user_gold",userData.gold)
    DataPersistence.updateAttribute("user_diamond",userData.diamond)

    DataPersistence.updateAttribute("cur_roleID",playerVo.m_roleId)
    DataPersistence.updateAttribute("user_sign",signList.curTable)--存储签到数据
    DataPersistence.updateAttribute("sign_reward",GameDataManager.getReward())

    local modleList = {}
    for key, var in pairs(modleDic) do
        table.insert(modleList,var)
    end
    DataPersistence.updateAttribute("modle_list",modleList)

    local cacheArr = {}
    for key, var in pairs(cacheGoodsDic) do
        table.insert(cacheArr,key)
    end
    DataPersistence.updateAttribute("cacheGoods",cacheArr)

    --物品相关
    DataPersistence.updateAttribute("goods_list",goodsList)

    DataPersistence.updateAttribute("music",music)
    DataPersistence.updateAttribute("sound",sound)

    DataPersistence.updateAttribute("vip_gift",{getDate=VIPGiftData.r_stamp,endDate=VIPGiftData.e_stamp})

    DataPersistence.toSaveData()
end

return GameDataManager