--[[
支付相关配置文件
]]
Payment=
{
        Diamond_1 = 1, --2元20钻商品
        Diamond_2 = 2, --4元56钻商品
        Diamond_3 = 3, --8元128钻商品
        Diamond_4 = 4, --10元188钻商品
        Gift_1 = 5, --2元金币礼包
        Gift_2 = 6, --30元钻石礼包
        Power_1 = 7, --无限体力
        Power_2 = 8, --5点体力
        Role_2 = 9,
        Role_3 = 10,
        Role_4 = 11,
        Role_5 = 12,
        RoleLevel_1 = 13,  --6元
        RoleLevel_2 = 14,
        RoleLevel_3 = 15,
        RoleLevel_4 = 16,
        RoleLevel_5 = 17,
        Revive = 18,  --复活6元
        RoleGift_1 = 19,  --6元
        RoleGift_2 = 20,  --10元
        RoleGift_3 = 21,  --15元
        RoleGift_4 = 22,  --20元
        
--        --获取对应物品价格,单位:分，如果是钻石商品则额外会返回钻石数量
--        getPrice = function(_itemId)
--            if Payment.Diamond_1==_itemId then
--        		return 100,12
--        	elseif Payment.Diamond_1_1==_itemId then
--                return 100,20
--            elseif Payment.Diamond_2==_itemId  then
--                return 600,78
--            elseif Payment.Diamond_2_1==_itemId then
--                return 600,120
--            elseif Payment.Diamond_3==_itemId  then
--                return 1000,138
--            elseif Payment.Diamond_3_1==_itemId then
--                return 1000,200
--            elseif Payment.Diamond_4==_itemId  then
--                return 2000,280
--            elseif Payment.Diamond_4_1==_itemId then
--                return 2000,400
--            elseif Payment.Month_Gift == _itemId  then
--                return 2000,"vip_gift",280
--            elseif Payment.Limit_Gift == _itemId  then
--                return 1000,"limit_gift",138
--            elseif Payment.Fresh_Gift == _itemId  then
--                return 100,"fresh_gift",188
--            elseif Payment.Relive == _itemId  then
--                return 200,"relive",20
--            else
--                return 0,0
--        	end
--        end,
}

    