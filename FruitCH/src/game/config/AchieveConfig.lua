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
    res = "ui/Prop_2.png",
    title = "标题",
    des = "单局使用XX道具XX个",
    useGoodsId = 7,
    useGoodsCount = 2,
    rewardType = REWARD_TYPE.Gold,
    reward = 200,
}

AchieveConfig[2] = 
    {
        id = 2,
        type = CONDITION_TYPE.TotalProp,
        res = "ui/Prop_2.png",
        title = "标题",
        des = "累计使用XX道具XX个",
        useGoodsId = 7,
        useGoodsCount = 2,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 2},
    }
    
AchieveConfig[3] = 
    {
        id = 3,
        type = CONDITION_TYPE.TotalGold,
        res = "ui/Prop_2.png",
        title = "标题",
        des = "累计消耗金币XX个",
        useGold = 100,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 2},
    }
    
AchieveConfig[4] = 
    {
        id = 4,
        type = CONDITION_TYPE.TotalDiamond,
        res = "ui/Prop_2.png",
        title = "标题",
        des = "累计消耗钻石XX个",
        useDiamond = 10,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 2},
    }
    
AchieveConfig[5] = 
    {
        id = 5,
        type = CONDITION_TYPE.Challenge,
        res = "ui/Prop_2.png",
        title = "标题",
        des = "成功挑战XX关",
        levels = 1,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 2},
    }