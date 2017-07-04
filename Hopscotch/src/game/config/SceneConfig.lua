--[[
场景配置
]]

SceneConfig={}

SceneConfig[1]=
    {
        id = 1,
        type = Shop_Type.scene,
        sceneName = "shop/scenename_1.png",
        sceneIcon = "shop/scene_1.png",
        priceRes = "shop/price_6.png",
        des = "战争废墟",
        rmb = 0,   --人民币购买价格
        bgColor = {cc.c4b(170,97,140,255),cc.c4b(247,220,221,255)},
        specailRes = "#Room_special_3.png",
        specailRes2 = "#Room_special_1.png",
        offset = {-32,50,413,1000,0,32},--{panel2的偏移量，panel3的距离差，panel2的初始高度，panel3的初始高度，panel1位置的偏移量,panel2的距离差}
    }

SceneConfig[2]=
    {
        id = 2,
        type = Shop_Type.scene,
        sceneName = "shop/scenename_2.png",
        sceneIcon = "shop/scene_2.png",
        priceRes = "shop/price_6.png",
        des = "黄沙万里",
        rmb = 6,   --人民币购买价格
        payId = Payment.Scene_2,
        bgColor = {cc.c4b(145,196,224,255),cc.c4b(102,195,229,255)},
        specailRes = "#Room_special_3.png",
        specailRes2 = "#Room_special_1.png",
        offset = {0,50,379,-200,0,285},
    }

SceneConfig[3]=
    {
        id = 3,
        type = Shop_Type.scene,
        sceneName = "shop/scenename_3.png",
        sceneIcon = "shop/scene_3.png",
        priceRes = "shop/price_6.png",
        des = "海底",
        rmb = 6,   --人民币购买价格
        payId = Payment.Scene_3,
        bgColor = {cc.c4b(1,189,255,255),cc.c4b(62,237,255,255)},
        specailRes = false,
        specailRes2 = "#Scene_sea.png",
        offset = {0,0,521,800,-59,92},
    }

SceneConfig[4]=
    {
        id = 4,
        type = Shop_Type.scene,
        sceneName = "shop/scenename_4.png",
        sceneIcon = "shop/scene_4.png",
        priceRes = "shop/price_6.png",
        des = "奇幻森林",
        rmb = 6,   --人民币购买价格
        payId = Payment.Scene_4,
        bgColor = {cc.c4b(122,242,245,255),cc.c4b(28,227,243,255)},
        specailRes = "#Room_special_3.png",
        specailRes2 = "#Room_special_1.png",
        offset = {0,0,400,200,0,0},
    }

SceneConfig[5]=
    {
        id = 5,
        type = Shop_Type.scene,
        sceneName = "shop/scenename_5.png",
        sceneIcon = "shop/scene_5.png",
        priceRes = "shop/price_6.png",
        des = "冰天雪地",
        rmb = 6,   --人民币购买价格
        payId = Payment.Scene_5,
        bgColor = {cc.c4b(232,237,253,255),cc.c4b(93,196,248,255)},
        specailRes = "#Room_special_3.png",
        specailRes2 = "#Room_special_1.png",
        offset = {0,50,1918,2229,-207,87},
    }