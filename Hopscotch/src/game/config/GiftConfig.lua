--[[
礼包配置
]]

GiftConfig = {}

GIFT_TYPE =
{
    Role = 1,
    Vip = 2,
    Common = 3,
}

--角色礼包
GiftConfig[1] = 
{
    id = 1,
    type = GIFT_TYPE.Role,
    roleId = 2,
    roleImg = "ui/RoleDes_1.png",
    bg = "ui/Rolebg_1.jpg",
    titleImg = "ui/RoleGift_banner3.png",
    frameImg = "ui/RoleGift_frame1.png",
    caseImg = "ui/RoleGift_f1.png",
    roleDes = "见习忍者用户专属礼包",
    roleHead = "ui/RoleHead_1.png",
    rewardImg = "ui/RoleCost_1.png",
    price = 6,
    reward = {role = 2,diamond = 60},
    payId = Payment.RoleGift_1,
}

GiftConfig[2] = 
    {
        id = 2,
        type = GIFT_TYPE.Role,
        roleId = 3,
        roleImg = "ui/RoleDes_4.png",
        bg = "ui/Rolebg_4.jpg",
        titleImg = "ui/RoleGift_banner2.png",
        frameImg = "ui/RoleGift_frame4.png",
        caseImg = "ui/RoleGift_f3.png",
        roleDes = "忍者老师用户专属礼包",
        roleHead = "ui/RoleHead_4.png",
        rewardImg = "ui/RoleCost_2.png",
        price = 10,
        reward = {role = 3,dayDiamond = 10},
        payId = Payment.RoleGift_2,
    }
    
GiftConfig[3] = 
    {
        id = 3,
        type = GIFT_TYPE.Role,
        roleId = 4,
        roleImg = "ui/RoleDes_3.png",
        bg = "ui/Rolebg_3.jpg",
        titleImg = "ui/RoleGift_banner2.png",
        frameImg = "ui/RoleGift_frame3.png",
        caseImg = "ui/RoleGift_f3.png",
        roleDes = "精英忍者用户专属礼包",
        roleHead = "ui/RoleHead_3.png",
        rewardImg = "ui/RoleCost_3.png",
        price = 15,
        reward = {role = 4,dayDiamond = 20},
        payId = Payment.RoleGift_3,
    }
    
GiftConfig[4] = 
    {
        id = 4,
        type = GIFT_TYPE.Role,
        roleId = 5,
        roleImg = "ui/RoleDes_2.png",
        bg = "ui/Rolebg_2.jpg",
        titleImg = "ui/RoleGift_banner1.png",
        frameImg = "ui/RoleGift_frame2.png",
        caseImg = "ui/RoleGift_f1.png",
        roleDes = "忍者教授用户专属礼包",
        roleHead = "ui/RoleHead_2.png",
        rewardImg = "ui/RoleCost_4.png",
        price = 20,
        reward = {role = 5,dayDiamond = 30},
        payId = Payment.RoleGift_4,
    }

--vip礼包    
GiftConfig[5] = 
    {
        id = 5,
        type = GIFT_TYPE.Vip,
        icon = "ui/Vip_new_1.png",
        iconName = "ui/Vip_new_2.png",
        title = "gift/vip_new.png",
        des = "新手VIP",
        price = 8,
        dayDiamond = 6,
        payId = Payment.VipGift_1,
    }
    
GiftConfig[6] = 
    {
        id = 6,
        type = GIFT_TYPE.Vip,
        icon = "ui/Vip_silver_1.png",
        iconName = "ui/Vip_silver_2.png",
        title = "gift/vip_sliver.png",
        des = "银牌VIP",
        price = 10,
        dayDiamond = 10,
        payId = Payment.VipGift_2,
    }
    
GiftConfig[7] = 
    {
        id = 7,
        type = GIFT_TYPE.Vip,
        icon = "ui/Vip_gold_1.png",
        iconName = "ui/Vip_gold_2.png",
        title = "gift/vip_gold.png",
        des = "金牌VIP",
        price = 15,
        dayDiamond = 15,
        payId = Payment.VipGift_3,
    }
    
GiftConfig[8] = 
    {
        id = 8,
        type = GIFT_TYPE.Vip,
        icon = "ui/Vip_diamond_1.png",
        iconName = "ui/Vip_diamond_2.png",
        title = "gift/vip_diamond.png",
        des = "钻石VIP",
        price = 20,
        dayDiamond = 25,
        payId = Payment.VipGift_4,
    }
    
GiftConfig[9] = 
    {
        id = 9,
        type = GIFT_TYPE.Vip,
        icon = "ui/Vip_respect_1.png",
        iconName = "ui/Vip_respect_2.png",
        title = "gift/vip_respect.png",
        des = "尊贵VIP",
        price = 30,
        dayDiamond = 50,
        payId = Payment.VipGift_5,
    }
    
    
