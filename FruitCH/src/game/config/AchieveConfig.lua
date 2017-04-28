--[[
成就配置
]]

AchieveConfig = {}

--成就状态
ACHIEVE_STATE = 
{
    Unfinished = 1,  --未完成
    Finished = 2, --已完成
    Receive = 3,  --已领取
}

CONDITION_TYPE = 
{
    SingleProp = 1,  --单局使用道具个数
    TotalProp = 2,  --累计使用道具个数
    TotalGold = 3,  --累计消耗金币
    TotalDiamond = 4,  --累计消耗钻石
    Challenge = 5,  --挑战关卡
}

--成就奖励
REWARD_TYPE = 
{
    Gold = 1,
    Diamond = 2,
    Prop = 3,
}

AchieveConfig[1] = 
{
    id = 1,
    type = CONDITION_TYPE.SingleProp,
    res = "ui/ShopGold_2.png",
    title = "招财",
    des = "单局使用吸铁石2次",
    useGoodsId = 7,
    useGoodsCount = 2,
    rewardType = REWARD_TYPE.Gold,
    reward = 500,
}

AchieveConfig[2] = 
    {
        id = 2,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼磁力篇 上",
        des = "累计使用吸铁石10次",
        useGoodsId = 7,
        useGoodsCount = 10,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 1},
    }
    
AchieveConfig[3] = 
    {
        id = 3,
        type = CONDITION_TYPE.TotalGold,
        res = "ui/Prop_magnet.png",
        title = "金钱就是力量 一",
        des = "累计消耗金币2000个",
        useGold = 2000,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 1},
    }
    
AchieveConfig[4] = 
    {
        id = 4,
        type = CONDITION_TYPE.TotalDiamond,
        res = "ui/Prop_magnet.png",
        title = "以物易物 一",
        des = "累计消耗钻石20个",
        useDiamond = 20,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 1},
    }
    
AchieveConfig[5] = 
    {
        id = 5,
        type = CONDITION_TYPE.Challenge,
        res = "ui/Prop_7.png",
        title = "启程",
        des = "成功挑战第一关",
        levels = 1,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 2},
    }
	
AchieveConfig[6] = 
{
    id = 6,
    type = CONDITION_TYPE.SingleProp,
    res = "ui/ShopGold_2.png",
    title = "浩克",
    des = "单局使用巨人药水2次",
    useGoodsId =8 ,
    useGoodsCount = 2,
    rewardType = REWARD_TYPE.Gold,
    reward = 500,
}

AchieveConfig[7] = 
{
    id = 7,
    type = CONDITION_TYPE.SingleProp,
    res = "ui/ShopGold_2.png",
    title = "炼金",
    des = "单局使用金币转换2次",
    useGoodsId = 9,
    useGoodsCount = 2,
    rewardType = REWARD_TYPE.Gold,
    reward = 500,
}

AchieveConfig[8] = 
{
    id = 8,
    type = CONDITION_TYPE.SingleProp,
    res = "ui/ShopGold_2.png",
    title = "超越",
    des = "单局使用极限冲刺2次",
    useGoodsId = 10,
    useGoodsCount = 2,
    rewardType = REWARD_TYPE.Gold,
    reward = 500,
}

AchieveConfig[9] = 
{
    id = 9,
    type = CONDITION_TYPE.SingleProp,
    res = "ui/ShopGold_2.png",
    title = "虚实",
    des = "单局使用浮云梯2次",
    useGoodsId = 11,
    useGoodsCount = 2,
    rewardType = REWARD_TYPE.Gold,
    reward = 500,
}

AchieveConfig[10] = 
{
    id = 10,
    type = CONDITION_TYPE.SingleProp,
    res = "ui/ShopGold_2.png",
    title = "屏障",
    des = "单局使用护盾2次",
    useGoodsId = 12,
    useGoodsCount = 2,
    rewardType = REWARD_TYPE.Gold,
    reward = 500,
}

