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
        title = "奔跑吧忍者",
        des = "奔跑10000米",
        distance = 10000,    --奔跑距离(单位米换算)
        rewardType = REWARD_TYPE.Gold,
        reward = 500,
    }

TaskConfig[2] = 
    {
        id = 2,
        type = TASKCONDITION_TYPE.TotalProp,
        res = "ui/Prop_2.png",
        title = "磁力忍者",
        des = "累计使用吸铁石3次",
        useGoodsId = 7,
        useGoodsCount = 3,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 1},
    }

TaskConfig[3] = 
    {
        id = 3,
        type = TASKCONDITION_TYPE.TotalGold,
        res = "ui/Prop_2.png",
        title = "贮金忍者",
        des = "累计获得金币1000个",
        getGold = 1000,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 5,count = 1},
    }
	
TaskConfig[4] = 
    {
        id = 4,
        type = TASKCONDITION_TYPE.TotalProp,
        res = "ui/Prop_2.png",
        title = "冲刺忍者",
        des = "累计使用极限冲刺3次",
        useGoodsId = 10,
        useGoodsCount = 3,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 1},
    }
	
TaskConfig[5] = 
    {
        id = 5,
        type = TASKCONDITION_TYPE.TotalProp,
        res = "ui/Prop_2.png",
        title = "巨大忍者",
        des = "累计使用巨人药水3次",
        useGoodsId = 8,
        useGoodsCount = 3,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 2,count = 1},
    }
	
TaskConfig[6] = 
    {
        id = 6,
        type = TASKCONDITION_TYPE.TotalProp,
        res = "ui/Prop_2.png",
        title = "炼金忍者",
        des = "累计使用金币转换3次",
        useGoodsId = 10,
        useGoodsCount = 3,
        rewardType = REWARD_TYPE.Prop,
        reward = {goodsId = 1,count = 1},
    }
