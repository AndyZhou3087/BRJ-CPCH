--[[
道具配置
]]

GoodsConfig = {}

GOODS_TYPE =
    {
        StartSprint = 1,   --开局冲刺
        DeadSprint = 2,   --死亡冲刺
        StartProtect = 3,   --开局护盾
        DeadComtinue = 4,     --死亡接力
        RandomReward = 5,    --随机抽奖
        MysteryGift = 6,   --神秘礼包
        Magnet = 7,   --吸铁石
        GrantDrink = 8,   --巨人药水
        ConverGold = 9,    --金币转换
        LimitSprint = 10,    --极限冲刺
        CloudLadder = 11,    --浮云梯
        GameProtect = 12,   --游戏内护盾
    }
    
COST_TYPE = 
{
    Gold = 1,
    Diamond = 2,
}

--开局道具
GoodsConfig[1]=
    {
        id = 1,
        type = GOODS_TYPE.StartSprint,       --道具类型
        discrebe = "开局冲刺",
        res = "ui/Prop_2.png",
        time = 20,   --时间(单位：秒)
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25},   --道具价格{type:购买类型1金币，2钻石，price为价格}
        speed = 200,
    }

GoodsConfig[2]=
    {
        id = 2,
        type = GOODS_TYPE.DeadSprint,       --道具类型
        discrebe = "死亡冲刺",
        res = "ui/Prop_2.png",
        time = 2,   --时间(单位：秒)
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25},   --道具价格{type:购买类型1金币，2钻石，price为价格}
        speed = 200,
    }

GoodsConfig[3]=
    {
        id = 3,
        type = GOODS_TYPE.StartProtect,       --道具类型
        discrebe = "开局护盾",
        res = "ui/Prop_2.png",
        time = 13,   --时间(单位：秒)
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25}   --道具价格{type:购买类型1金币，2钻石，price为价格}
    }

GoodsConfig[4]=
    {
        id = 4,
        type = GOODS_TYPE.DeadComtinue,       --道具类型
        discrebe = "死亡接力",
        res = "ui/Prop_2.png",
        time = 8,   --时间(单位：秒)
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25}
    }

GoodsConfig[5]=
    {
        id = 5,
        type = GOODS_TYPE.RandomReward,       --道具类型
        discrebe = "随机抽奖",
        res = "ui/Prop_4.png",
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25}
    }
    
GoodsConfig[6]=
    {
        id = 6,
        type = GOODS_TYPE.MysteryGift,       --道具类型
        discrebe = "神秘礼包",
        res = "ui/Prop_2.png",
        reward = {{id=1,count=1},},
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25},
        content = {{goodId = 1,count=9},{goodId = 2,count=9},{goodId = 3,count=9},{goodId = 4,count=9},}
    }
    
--游戏中道具   
GoodsConfig[7]=
    {
        id = 7,
        type = GOODS_TYPE.Magnet,       --道具类型
        discrebe = "吸铁石",
        res = "ui/Prop_2.png",
        time = 2,   --时间(单位：秒)
        radius = 300,  --磁铁吸附半径
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25}
    }
    
GoodsConfig[8]=
    {
        id = 8,
        type = GOODS_TYPE.GrantDrink,       --道具类型
        discrebe = "巨人药水",
        res = "ui/Prop_2.png",
        time = 2,   --时间(单位：秒)
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25},
        scale = 1.5,  --巨人放大倍数
    }
    
GoodsConfig[9]=
    {
        id = 9,
        type = GOODS_TYPE.ConverGold,       --道具类型
        discrebe = "金币转换",
        res = "ui/Prop_2.png",
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        time = 50,
        cost = {type = COST_TYPE.Gold,price = 25}
    }
    
GoodsConfig[10]=
    {
        id = 10,
        type = GOODS_TYPE.LimitSprint,       --道具类型
        discrebe = "极限冲刺",
        res = "ui/Prop_2.png",
        time = 8,   --时间(单位：秒)
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25},
        speed = 300,
    }
    
GoodsConfig[11]=
    {
        id = 11,
        type = GOODS_TYPE.CloudLadder,       --道具类型
        discrebe = "浮云梯",
        res = "ui/Prop_2.png",
        time = 8,   --时间(单位：秒)
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25}
    }
    
GoodsConfig[12]=
    {
        id = 12,
        type = GOODS_TYPE.GameProtect,       --道具类型
        discrebe = "护盾",
        res = "ui/Prop_2.png",
        time = 8,   --时间(单位：秒)
        msg = "化身重甲疯牛，所向披靡",     --道具信息
        cost = {type = COST_TYPE.Gold,price = 25}
    }
    
