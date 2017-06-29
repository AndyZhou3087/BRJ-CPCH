--[[
角色皮肤信息配置
]]

--向上滑跳动的力
Up_Jump = 270

--角色状态
PLAYER_STATE=
    {
        Slow = 1,--迟钝药水
        Magnet = 2,--磁铁
        Rocket = 3,   --火箭
        Phantom = 4,  --幻影
    }
--角色动作
PLAYER_ACTION=
    {
        Run = "pao",    --跑动
        Jump = "tiao", --跳
        Attack  = "gongji" ,     -- 攻击
        Down = "luodi",   --落地
    }

RoleConfig={}

RoleConfig[1]=
    {
        id = 1,
        type = Shop_Type.role,
        armatureName = "RoleAni_1",   --动画工程名
        jumpName = "RoleJump_1",   --跳跃动画名
        roleImg = "role/role_1.png",   --角色图片
        roleName = "shop/rolename_1.png",
        priceRes = "shop/price_6.png",
        roleDes = "奥特曼",  --角色描述
        rmb = 0,   --人民币购买价格
        lifeNum = 1,
    }

RoleConfig[2]=
    {
        id = 2,
        type = Shop_Type.role,
        armatureName = "RoleAni_2",   --动画工程名
        jumpName = "RoleJump_1",   --跳跃动画名
        roleImg = "role/role_2.png",   --角色图片
        roleName = "shop/rolename_2.png",
        priceRes = "shop/price_6.png",
        roleDes = "钢铁侠",  --角色描述
        rmb = 6,   --人民币购买价格
        lifeNum = 1,
        payId = Payment.Role_1,
    }
    
RoleConfig[3]=
    {
        id = 3,
        type = Shop_Type.role,
        armatureName = "RoleAni_3",   --动画工程名
        jumpName = "RoleJump_5",   --跳跃动画名
        roleImg = "role/role_3.png",   --角色图片
        roleName = "shop/rolename_3.png",
        priceRes = "shop/price_6.png",
        roleDes = "黑豹",  --角色描述
        rmb = 6,   --人民币购买价格
        lifeNum = 1,
        payId = Payment.Role_2,
    }
    
RoleConfig[4]=
    {
        id = 4,
        type = Shop_Type.role,
        armatureName = "RoleAni_4",   --动画工程名
        jumpName = "RoleJump_5",   --跳跃动画名
        roleImg = "role/role_4.png",   --角色图片
        roleName = "shop/rolename_4.png",
        priceRes = "shop/price_6.png",
        roleDes = "死侍",  --角色描述
        rmb = 6,   --人民币购买价格
        lifeNum = 1,
        payId = Payment.Role_3,
    }
    
RoleConfig[5]=
    {
        id = 5,
        type = Shop_Type.role,
        armatureName = "RoleAni_5",   --动画工程名
        jumpName = "RoleJump_1",   --跳跃动画名
        roleImg = "role/role_5.png",   --角色图片
        roleName = "shop/rolename_5.png",
        priceRes = "shop/price_6.png",
        roleDes = "闪电侠",  --角色描述
        rmb = 6,   --人民币购买价格
        lifeNum = 1,
        payId = Payment.Role_4,
    }
    
RoleConfig[6]=
    {
        id = 6,
        type = Shop_Type.role,
        armatureName = "RoleAni_6",   --动画工程名
        jumpName = "RoleJump_5",   --跳跃动画名
        roleImg = "role/role_6.png",   --角色图片
        roleName = "shop/rolename_6.png",
        priceRes = "shop/price_6.png",
        roleDes = "蜘蛛侠",  --角色描述
        rmb = 6,   --人民币购买价格
        lifeNum = 1,
        payId = Payment.Role_5,
    }
    
RoleConfig[7]=
    {
        id = 7,
        type = Shop_Type.role,
        armatureName = "RoleAni_7",   --动画工程名
        jumpName = "RoleJump_5",   --跳跃动画名
        roleImg = "role/role_7.png",   --角色图片
        roleName = "shop/rolename_7.png",
        priceRes = "shop/price_6.png",
        roleDes = "金刚狼",  --角色描述
        rmb = 6,   --人民币购买价格
        lifeNum = 1,
        payId = Payment.Role_6,
    }
    
RoleConfig[8]=
    {
        id = 8,
        type = Shop_Type.role,
        armatureName = "RoleAni_8",   --动画工程名
        jumpName = "RoleJump_5",   --跳跃动画名
        roleImg = "role/role_8.png",   --角色图片
        roleName = "shop/rolename_8.png",
        priceRes = "shop/price_6.png",
        roleDes = "绿巨人",  --角色描述
        rmb = 6,   --人民币购买价格
        lifeNum = 1,
        payId = Payment.Role_7,
    }
    
RoleConfig[9]=
    {
        id = 9,
        type = Shop_Type.role,
        armatureName = "RoleAni_9",   --动画工程名
        jumpName = "RoleJump_5",   --跳跃动画名
        roleImg = "role/role_9.png",   --角色图片
        roleName = "shop/rolename_9.png",
        priceRes = "shop/price_6.png",
        roleDes = "美国队长",  --角色描述
        rmb = 6,   --人民币购买价格
        lifeNum = 1,
        payId = Payment.Role_8,
    }
    
RoleConfig[10]=
    {
        id = 10,
        type = Shop_Type.role,
        armatureName = "RoleAni_10",   --动画工程名
        jumpName = "RoleJump_5",   --跳跃动画名
        roleImg = "role/role_10.png",   --角色图片
        roleName = "shop/rolename_10.png",
        priceRes = "shop/price_6.png",
        roleDes = "小丑",  --角色描述
        rmb = 6,   --人民币购买价格
        lifeNum = 1,
        payId = Payment.Role_9,
    }
    