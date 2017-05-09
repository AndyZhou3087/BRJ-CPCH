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
    map = {20,24,59,52,20,21,59,21,20,17,23,0},    --地图组，此id对应MapGroupConfig中配置文件，0表示无地图组
    guideMap = {5200,5300,5400,7200,5700,5700,0}, --新手引导特殊关卡配置，只在第一次进入游戏启动
    guideGap = 20,    --新手进入游戏的关卡距离
    guideSpeed = 60,  --新手关卡速度
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
        map = {9,2,3,8,13,59,4,15,15,60,64,2,8,37,0},
        gap = 10,    --每组之间的间隔差距，单位:像素
        speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
        map = {22,24,23,25,12,13,10,17,24,8,5,4,8,5,2,5,60,8,60,0},
        gap = 10,    --每组之间的间隔差距，单位:像素
        speed = 80,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
        map = {23,25,24,6,7,9,10,12,20,21,0},
        gap = 10,    --每组之间的间隔差距，单位:像素
        speed = 75,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = true,  --关卡是否遮罩
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
        startGoods={1,2,3,4,5}, --开局道具
        map = {12,22,20,19,22,4,14,20,20,21,4,12,17,19,2,21,20,21,26,11,11,0},
        gap = 10,    --每组之间的间隔差距，单位:像素
        speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
        map = {22,64,23,24,23,25,4,15,16,15,14,22,25,0},
        gap = 60,    --每组之间的间隔差距，单位:像素
        speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
        map = {28,27,16,19,16,18,29,65,27,30,5,68,17,18,0},
        gap = 60,    --每组之间的间隔差距，单位:像素
        speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
        map = {20,12,4,19,16,18,6,14,12,14,12,21,0},
        gap = 60,    --每组之间的间隔差距，单位:像素
        speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
        map = {14,18,17,13,6,14,12,29,23,29,23,21,14,14,17,26,16,16,0},
        gap = 65,    --每组之间的间隔差距，单位:像素
        speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
        map = {23,24,3,30,30,27,16,15,3,15,15,27,30,30,28,30,30,30,0},
        gap = 50,    --每组之间的间隔差距，单位:像素
        speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
        map = {22,24,23,25,8,17,1,10,1,17,24,1,17,25,22,0},
        gap = 50,    --每组之间的间隔差距，单位:像素
        speed = 85,  --每一关卡速度
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
        pos = {x = 670,y = 400},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={1,2,3,4,5}, --开局道具
        map = {17,28,27,19,17,17,16,10,16,17,10,14,17,24,23,25,26,28,1,2,0},
        gap = 50,    --每组之间的间隔差距，单位:像素
        speed = 75,  --每一关卡速度
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
        pos = {x = 800,y = 400},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={1,2,3,4,5}, --开局道具
        map = {21,25,4,18,24,23,25,18,17,6,10,6,18,21,17,18,20,10,29,17,1,2,3,4,15,0},
        gap = 15,    --每组之间的间隔差距，单位:像素
        speed = 75,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
	isClip = true,  --关卡是否遮罩
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {31,32,33,34,35,20,31,1,33,6,31,32,32,29,33,36,30,30,0},
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {1,33,6,31,32,32,29,33,36,30,31,32,33,34,35,20,31,1,33,6,31,32,32,29,33,36,30,0},    
    gap = 60,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
    isClip = true,  --关卡是否遮罩
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {33,32,33,34,35,28,20,33,1,17,33,6,33,17,32,18,28,12,32,29,33,36,30,30,0},   
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {28,27,16,18,16,14,18,32,33,34,35,28,20,33,1,17,33,6,33,17,32,17,21,17,17,16,10,16,17,0},    
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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