AchieveConfig[11] = 
    {
        id = 11,
        type = CONDITION_TYPE.TotalGold,
        res = "ui/Prop_1.png",
        title = "金钱就是力量 二",
        des = "累计消耗金币8000个",
        useGold = 8000,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 3,count = 1},
    }
	

	
AchieveConfig[12] = 
    {
        id = 12,
        type = CONDITION_TYPE.TotalGold,
        res = "ui/Prop_1.png",
        title = "金钱就是力量 三",
        des = "累计消耗金币20000个",
        useGold = 20000,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 3,count = 2},
    }
	
AchieveConfig[13] = 
    {
        id = 13,
        type = CONDITION_TYPE.TotalGold,
        res = "ui/ShopDiamond_1.png",
        title = "黄金率",
        des = "累计消耗金币50000个",
        useGold = 50000,
        rewardType = REWARD_TYPE.Diamond,
        reward = 20,
    }
	
AchieveConfig[14] = 
    {
        id = 14,
        type = CONDITION_TYPE.TotalDiamond,
        res = "ui/Prop_4.png",
        title = "以物易物 二",
        des = "累计消耗钻石80个",
        useDiamond = 80,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 5,count = 2},
    }
	
AchieveConfig[15] = 
    {
        id = 15,
        type = CONDITION_TYPE.TotalDiamond,
        res = "ui/ShopGold_2.png",
        title = "以物易物 三",
        des = "累计消耗钻石300个",
        useDiamond = 200,
        rewardType = REWARD_TYPE.Gold,
        reward = 2000,
    }
	
AchieveConfig[16] = 
    {
        id = 16,
        type = CONDITION_TYPE.TotalDiamond,
        res = "ui/Prop_8.png",
        title = "戈隆商人",
        des = "累计消耗钻石1000个",
        useDiamond = 1000,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 4,count = 1 },
    }
	
AchieveConfig[17] = 
    {
        id = 17,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼磁力篇 中",
        des = "累计使用吸铁石50次",
        useGoodsId = 7,
        useGoodsCount = 50,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 2},
    }
	
AchieveConfig[18] = 
    {
        id = 18,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼磁力篇 下",
        des = "累计使用吸铁石100次",
        useGoodsId = 7,
        useGoodsCount = 100,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 3},
    }
	
AchieveConfig[19] = 
    {
        id = 19,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼巨大化篇 上",
        des = "累计使用巨人药水10次",
        useGoodsId = 8,
        useGoodsCount = 10,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 1},
    }
	
AchieveConfig[20] = 
    {
        id = 20,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼巨大化篇 中",
        des = "累计使用巨人药水50次",
        useGoodsId = 8,
        useGoodsCount = 50,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 2},
    }
	
AchieveConfig[21] = 
    {
        id = 21,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼巨大化篇 下",
        des = "累计使用巨人药水100次",
        useGoodsId = 9,
        useGoodsCount = 100,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 3},
    }
	
AchieveConfig[22] = 
    {
        id = 22,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼转换篇 上",
        des = "累计使用金币转换10次",
        useGoodsId = 9,
        useGoodsCount = 10,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 1},
    }
	
AchieveConfig[23] = 
    {
        id = 23,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼转换篇 中",
        des = "累计使用金币转换50次",
        useGoodsId = 9,
        useGoodsCount = 50,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 2},
    }

AchieveConfig[24] = 
    {
        id = 24,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼转换篇 下",
        des = "累计使用金币转换100次",
        useGoodsId = 9,
        useGoodsCount = 100,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 3},
    }
	
AchieveConfig[25] = 
    {
        id = 25,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼冲刺篇 上",
        des = "累计使用极限冲刺10次",
        useGoodsId = 10,
        useGoodsCount = 10,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 1},
    }
	
AchieveConfig[26] = 
    {
        id = 26,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼冲刺篇 中",
        des = "累计使用极限冲刺50次",
        useGoodsId = 10,
        useGoodsCount = 50,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 2},
    }

AchieveConfig[27] = 
    {
        id = 27,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼冲刺篇 下",
        des = "累计使用极限冲刺100次",
        useGoodsId = 10,
        useGoodsCount = 100,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 3},
    }
	
AchieveConfig[28] = 
    {
        id = 28,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼道具篇 上",
        des = "累计使用浮云梯10次",
        useGoodsId = 11,
        useGoodsCount = 10,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 1},
    }

AchieveConfig[29] = 
    {
        id = 29,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼道具篇 中",
        des = "累计使用浮云梯50次",
        useGoodsId = 11,
        useGoodsCount = 50,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 2},
    }
	
AchieveConfig[30] = 
    {
        id = 30,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼道具篇 下",
        des = "累计使用浮云梯100次",
        useGoodsId = 11,
        useGoodsCount = 100,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 3},
    }
	
AchieveConfig[31] = 
    {
        id = 31,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼防御篇 上",
        des = "累计使用护盾10次",
        useGoodsId = 12,
        useGoodsCount = 10,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 1},
    }
	
AchieveConfig[32] = 
    {
        id = 32,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼防御篇 中",
        des = "累计使用护盾50次",
        useGoodsId = 12,
        useGoodsCount = 50,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 2},
    }
	
AchieveConfig[33] = 
    {
        id = 33,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_7.png",
        title = "忍术修炼防御篇 上",
        des = "累计使用护盾100次",
        useGoodsId = 12,
        useGoodsCount = 100,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 3},
    }
	
AchieveConfig[34] = 
    {
        id = 34,
        type = CONDITION_TYPE.Challenge,
        res = "ui/Prop_magnet.png",
        title = "忍者之路 一",
        des = "成功挑战第五关",
        levels = 5,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 1},
    }

AchieveConfig[35] = 
    {
        id = 35,
        type = CONDITION_TYPE.Challenge,
        res = "ui/ShopGold_2.png",
        title = "忍者之路 二",
        des = "成功挑战第十关",
        levels = 10,
        rewardType = REWARD_TYPE.Gold,
        reward = 400,
    }
	
AchieveConfig[36] = 
    {
        id = 36,
        type = CONDITION_TYPE.Challenge,
        res = "ui/Prop_4.png",
        title = "忍者之路 三",
        des = "成功挑战第十五关",
        levels = 15,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 5,count = 1},
    }
	
AchieveConfig[37] = 
    {
        id = 37,
        type = CONDITION_TYPE.Challenge,
        res = "ui/Prop_magnet.png",
        title = "忍者之路 四",
        des = "成功挑战第二十关",
        levels = 20,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 2},
    }
	
AchieveConfig[38] = 
    {
        id = 38,
        type = CONDITION_TYPE.Challenge,
        res = "ui/ShopDiamond_1.png",
        title = "忍者之路 五",
        des = "成功挑战第二十五关",
        levels = 25,
        rewardType = REWARD_TYPE.Diamond,
        reward = 5,
    }
	
AchieveConfig[39] = 
    {
        id = 39,
        type = CONDITION_TYPE.Challenge,
        res = "ui/Prop_1.png",
        title = "忍者之路 六",
        des = "成功挑战第三十关",
        levels = 30,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 3,count = 2},
    }
	
AchieveConfig[40] = 
    {
        id = 40,
        type = CONDITION_TYPE.Challenge,
        res = "ui/ShopGold_2.png",
        title = "忍者之路 七",
        des = "成功挑战第三十五关",
        levels = 35,
        rewardType = REWARD_TYPE.Gold,
        reward = 1000,
    }
	
AchieveConfig[41] = 
    {
        id = 41,
        type = CONDITION_TYPE.Challenge,
        res = "ui/ShopDiamond_1.png",
        title = "忍者之路 八",
        des = "成功挑战第四十关",
        levels = 40,
        rewardType = REWARD_TYPE.Diamond,
        reward = 10,
    }