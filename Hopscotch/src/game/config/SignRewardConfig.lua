--[[
签到奖励配置
]]

SignReward={}

SIGNREWARD_TYPE = 
{
    Gold = 1,
    Diamond = 2,
    Prop = 3,
}

SignReward[1]=
    {    
	    {
	       id = 1,
            res = "ui/ShopGold_2.png",
	       type = SIGNREWARD_TYPE.Gold,
	       reward = 500,
            pos = cc.p(70,185),
	    },
	    {
           id = 2,
            res = "ui/ShopDiamond_1.png",
           type = SIGNREWARD_TYPE.Diamond,
           reward = 20,
            pos = cc.p(212,185),
        },
        {
           id = 3,
            res = "ui/ShopGold_2.png",
           type = SIGNREWARD_TYPE.Gold,
           reward = 1000,
            pos = cc.p(354,185),
        },
        {
            id = 4,
            res = "ui/ShopDiamond_1.png",
            type = SIGNREWARD_TYPE.Diamond,
            reward = 30,
            pos = cc.p(494,185),
        },
        {
            id = 5,
            res = "ui/ShopGold_2.png",
            type = SIGNREWARD_TYPE.Diamond,
            reward = 2000,
            pos = cc.p(140,30),
        },
        {
            id = 6,
            res = "ui/ShopDiamond_1.png",
            type = SIGNREWARD_TYPE.Diamond,
            reward = 40,
            pos = cc.p(282,30),
        },
        {
            id = 7,
            res = "ui/ShopDiamond_1.png",
            type = SIGNREWARD_TYPE.Diamond,
            reward = 50,
            pos = cc.p(424,30),
        },
    }

--SignReward[2]=
--    {
--        _prop1 = "ui/uiImg/golds_bigimg.png",
--        _count1 = 2500,
--        _type1 = 1,
--        
--	
--        _prop2 = "ui/uiImg/golds_bigimg.png",  --签到所得的道具
--        _count2 = 3000,                        --签到所得的数量
--        _type2 = 1,                            --签到所得的道具类型 1.金币 2.钻石 
--        
--
--        _prop3 = "ui/uiImg/golds_littleimg.png",
--        _count3 = 3500,
--        _type3 = 1,
--        
--        _prop4 = "ui/uiImg/golds_littleimg.png",
--        _count4 = 4000,
--        _type4 = 1,
--  
--        _prop5 = "ui/uiImg/golds_bigimg2.png",
--        _count5 = 5000,
--        _type5 = 1,
--        
--        _prop6 = "ui/uiImg/golds_bigimg2.png",
--        _count6 = 6000,
--        _type6 = 1,
--        
--        _prop7 = "ui/uiImg/golds_bigimg1.png",
--        _count7 = 8000,
--        _type7 = 1,
--    }
--SignReward[3]=
--    {
--         _prop1 = "ui/uiImg/diamond_little.png",
--        _count1 = 10,
--        _type1 = 2,
--        
--	
--        _prop2 = "ui/uiImg/golds_bigimg.png",  --签到所得的道具
--        _count2 = 2000,                        --签到所得的数量
--        _type2 = 1,                            --签到所得的道具类型 1.金币 2.钻石 
--        
--
--        _prop3 = "ui/uiImg/golds_littleimg.png",
--        _count3 = 3000,
--        _type3 = 1,
--        
--        _prop4 = "ui/uiImg/diamond_bigs.png",
--        _count4 = 15,
--        _type4 = 2,
--  
--        _prop5 = "ui/uiImg/golds_bigimg2.png",
--        _count5 = 4000,
--        _type5 = 1,
--        
--        _prop6 = "ui/uiImg/diamond_big1.png",
--        _count6 = 25,
--        _type6 = 2,
--        
--        _prop7 = "ui/uiImg/diamond_big2.png",
--        _count7 = 35,
--        _type7 = 2,
--    }
--SignReward[4]=
--    {
--        _prop1 = "ui/uiImg/golds_bigimg.png",
--        _count1 = 2500,
--        _type1 = 1,
--        
--	
--        _prop2 = "ui/uiImg/golds_bigimg.png",  --签到所得的道具
--        _count2 = 3000,                        --签到所得的数量
--        _type2 = 1,                            --签到所得的道具类型 1.金币 2.钻石 
--        
--
--        _prop3 = "ui/uiImg/golds_littleimg.png",
--        _count3 = 3500,
--        _type3 = 1,
--        
--        _prop4 = "ui/uiImg/golds_littleimg.png",
--        _count4 = 4000,
--        _type4 = 1,
--  
--        _prop5 = "ui/uiImg/golds_bigimg2.png",
--        _count5 = 5000,
--        _type5 = 1,
--        
--        _prop6 = "ui/uiImg/golds_bigimg2.png",
--        _count6 = 6000,
--        _type6 = 1,
--        
--        _prop7 = "ui/uiImg/golds_bigimg1.png",
--        _count7 = 8000,
--        _type7 = 1,
--    }