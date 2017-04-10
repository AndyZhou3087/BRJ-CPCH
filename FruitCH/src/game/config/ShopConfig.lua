--[[
商店配置
]]

ShopConfig={}

SHOPITEM_TYPE = 
{
    Gift = 1,
    Power = 2,
    Gold = 3,
    Diamond = 4,
}

--购买类型
SHOPITEM_BUY = 
{
    Diamond = 1,  
    RMB = 2,
}

ShopConfig[1]=
{
    id = 1,
    type = SHOPITEM_TYPE.Gift,   --商品类型
    titleBg = "Common/Shop_item_4.png",  --商品标题背景资源
    titleRes = "ui/Shop_gift.png",    --商品标题资源
    res = "ui/ShopGift.png",   --商品资源
    describe = "hhhh",  --描述
    price = {type=SHOPITEM_BUY.RMB,rate=15,payId = Payment.Gift_1},   --价格
        content = {gold = 10,diamond = 10,prop={{id = 1,count = 1}},}   --礼包内容：金币，钻石，道具.没有可不填字段(角色礼包可每日领取)
}

ShopConfig[2]=
    {
        id = 2,
        type = SHOPITEM_TYPE.Gift,   --商品类型
        titleBg = "Common/Shop_item_4.png",  --商品标题背景资源
        titleRes = "ui/Shop_gift.png",    --商品标题资源
        res = "ui/ShopGift.png",   --商品资源
        describe = "hhhh",  --描述
        price = {type=SHOPITEM_BUY.RMB,rate=15,payId = Payment.Gift_2},   --价格
        content = {gold = 10,diamond = 10,prop={id = 1,count = 1},}   --礼包内容：金币，钻石，道具.没有可不填字段
    }
    
ShopConfig[3]=
    {
        id = 3,
        type = SHOPITEM_TYPE.Power,   --商品类型
        titleBg = "Common/Shop_item_4.png",  --商品标题背景资源
        titleRes = "ui/Shop_power.png",    --商品标题资源
        res = "ui/ShopPowerimg.png",   --商品资源
        describe = "hhhh",  --描述
        price = {type=SHOPITEM_BUY.RMB,rate=15,payId = Payment.Power_1},   --价格
        content = 1000000000,   --无限体力数
    }
    
ShopConfig[4]=
    {
        id = 4,
        type = SHOPITEM_TYPE.Power,   --商品类型
        titleBg = "Common/Shop_item_4.png",  --商品标题背景资源
        titleRes = "ui/Shop_power.png",    --商品标题资源
        res = "ui/ShopPowerimg.png",   --商品资源
        describe = "hhhh",  --描述
        price = {type=SHOPITEM_BUY.RMB,rate=15,payId = Payment.Power_2},   --价格
        content = 5
    }
    
ShopConfig[5]=
    {
        id = 5,
        type = SHOPITEM_TYPE.Diamond,   --商品类型
        titleBg = "Common/Shop_item_3.png",  --商品标题背景资源
        titleRes = "ui/Shop_gift.png",    --商品标题资源
        res = "ui/ShopDiamond_1.png",   --商品资源
        describe = "颗钻石",  --描述
        price = {type=SHOPITEM_BUY.RMB,rate=15,payId = Payment.Diamond_1},   --价格
        content = 20,
        initPrice = 20,
    }
    
ShopConfig[6]=
    {
        id = 6,
        type = SHOPITEM_TYPE.Diamond,   --商品类型
        titleBg = "Common/Shop_item_3.png",  --商品标题背景资源
        titleRes = "ui/Shop_gift.png",    --商品标题资源
        res = "ui/ShopDiamond_2.png",   --商品资源
        describe = "颗钻石",  --描述
        price = {type=SHOPITEM_BUY.RMB,rate=15,payId = Payment.Diamond_2},   --价格
        content = 40,
    }
    
ShopConfig[7]=
    {
        id = 7,
        type = SHOPITEM_TYPE.Diamond,   --商品类型
        titleBg = "Common/Shop_item_3.png",  --商品标题背景资源
        titleRes = "ui/Shop_gift.png",    --商品标题资源
        res = "ui/ShopDiamond_3.png",   --商品资源
        describe = "颗钻石",  --描述
        price = {type=SHOPITEM_BUY.RMB,rate=15,payId = Payment.Diamond_3},   --价格
        content = 128,
    }
    
ShopConfig[8]=
    {
        id = 8,
        type = SHOPITEM_TYPE.Diamond,   --商品类型
        titleBg = "Common/Shop_item_3.png",  --商品标题背景资源
        titleRes = "ui/Shop_gift.png",    --商品标题资源
        res = "ui/ShopDiamond_4.png",   --商品资源
        describe = "颗钻石",  --描述
        price = {type=SHOPITEM_BUY.RMB,rate=15,payId = Payment.Diamond_4},   --价格
        content = 166,
    }

ShopConfig[9]=
    {
        id = 9,
        type = SHOPITEM_TYPE.Gold,   --商品类型
        titleBg = "Common/Shop_item_5.png",  --商品标题背景资源
        titleRes = "ui/Shop_gift.png",    --商品标题资源
        res = "ui/ShopGift.png",   --商品资源
        describe = "金币",  --描述
        price = {type=SHOPITEM_BUY.Diamond,rate=15},   --价格
        content = 2000,
    }

ShopConfig[10]=
    {
        id = 10,
        type = SHOPITEM_TYPE.Gold,   --商品类型
        titleBg = "Common/Shop_item_5.png",  --商品标题背景资源
        titleRes = "ui/Shop_gift.png",    --商品标题资源
        res = "ui/ShopGift.png",   --商品资源
        describe = "金币",  --描述
        price = {type=SHOPITEM_BUY.Diamond,rate=15},   --价格
        content = 6600,
    }

ShopConfig[11]=
    {
        id = 11,
        type = SHOPITEM_TYPE.Gold,   --商品类型
        titleBg = "Common/Shop_item_5.png",  --商品标题背景资源
        titleRes = "ui/Shop_gift.png",    --商品标题资源
        res = "ui/ShopGift.png",   --商品资源
        describe = "金币",  --描述
        price = {type=SHOPITEM_BUY.Diamond,rate=15},   --价格
        content = 12800,
    }
ShopConfig[12]=
    {
        id = 12,
        type = SHOPITEM_TYPE.Gold,   --商品类型
        titleBg = "Common/Shop_item_5.png",  --商品标题背景资源
        titleRes = "ui/Shop_gift.png",    --商品标题资源
        res = "ui/ShopGift.png",   --商品资源
        describe = "金币",  --描述
        price = {type=SHOPITEM_BUY.Diamond,rate=15},   --价格
        content = 16600,
    }