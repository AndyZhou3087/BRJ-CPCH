--[[
礼包配置
]]

GiftConfig = {}

GIFT_TYPE =
{
    Role = 1,
}

GiftConfig[1] = 
{
    id = 1,
    type = GIFT_TYPE.Role,
    roleId = 2,
    roleImg = "",
    bg = "",
    titleImg = "",
    roleDes = "见习",
    price = 6,
    reward = {role = 2,diamond = 60},
    payId = Payment.RoleGift_1,
}

GiftConfig[2] = 
    {
        id = 2,
        type = GIFT_TYPE.Role,
        roleId = 3,
        roleImg = "",
        bg = "",
        titleImg = "",
        roleDes = "见习",
        price = 10,
        reward = {role = 3,dayDiamond = 10},
        payId = Payment.RoleGift_2,
    }
    
GiftConfig[3] = 
    {
        id = 3,
        type = GIFT_TYPE.Role,
        roleId = 4,
        roleImg = "",
        bg = "",
        titleImg = "",
        roleDes = "见习",
        price = 15,
        reward = {role = 4,dayDiamond = 20},
        payId = Payment.RoleGift_3,
    }
    
GiftConfig[4] = 
    {
        id = 4,
        type = GIFT_TYPE.Role,
        roleId = 5,
        roleImg = "",
        bg = "",
        titleImg = "",
        roleDes = "见习",
        price = 20,
        reward = {role = 5,dayDiamond = 30},
        payId = Payment.RoleGift_4,
    }