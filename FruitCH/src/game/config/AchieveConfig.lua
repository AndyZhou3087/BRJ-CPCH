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
    res = "",
    title = "标题",
    des = "单局使用XX道具XX个",
    rewardType = REWARD_TYPE.Gold,
    reward = 200,
}

AchieveConfig[2] = 
    {
        id = 2,
        res = "",
        title = "标题",
        des = "累计使用XX道具XX个",
        rewardType = REWARD_TYPE.Prop,
        reward = {{goodsId = 1,count = 2}},
    }
    
AchieveConfig[3] = 
    {
        id = 3,
        res = "",
        title = "标题",
        des = "累计消耗金币XX个",
        rewardType = REWARD_TYPE.Prop,
        reward = {{goodsId = 1,count = 2}},
    }
    
AchieveConfig[4] = 
    {
        id = 4,
        res = "",
        title = "标题",
        des = "累计消耗钻石XX个",
        rewardType = REWARD_TYPE.Prop,
        reward = {{goodsId = 1,count = 2}},
    }
    
AchieveConfig[5] = 
    {
        id = 5,
        res = "",
        title = "标题",
        des = "成功挑战XX关",
        rewardType = REWARD_TYPE.Prop,
        reward = {{goodsId = 1,count = 2}},
    }