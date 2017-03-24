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
--   
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
    pos = {x = 100,y = 100},
    costPower=1,
    coinAward=false, --金币奖励
    powerAward=false, --体力奖励
    startGoods={1,2,3,4,5}, --开局道具
    obstacle={14,13,13,0},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
    coins = {1,1,1,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
    goods={0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
    gap = 500,    --每组之间的间隔差距，单位:像素
    endPoint = 5000,  --终点距离，单位：像素
}

SelectLevel[2]= 
    { 
        _id=2, 
        res = "Select/Select_2.png",
        rect = {191,220},
        pos = {x = 200,y = 200},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }
    
SelectLevel[3]= 
    { 
        _id=3, 
        res = "Select/Select_3.png",
        rect = {134,94},
        pos = {x = 300,y = 300},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }
    
SelectLevel[4]= 
    { 
        _id=4, 
        res = "Select/Select_4.png",
        rect = {137,112},
        pos = {x = 400,y = 100},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }
    
SelectLevel[5]= 
    { 
        _id=5, 
        res = "Select/Select_4.png",
        rect = {137,112},
        pos = {x = 500,y = 100},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }
    
SelectLevel[6]= 
    { 
        _id=6, 
        res = "Select/Select_5.png",
        rect = {84,80},
        pos = {x = 600,y = 100},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }
    
SelectLevel[7]= 
    { 
        _id=7, 
        res = "Select/Select_7.png",
        rect = {59,60},
        pos = {x = 700,y = 100},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }
    
SelectLevel[8]= 
    { 
        _id=8, 
        res = "Select/Select_8.png",
        rect = {55,64},
        pos = {x = 750,y = 200},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},     --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }
    
SelectLevel[9]= 
    { 
        _id=9, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 800,y = 250},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }

SelectLevel[10]= 
    { 
        _id=10, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 810,y = 300},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }

SelectLevel[11]= 
    { 
        _id=11, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 820,y = 350},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }

SelectLevel[12]= 
    { 
        _id=12, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 830,y = 400},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }

SelectLevel[13]= 
    { 
        _id=13, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 840,y = 500},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }

SelectLevel[14]= 
    { 
        _id=14, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 900,y = 510},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }

SelectLevel[15]= 
    { 
        _id=15, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 910,y = 520},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }

SelectLevel[16]= 
    { 
        _id=16, 
        res = "Select/Select_1.png",
        rect = {102,81},
        pos = {x = 100,y = 130},
        costPower=1,
        coinAward=false, --金币奖励
        powerAward=false, --体力奖励
        startGoods={0,0,0,0,0,0}, --开局道具
        obstacle={13,13,13,13,13,13,13,13,13},   --障碍物，此id对应ObsGroupConfig中配置文件，填0表示无障碍
        coins = {0,0,0,0,0,0,0,0,0},    --金币, 此id对应CoinsConfig配置文件，填0表示无
        goods={0,0,0,0,0,0,0,0,0},      --道具  此id对应GoodGroupConfig配置文件,填0表示无道具
        gap = 500,    --每组之间的间隔差距，单位:像素
        endPoint = 5000,  --终点距离，单位：像素
    }