--其它礼包
GiftConfig[10] = 
    {
        id = 10,
        type = GIFT_TYPE.Common,
        icon = "ui/Gift_gold_1.png",
        iconName = "ui/Gift_gold_2.png",
        title = "gift/title_gold.png",
        des = "金币礼包",
        price = 2,
        gold = 2888,
        diamond = false,
        goods = false,
        payId = Payment.Gift_1,
        payCode = Payment.GoldGift,
        exitPayId = Payment.Exit_GoldGift,
        exitDes = "确定要退出游戏吗？现在只要2元即可获得金币礼包，领取请确认！退出请取消！客服电话：022-59086970.",
    }

GiftConfig[11] = 
    {
        id = 11,
        type = GIFT_TYPE.Common,
        icon = "ui/Gift_diamond_1.png",
        iconName = "ui/Gift_diamond_2.png",
        title = "gift/title_diamond.png",
        des = "钻石礼包",
        price = 30,
        gold = false,
        diamond = 600,
        goods = false,
        payId = Payment.Gift_2,
        payCode = Payment.DiamondGift,
        exitPayId = Payment.Exit_DiamondGift,
        exitDes = "确定要退出游戏吗？现在只要30元即可获得钻石礼包，领取请确认！退出请取消！客服电话：022-59086970.",
    }
    
GiftConfig[12] = 
    {
        id = 12,
        type = GIFT_TYPE.Common,
        icon = "ui/Gift_new_1.png",
        iconName = "ui/Gift_new_2.png",
        title = "gift/title_new.png",
        des = "新手礼包",
        price = 6,
        gold = 3000,
        diamond = 30,
        goods = false,
        payId = Payment.NewGift,
        payCode = Payment.NewGift_1,
        exitPayId = Payment.Exit_NewGift,
        exitDes = "确定要退出游戏吗？现在只要6元即可获得新手礼包，领取请确认！退出请取消！客服电话：022-59086970.",
    }
    
GiftConfig[13] = 
    {
        id = 13,
        type = GIFT_TYPE.Common,
        icon = "ui/Gift_pro_1.png",
        iconName = "ui/Gift_pro_2.png",
        title = "gift/title_pro.png",
        des = "进阶礼包",
        price = 8,
        gold = 6000,
        diamond = 60,
        goods = false,
        payId = Payment.ProGift,
        payCode = Payment.ProGift_1,
        exitPayId = Payment.Exit_ProGift,
        exitDes = "确定要退出游戏吗？现在只要8元即可获得进阶礼包，领取请确认！退出请取消！客服电话：022-59086970.",
    }
    
GiftConfig[14] = 
    {
        id = 14,
        type = GIFT_TYPE.Common,
        icon = "ui/Gift_prop_1.png",
        iconName = "ui/Gift_prop_2.png",
        title = "gift/title_prop.png",
        des = "道具大礼包",
        price = 10,
        gold = false,
        diamond = false,
        goods = {{id=1,count=5},{id=2,count=5},{id=3,count=5}},
        payId = Payment.PropsGift,
        payCode = Payment.PropsGift_1,
        exitPayId = Payment.Exit_PropsGift,
        exitDes = "确定要退出游戏吗？现在只要10元即可获得道具大礼包，领取请确认！退出请取消！客服电话：022-59086970.",
    }
    
GiftConfig[15] = 
    {
        id = 15,
        type = GIFT_TYPE.Common,
        icon = "ui/Gift_wealth_1.png",
        iconName = "ui/Gift_wealth_2.png",
        title = "gift/title_wealth.png",
        des = "财富大礼包",
        price = 15,
        gold = 1000,
        diamond = 200,
        goods = false,
        payId = Payment.WealthGift,
        payCode = Payment.WealthGift_1,
        exitPayId = Payment.Exit_WealthGift,
        exitDes = "确定要退出游戏吗？现在只要15元即可获得财富大礼包，领取请确认！退出请取消！客服电话：022-59086970.",
    }
    
GiftConfig[16] = 
    {
        id = 16,
        type = GIFT_TYPE.Common,
        icon = "ui/Gift_luxury_1.png",
        iconName = "ui/Gift_luxury_2.png",
        title = "gift/title_lunxth.png",
        des = "豪华大礼包",
        price = 20,
        gold = 1000,
        diamond = 200,
        goods = {{id=1,count=3},{id=2,count=3},{id=3,count=3}},
        payId = Payment.LuxuryGift,
        payCode = Payment.LuxuryGift_1,
        exitPayId = Payment.Exit_LuxuryGift,
        exitDes = "确定要退出游戏吗？现在只要20元即可获得豪华大礼包，领取请确认！退出请取消！客服电话：022-59086970.",
    }