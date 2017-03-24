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
--        Sprint = 1,--冲刺
--        Invincible = 2,--无敌(绿巨人)
--        Defence = 3,--防御
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
--    Invincible = 0,  --变身绿巨人
--    Magnet = 1,     --附带磁铁
--    DoubleMoney = 2, --金币翻倍
--    Immortal = 3,   --不死之躯
}

--角色被动技能类型
PLAYER_UNACT_TYPE = 
{
    
}

RoleConfig={}


RoleConfig[1]=
    {
        id = 1,
--        skillActType = PLAYER_ACT_TYPE.Magnet,    --角色技能
--        skillUnActType = PLAYER_ACT_TYPE.
        armatureName = "nv_pao",   --动画工程名
        roleName = "囧囧",     --角色名称
        roleMsg= "ui/uiImg/js_wz_01.png",  --角色信息介绍
        roleNameImg = "ui/uiImg/js_jj.png",   --角色名字图片
        lock = {},--解锁所需条件
        diamondPrice = 10,
        coinPrice = 2500,
        openLv = 0,     --角色皮肤解锁等级
        hp = 1,     --血量
        att = 1,    --攻击力
--        speed = ROLE_SPEED,  --移动速度
--        sprintTime = 0,   --冲刺时间,单位：秒
--        magnetTime = 0,   --磁铁时间,单位：秒
--        invincibleTime = 0,   --无敌时间,单位：秒
--        rocketTime = 0,    --普通火箭时间
--        superRocketTime = 0,  --超级火箭时间
--        sprintTimeAdd=0,     --冲刺时间延长 (s)
--        invincibleTimeAdd=0,     --无敌时间延长(s)
--        protectTimeAdd=0,       --护盾时间延长(s)
        lvMax = 30,      --角色满级等级
        quickMax = 50 , -- 一键满级价格
    }
    