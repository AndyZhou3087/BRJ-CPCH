--[[
每日任务配置
]]

TaskConfig = {}

TASKCONDITION_TYPE = 
    {
        RunDistance = 1,  --奔跑距离
        TotalProp = 2,  --累计使用道具个数
        TotalGold = 3,  --累计获得金币
    }

TaskConfig[1] = 
    {
        id = 1,
        type = TASKCONDITION_TYPE.RunDistance,
        res = "ui/Prop_2.png",
        title = "标题",
        des = "奔跑XX距离",
        distance = 10,    --奔跑距离(单位米换算)
        rewardType = REWARD_TYPE.Gold,
        reward = 200,
    }

TaskConfig[2] = 
    {
        id = 2,
        type = TASKCONDITION_TYPE.TotalProp,
        res = "ui/Prop_2.png",
        title = "标题",
        des = "累计使用XX道具XX个",
        useGoodsId = 7,
        useGoodsCount = 2,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 2},
    }

TaskConfig[3] = 
    {
        id = 3,
        type = TASKCONDITION_TYPE.TotalGold,
        res = "ui/Prop_2.png",
        title = "标题",
        des = "累计获得金币XX个",
        getGold = 100,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 2},
    }