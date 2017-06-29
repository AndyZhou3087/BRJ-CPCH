--[[
道具配置
]]

GoodsConfig = {}

GOODS_TYPE =
    {
        SlowPotion = 1,   --迟钝药水
        Phantom = 2,    --幻影药水
        TokenAdd = 3,  --获得1代币
        Magnet = 4,     --吸铁石
        Rocket = 5,    --冲刺火箭
    }
    

GoodsConfig[1]=
    {
        id = 1,
        type = GOODS_TYPE.SlowPotion,       --道具类型
        discrebe = "迟钝药水",
        res = "goods/Goods_1.png",
        time = 3,   --时间(单位：秒)
        speed = 100,    --角色吃道具到降低的速度
    }

GoodsConfig[2]=
    {
        id = 2,
        type = GOODS_TYPE.Phantom,       --道具类型
        discrebe = "幻影药水",
        res = "goods/Goods_1.png",
        limit = 5,     --幻影数量上限
    }

GoodsConfig[3]=
    {
        id = 3,
        type = GOODS_TYPE.TokenAdd,       --道具类型
        discrebe = "获得1代币",
        res = "goods/Goods_1.png",
        count = 1,     --获得代币数量
    }

GoodsConfig[4]=
    {
        id = 4,
        type = GOODS_TYPE.Magnet,       --道具类型
        discrebe = "吸铁石",
        res = "goods/Goods_1.png",
        time = 5,   --时间(单位：秒)
        radius = 300,  --磁铁吸附半径
    }

GoodsConfig[5]=
    {
        id = 5,
        type = GOODS_TYPE.Rocket,       --道具类型
        discrebe = "冲刺火箭",
        res = "goods/Goods_1.png",
    }