SelectLevel[18]= 
    { 
        _id=18, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 1140,y = 120},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={1,2,3,4,5}, --开局道具
    map = {64,3,12,13,6,13,6,14,12,32,33,29,36,15,16,30,22,24,14,2,3,9,10,11,0}, 
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {28,19,27,13,6,18,30,17,17,28,19,36,24,28,30,30,1,1,17,18,16,30,11,0},    
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {36,19,30,12,32,33,29,36,15,16,30,26,24,12,32,33,29,36,15,16,36,5,5,0},    
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {22,24,23,25,8,17,1,10,1,17,1,17,25,22,24,2,3,2,3,17,0},    
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {24,23,25,8,17,1,10,13,32,33,34,35,28,20,33,1,17,33,6,33,17,32,18,28,32,29,33,36,30,30,0},   
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {20,14,12,4,14,20,20,21,4,12,17,19,2,21,20,21,32,33,34,35,20,31,1,33,6,31,32,32,29,33,34,35,28,20,33,1,17,0}, 
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {2,29,17,2,3,29,34,38,38,17,10,2,21,4,21,14,33,34,35,20,31,17,18,6,31,32,29,35,14,38,14,17,37,0},    
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {17,38,38,34,33,32,33,34,35,28,20,33,1,17,33,6,23,24,25,18,28,32,29,33,36,30,30,2,2,0},    
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
    isClip = true,  --关卡是否遮罩
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {16,2,4,2,2,3,16,16,34,38,18,5,5,28,19,27,13,17,17,28,19,34,38,38,17,10,2,21,4,21,14,33,0}, 
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        pos = {x = 1935,y = 400},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={1,2,3,4,5}, --开局道具
    map = {14,40,18,41,17,39,30,13,6,38,27,26,14,12,29,23,38,39,29,23,21,14,40,26,41,16,0}, 
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {29,23,38,39,29,39,23,38,21,14,40,26,41,16,14,40,18,41,38,17,39,30,13,6,38,27,26,14,12,0},
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
    isClip = true,  --关卡是否遮罩
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {37,2,27,30,30,16,27,19,22,38,17,20,31,17,18,6,31,10,2,21,4,21,14,33,34,35,20,31,17,18,6,31,32,29,0},   
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {43,44,33,32,33,34,35,28,44,33,1,17,33,6,33,17,32,18,28,42,29,33,36,30,29,36,0},   
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {43,44,33,32,33,34,35,28,44,33,1,23,25,3,2,9,1,21,22,29,17,33,6,33,17,10,14,17,24,23,25,26,28,1,2,0},    
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {38,33,34,35,20,31,1,36,6,31,32,32,29,33,36,35,28,20,33,1,17,28,24,25,18,28,36,29,33,3,0},  
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        pos = {x = 2250,y = 400},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={1,2,3,4,5}, --开局道具
    map = {40,2,27,30,30,16,27,19,22,38,16,20,31,17,18,16,31,10,2,21,4,21,40,16,34,35,16,31,40,17,16,31,32,29,0}, 
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
    isClip = true,  --关卡是否遮罩
	giftGap = 3000,   --奔跑多少距离弹角色礼包，单位:像素

    }

SelectLevel[34]= 
    { 
        _id=34, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 2380,y = 400},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={1,2,3,4,5}, --开局道具
    map = {41,36,34,35,32,18,28,32,29,33,36,32,31,32,31,33,1,17,33,6,33,17,32,18,28,42,29,33,45,32,31,42,44,43,45,0},    
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        pos = {x = 2450,y = 330},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={1,2,3,4,5}, --开局道具
    map = {29,32,31,6,18,17,31,20,35,34,33,14,21,4,21,2,10,16,36,29,30,36,33,29,42,28,18,32,17,33,0},   
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {37,61,2,27,30,30,16,27,19,22,38,17,20,31,17,18,1,17,33,6,33,17,32,18,28,42,29,33,36,30,29,36,0},   
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
    isClip = true,  --关卡是否遮罩
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {40,2,27,30,30,16,27,19,22,38,16,20,31,17,18,16,31,10,2,21,4,21,40,16,34,35,16,31,40,17,16,31,32,29,0},   
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {40,2,27,30,30,16,27,19,22,38,16,20,31,17,18,16,31,10,2,21,4,21,40,16,34,35,16,31,40,17,16,31,32,29,0},  
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {40,2,27,30,30,16,27,19,22,38,16,20,31,17,18,16,31,10,2,21,4,21,40,16,34,35,16,31,40,17,16,31,32,29,0},   
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
        getStar = function(score)     --星级分数配置
            if score >= 300 then
                return 3
        elseif score >= 200 then
            return 2
        else
            return 1
        end
        end,
    isClip = true,  --关卡是否遮罩
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
        startGoods={1,2,3,4,5}, --开局道具
    map = {40,2,27,30,30,16,27,19,22,38,16,20,31,17,18,16,31,10,2,21,4,21,40,16,34,35,16,31,40,17,16,31,32,29,0},  
    gap = 10,    --每组之间的间隔差距，单位:像素
    speed = 75,  --每一关卡速度
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
