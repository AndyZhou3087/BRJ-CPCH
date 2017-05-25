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
        GameDefence = 11,  --游戏中护盾
        Spring = 12,   --弹簧
    }
--角色动作
PLAYER_ACTION=
    {
        Run = "pao",    --跑动
        Jump = "tiao", --跳
        Attack  = "gongji" ,     -- 攻击
        Down = "luodi",   --落地
    }

RevivePrice = 50  --角色复活价格(钻石)

RoleConfig={}

RoleConfig[1]=
    {
        id = 1,
        armatureName = "nan3",   --动画工程名
        roleName = "忍者学生",     --角色名称
        roleImg = "ui/role_1.png",   --角色图片
        roleDes = "有梦想的忍者学生",  --角色描述
        roleRevive = "ui/Revive_role1.png",
        lock = {},--解锁所需条件
        diamondPrice = 10,   --钻石购买价格
        coinPrice = 2500,    --金币购买价格
        rmb = 0,   --人民币购买价格

        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }

RoleConfig[2]=
    {
        id = 2,
        armatureName = "nv_pao",   --动画工程名
        roleName = "见习忍者",     --角色名称
        roleImg = "ui/role_2.png",   --角色图片
        roleDes = "拥有能够吸收周围金币的能力",  --角色描述
        roleRevive = "ui/Revive_role2.png",
        lock = {},--解锁所需条件
        diamondPrice = 0,   --钻石购买价格
        coinPrice = 0,    --金币购买价格
        rmb = 6,   --人民币购买价格

        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }
    
RoleConfig[3]=
    {
        id = 3,
        armatureName = "nan4",   --动画工程名
        roleName = "忍者老师",     --角色名称
        roleImg = "ui/role_4.png",   --角色图片
        roleDes = "拥有二段跳跃的能力",  --角色描述
        roleRevive = "ui/Revive_role5.png",
        lock = {},--解锁所需条件
        diamondPrice = 0,   --钻石购买价格
        coinPrice = 0,    --金币购买价格
        rmb = 10,   --人民币购买价格

        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }
    
RoleConfig[4]=
    {
        id = 4,
        armatureName = "nan5",   --动画工程名
        roleName = "精英忍者",     --角色名称
        roleImg = "ui/role_5.png",   --角色图片
        roleDes = "拥有保护屏障能力",  --角色描述
        roleRevive = "ui/Revive_role4.png",
        lock = {},--解锁所需条件
        diamondPrice = 0,   --钻石购买价格
        coinPrice = 0,    --金币购买价格
        rmb = 15,   --人民币购买价格

        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }
    
RoleConfig[5]=
    {
        id = 5,
        armatureName = "nan6",   --动画工程名
        roleName = "忍者教授",     --角色名称
        roleImg = "ui/role_3.png",   --角色图片
        roleDes = "拥有所有能力的忍者教授",  --角色描述
        roleRevive = "ui/Revive_role3.png",
        lock = {},--解锁所需条件
        diamondPrice = 0,   --钻石购买价格
        coinPrice = 0,    --金币购买价格
        rmb = 20,   --人民币购买价格

        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }