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
        bgColor = {cc.c4b(170,97,140,255),cc.c4b(247,220,221,255)},
        specailRes = "#Room_special_3.png",
        specailRes2 = "#Room_special_1.png",
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
        bgColor = {cc.c4b(170,97,140,255),cc.c4b(247,220,221,255)},
        specailRes = "#Room_special_3.png",
        specailRes2 = "#Room_special_1.png",
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
        bgColor = {cc.c4b(170,97,140,255),cc.c4b(247,220,221,255)},
        specailRes = "#Room_special_3.png",
        specailRes2 = "#Room_special_1.png",
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
        bgColor = {cc.c4b(93,196,248,255),cc.c4b(221,230,250,255)},
        specailRes = "#Room_special_3.png",
        specailRes2 = "#Room_special_1.png",
    }