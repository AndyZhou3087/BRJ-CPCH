--[[
角色皮肤信息配置
]]

--玩家恢复体力上限值，低于此值则会自动定时恢复
USER_POWER_MAX = 5
--玩家体力恢复时间，单位：秒
POWER_RECOVER_TIME = 60*5

--角色状态
PLAYER_STATE=
    {
        Defence = 1,--护盾
        Magnet = 2,--磁铁
        StartSprint = 3,--开局冲刺状态
        DeadSprint = 4,--死亡冲刺状态
        StartProtect = 5,  --开局护盾状态
        MagnetProp = 6, --吸铁石道具
        GrankDrink = 7, --巨人状态
        LimitSprint = 8, --极限冲刺
        TransformGold = 9,--金币转换
        Slow = 10,  --滑冰速度减慢
    }
--角色动作
PLAYER_ACTION=
    {
        Run = "pao",    --跑动
        Jump = "tiao", --跳
        Attack  = "gongji" ,     -- 攻击
        Down = "luodi",   --落地
    }
--角色主动技能类型
PLAYER_ACT_TYPE = 
{
    Twojump = 1,  --二段跳跃
    Protect= 2,  --一次护盾技能
    Magnet = 3,     --附带磁铁
}

RoleConfig={}


RoleConfig[1]=
    {
        id = 1,
        skillAct = {},    --主动技能
        armatureName = "nv_pao",   --动画工程名
        roleName = "囧囧",     --角色名称
        roleImg = "ui/role_2.png",   --角色图片
        roleDes = "aaaaaaaaaaa",  --角色描述
        roleRevive = "ui/Revive_role2.png",
        lock = {},--解锁所需条件
        diamondPrice = 10,   --钻石购买价格
        coinPrice = 2500,    --金币购买价格
        rmb = 10,   --人民币购买价格
        hp = 1,     --血量
        att = 1,    --攻击力

        sprintTime = 0,   --冲刺时间,单位：秒
        magnetTime = 0,   --磁铁时间,单位：秒
        giantTime = 0,   --巨人时间,单位：秒
        transTime=0,     --转换时间 (s)
        cloudTime=0,     --浮云时间(s)

        initLv= 1 ,      --初始角色等级
        lvMax = #RoleLvs[1],      --角色满级等级
        quickMaxPrice = 50 , -- 一键满级价格
        payMaxLvId = Payment.RoleLevel_1,
    }
    
RoleConfig[2]=
    {
        id = 2,
        skillAct = {{type=PLAYER_ACT_TYPE.Magnet,radius = 300,}},    --主动技能
        armatureName = "nan3",   --动画工程名
        roleName = "囧囧",     --角色名称
        roleImg = "ui/role_1.png",   --角色图片
        roleDes = "aaaaaaaaaaa",  --角色描述
        roleRevive = "ui/Revive_role1.png",
        lock = {},--解锁所需条件
        diamondPrice = 10,   --钻石购买价格
        coinPrice = 2500,    --金币购买价格
        rmb = 10,   --人民币购买价格
        hp = 1,     --血量
        att = 1,    --攻击力

        sprintTime = 0,   --冲刺时间,单位：秒
        magnetTime = 0,   --磁铁时间,单位：秒
        giantTime = 0,   --巨人时间,单位：秒
        transTime=0,     --转换时间 (s)
        cloudTime=0,     --浮云时间(s)

        initLv= 1 ,      --初始角色等级
        lvMax = #RoleLvs[2],      --角色满级等级
        quickMaxPrice = 50 , -- 一键满级价格
        payMaxLvId = Payment.RoleLevel_2,
        payId = Payment.Role_2,
    }
    
RoleConfig[3]=
    {
        id = 3,
        skillAct = {{type=PLAYER_ACT_TYPE.Twojump},{type=PLAYER_ACT_TYPE.Protect},},    --主动技能
        armatureName = "nan4",   --动画工程名
        roleName = "囧囧",     --角色名称
        roleImg = "ui/role_4.png",   --角色图片
        roleDes = "aaaaaaaaaaa",  --角色描述
        roleRevive = "ui/Revive_role5.png",
        lock = {},--解锁所需条件
        diamondPrice = 10,   --钻石购买价格
        coinPrice = 2500,    --金币购买价格
        rmb = 10,   --人民币购买价格
        hp = 1,     --血量
        att = 1,    --攻击力

        sprintTime = 0,   --冲刺时间,单位：秒
        magnetTime = 0,   --磁铁时间,单位：秒
        giantTime = 0,   --巨人时间,单位：秒
        transTime=0,     --转换时间 (s)
        cloudTime=0,     --浮云时间(s)

        initLv= 1 ,      --初始角色等级
        lvMax = #RoleLvs[3],      --角色满级等级
        quickMaxPrice = 50 , -- 一键满级价格
        payMaxLvId = Payment.RoleLevel_3,
        payId = Payment.Role_3,
    }
    
RoleConfig[4]=
    {
        id = 4,
        skillAct = {{type=PLAYER_ACT_TYPE.Twojump},{type=PLAYER_ACT_TYPE.Protect},},    --主动技能
        armatureName = "nan5",   --动画工程名
        roleName = "囧囧",     --角色名称
        roleImg = "ui/role_5.png",   --角色图片
        roleDes = "aaaaaaaaaaa",  --角色描述
        roleRevive = "ui/Revive_role4.png",
        lock = {},--解锁所需条件
        diamondPrice = 10,   --钻石购买价格
        coinPrice = 2500,    --金币购买价格
        rmb = 10,   --人民币购买价格
        hp = 1,     --血量
        att = 1,    --攻击力

        sprintTime = 0,   --冲刺时间,单位：秒
        magnetTime = 0,   --磁铁时间,单位：秒
        giantTime = 0,   --巨人时间,单位：秒
        transTime=0,     --转换时间 (s)
        cloudTime=0,     --浮云时间(s)

        initLv= 1 ,      --初始角色等级
        lvMax = #RoleLvs[4],      --角色满级等级
        quickMaxPrice = 50 , -- 一键满级价格
        payMaxLvId = Payment.RoleLevel_4,
        payId = Payment.Role_4,
    }
    
RoleConfig[5]=
    {
        id = 5,
        skillAct = {{type=PLAYER_ACT_TYPE.Twojump},{type=PLAYER_ACT_TYPE.Protect},},    --主动技能
        armatureName = "nan6",   --动画工程名
        roleName = "囧囧",     --角色名称
        roleImg = "ui/role_3.png",   --角色图片
        roleDes = "aaaaaaaaaaa",  --角色描述
        roleRevive = "ui/Revive_role3.png",
        lock = {},--解锁所需条件
        diamondPrice = 10,   --钻石购买价格
        coinPrice = 2500,    --金币购买价格
        rmb = 10,   --人民币购买价格
        hp = 1,     --血量
        att = 1,    --攻击力

        sprintTime = 0,   --冲刺时间,单位：秒
        magnetTime = 0,   --磁铁时间,单位：秒
        giantTime = 0,   --巨人时间,单位：秒
        transTime=0,     --转换时间 (s)
        cloudTime=0,     --浮云时间(s)

        initLv= 1 ,      --初始角色等级
        lvMax = #RoleLvs[5],      --角色满级等级
        quickMaxPrice = 50 , -- 一键满级价格
        payMaxLvId = Payment.RoleLevel_5,
        payId = Payment.Role_5,
    }