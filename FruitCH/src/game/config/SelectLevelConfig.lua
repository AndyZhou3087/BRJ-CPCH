--[[
关卡路点配置
]]

--======================以下为关卡列表配置=============================
SelectLevel={}
--此为关卡配置说明，最好不要删除
--{
--    _id = 1,
--    res = "Select_1.png",   --关卡路点资源
--    rect = cc.rect(102,81),  --关卡图片区域大小
--    pos = {x = 100,y = 100},  --关卡路点位置[960,540]范围内
--    costPower = 1,  --所消耗体力
--    coinAward = 50, --金币奖励
--    powerAward = 0,   --体力奖励
--    --开局前道具展示 
--    goods = {9,10,11,12},
--    map = {1,1,1,1,0},    --地图组，此id对应MapGroupConfig中配置文件，0表示无地图组
--    obstacle=13,   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
--    coins = 0,    --金币, 此id对应CoinsConfig配置文件，填0表示无
--    goods=0,      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
--    gap = 500,    --每组之间的间隔差距，单位:像素
--    endPoint = 5000,  --终点距离，单位：像素
--}
SelectLevel[1]= 
{ 
    _id=1, 
    res = "Select/Select_1.png",
    rect = {102,81},
    pos = {x = 77,y = 88},
    costPower=1,
    coinAward=false, --金币奖励
    powerAward=false, --体力奖励
    startGoods={1,2,3,4,5}, --开局道具
    map = {1,1,1,1,0},    --地图组，此id对应MapGroupConfig中配置文件，0表示无地图组
--    obstacle={13,13,13,0},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
--    coins = {3,3,3,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
--    goods={1,1,1,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
    gap = 500,    --每组之间的间隔差距，单位:像素
    speed = 32,  --每一关卡速度
    getStar = function(score)     --星级分数配置
        if score >= 300 then
        	return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
    end,
    isClip = false,  --关卡是否遮罩
    giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素
}

SelectLevel[2]= 
    { 
        _id=2, 
        res = "Select/Select_2.png",
        rect = {191,220},
        pos = {x = 120,y = 220},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素
    }
    
SelectLevel[3]= 
    { 
        _id=3, 
        res = "Select/Select_3.png",
        rect = {134,94},
        pos = {x = 200,y = 310},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素
    }
    
SelectLevel[4]= 
    { 
        _id=4, 
        res = "Select/Select_4.png",
        rect = {137,112},
        pos = {x = 275,y = 395},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = ture,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素
    }
    
SelectLevel[5]= 
    { 
        _id=5, 
        res = "Select/Select_4.png",
        rect = {137,112},
        pos = {x = 345,y = 310},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }
    
SelectLevel[6]= 
    { 
        _id=6, 
        res = "Select/Select_5.png",
        rect = {84,80},
        pos = {x = 400,y = 210},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素
    }
    
SelectLevel[7]= 
    { 
        _id=7, 
        res = "Select/Select_7.png",
        rect = {59,60},
        pos = {x = 430,y = 100},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素
    }
    
SelectLevel[8]= 
    { 
        _id=8, 
        res = "Select/Select_8.png",
        rect = {55,64},
        pos = {x = 510,y = 40},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},     --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素
    }
    
SelectLevel[9]= 
    { 
        _id=9, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 580,y = 110},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[10]= 
    { 
        _id=10, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 620,y = 200},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[11]= 
    { 
        _id=11, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 650,y = 305},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[12]= 
    { 
        _id=12, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 670,y = 410},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[13]= 
    { 
        _id=13, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 800,y = 415},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = ture,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素
    }

SelectLevel[14]= 
    { 
        _id=14, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 885,y = 330},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[15]= 
    { 
        _id=15, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 915,y = 230},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = ture,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[16]= 
    { 
        _id=16, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 960,y = 100},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }
    
SelectLevel[17]= 
    { 
        _id=17, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1060,y = 40},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = ture,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[18]= 
    { 
        _id=18, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1140,y = 120},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[19]= 
    { 
        _id=19, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1195,y = 240},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[20]= 
    { 
        _id=20, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1245,y = 380},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[21]= 
    { 
        _id=21, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1430,y = 400},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = ture,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[22]= 
    { 
        _id=22, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1495,y = 310},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[23]= 
    { 
        _id=23, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1535,y = 210},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[24]= 
    { 
        _id=24, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1680,y = 155},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[25]= 
    { 
        _id=25, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1780,y = 250},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[26]= 
    { 
        _id=26, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1835,y = 360},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[27]= 
    { 
        _id=27, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1935,y = 435},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[28]= 
    { 
        _id=28, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2050,y = 355},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[29]= 
    { 
        _id=29, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2065,y = 215},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[30]= 
    { 
        _id=30, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2155,y = 140},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[31]= 
    { 
        _id=31, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2215,y = 250},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[32]= 
    { 
        _id=32, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2205,y = 330},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[33]= 
    { 
        _id=33, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2250,y = 435},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = ture,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[34]= 
    { 
        _id=34, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2380,y = 435},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[35]= 
    { 
        _id=35, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2420,y = 365},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[36]= 
    { 
        _id=36, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2380,y = 275},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = ture,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[37]= 
    { 
        _id=37, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2355,y = 170},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[38]= 
    { 
        _id=38, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2450,y = 120},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[39]= 
    { 
        _id=39, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2560,y = 180},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = ture,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[40]= 
    { 
        _id=40, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2600,y = 315},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        speed = 32,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = false,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }