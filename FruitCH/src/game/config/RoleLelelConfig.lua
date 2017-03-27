--[[
角色等级配置
]]
RoleLvs = {}

RoleLvs[1]={}
RoleLvs[2]={}
RoleLvs[3]={}
RoleLvs[4]={}
RoleLvs[5]={}

UPGRADE_TYPE = 
{
    Gold = 1,
    Dimond = 2,
}

--[[
id=1的角色成长对应等级属性配置
]]
RoleLvs[1][1]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.5,   --冲刺时间,单位：秒
        magnetTime = 0.5,   --磁铁时间,单位：秒
        giantTime = 0.5,   --巨人时间,单位：秒
        transTime=0.5,     --转换时间 (s)
        cloudTime=0.5,     --浮云时间(s)
    }
RoleLvs[1][2]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }
RoleLvs[1][3]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2,   --冲刺时间,单位：秒
        magnetTime = 2,   --磁铁时间,单位：秒
        giantTime = 2,   --巨人时间,单位：秒
        transTime=2,     --转换时间 (s)
        cloudTime=2,     --浮云时间(s)
    }
RoleLvs[1][4]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3,   --冲刺时间,单位：秒
        magnetTime = 3,   --磁铁时间,单位：秒
        giantTime = 3,   --巨人时间,单位：秒
        transTime=3,     --转换时间 (s)
        cloudTime=3,     --浮云时间(s)
    }
RoleLvs[1][5]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4,   --冲刺时间,单位：秒
        magnetTime = 4,   --磁铁时间,单位：秒
        giantTime = 4,   --巨人时间,单位：秒
        transTime=4,     --转换时间 (s)
        cloudTime=4,     --浮云时间(s)
    }
RoleLvs[1][6]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5,   --冲刺时间,单位：秒
        magnetTime = 5,   --磁铁时间,单位：秒
        giantTime = 5,   --巨人时间,单位：秒
        transTime=5,     --转换时间 (s)
        cloudTime=5,     --浮云时间(s)
    }
--RoleLvs[1][7]=
--    {
--        --分数加成百分比
--        scoreRate = 7,
--        --金币分数加成百分比
--        coinRate = 11,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 3,	 
--	     goodsId=18,   	 
--	     goodsNum = 1  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[1][8]=
--    {
--        --分数加成百分比
--        scoreRate = 8,
--        --金币分数加成百分比
--        coinRate = 12,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goldNum = 1600  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[1][9]=
--    {
--        --分数加成百分比
--        scoreRate = 9,
--        --金币分数加成百分比
--        coinRate = 13,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goldNum = 1800  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[1][10]=
--    {
--        --分数加成百分比
--        scoreRate = 10,
--        --金币分数加成百分比
--        coinRate = 14,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goldNum = 2000  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[1][11]=
--    {
--        --分数加成百分比
--        scoreRate = 11,
--        --金币分数加成百分比
--        coinRate = 15,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goldNum= 2200  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[1][12]=
--    {
--        --分数加成百分比
--        scoreRate =12,
--        --金币分数加成百分比
--        coinRate = 16,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goldNum = 2400  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[1][13]=
--    {
--        --分数加成百分比
--        scoreRate = 13,
--        --金币分数加成百分比
--        coinRate = 17,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goldNum = 2600  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[1][14]=
--    {
--        --分数加成百分比
--        scoreRate = 14,
--        --金币分数加成百分比
--        coinRate = 18,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goldNum = 2800  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[1][15]=
--    {
--        --分数加成百分比
--        scoreRate = 15,
--        --金币分数加成百分比
--        coinRate = 19,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--	     needsType = 3,
--	     goodsId=18,
--	     goodsNum = 5  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 8,  -- 金币和钻石换算
--    }
--RoleLvs[1][16]=
--    {
--        --分数加成百分比
--        scoreRate = 16,
--        --金币分数加成百分比
--        coinRate = 20,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--	     goldNum = 3100  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[1][17]=
--    {
--        --分数加成百分比
--        scoreRate = 17,
--        --金币分数加成百分比
--        coinRate = 21,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--	     goldNum = 3400  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[1][18]=
--    {
--        --分数加成百分比
--        scoreRate = 18,
--        --金币分数加成百分比
--        coinRate = 22,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--	     goldNum = 3700  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[1][19]=
--    {
--        --分数加成百分比
--        scoreRate = 19,
--        --金币分数加成百分比
--        coinRate = 23,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--	     goldNum = 4000  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[1][20]=
--    {
--        --分数加成百分比
--        scoreRate = 20,
--        --金币分数加成百分比
--        coinRate = 24,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--	     goldNum = 4300  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[1][21]=
--    {
--        --分数加成百分比
--        scoreRate = 21,
--        --金币分数加成百分比
--        coinRate = 25,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--	     goldNum = 4600  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[1][22]=
--    {
--        --分数加成百分比
--        scoreRate = 22,
--        --金币分数加成百分比
--        coinRate = 26,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType = 3,
--         goodsId=18,
--	     goodsNum = 8 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 12  -- 金币和钻石换算
--    }	
--RoleLvs[1][23]=
--    {
--        --分数加成百分比
--        scoreRate = 23,
--        --金币分数加成百分比
--        coinRate = 27,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--         goldNum = 5000 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4  -- 金币和钻石换算
--    }
--RoleLvs[1][24]=
--    {
--        --分数加成百分比
--        scoreRate = 24,
--        --金币分数加成百分比
--        coinRate = 28,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--         goldNum = 5400 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 5  -- 金币和钻石换算
--    }
--RoleLvs[1][25]=
--    {
--        --分数加成百分比
--        scoreRate = 25,
--        --金币分数加成百分比
--        coinRate = 29,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--         goldNum = 5800 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 5  -- 金币和钻石换算
--    }
--RoleLvs[1][26]=
--    {
--        --分数加成百分比
--        scoreRate = 26,
--        --金币分数加成百分比
--        coinRate = 30,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--         goldNum = 6200 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 5  -- 金币和钻石换算
--    }
--RoleLvs[1][27]=
--    {
--        --分数加成百分比
--        scoreRate = 27,
--        --金币分数加成百分比
--        coinRate = 31,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--         goldNum = 6600 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 6  -- 金币和钻石换算
--    }
--RoleLvs[1][28]=
--    {
--        --分数加成百分比
--        scoreRate = 28,
--        --金币分数加成百分比
--        coinRate = 32,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--         goldNum = 7000 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 6  -- 金币和钻石换算
--    }
--RoleLvs[1][29]=
--    {
--        --分数加成百分比
--        scoreRate = 29,
--        --金币分数加成百分比
--        coinRate = 33,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--        {
--	 needsType = 3,
--         goodsId=18,
--         goodsNum = 10 
--         },
--{
--	 needsType = 3,
--         goodsId=19,
--         goodsNum = 1  	 
--	},	
--        
--	        --金币不足时
--        needDiamondNum =16  -- 金币和钻石换算
--    }
--RoleLvs[1][30]=
--    {
--        --分数加成百分比
--        scoreRate = 30,
--        --金币分数加成百分比
--        coinRate = 34,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType = 2,
--         goldNum = 0 	 
--	},	 
--	        --金币不足时
--        needDiamondNum =0  -- 金币和钻石换算
--    }		
--======================================================================

--[[
id=2的角色成长对应等级属性配置
]]
RoleLvs[2][1]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[2][2]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[2][3]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[2][4]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[2][5]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
--RoleLvs[2][6]=
--    {
--        --分数加成百分比
--        scoreRate = 6,
--        --金币分数加成百分比
--        coinRate = 10,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 3,
--        --升级需求说明
--        {
--            needsType = 2,  -- 1钻石 2金币 3道具
--            goldNum = 1400,   --所需数量
--        },
--        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[2][7]=
--    {
--        --分数加成百分比
--        scoreRate = 7,
--        --金币分数加成百分比
--        coinRate = 11,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 3,	 
--	     goodsId=18,   	 
--	     goodsNum = 1  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[2][8]=
--    {
--        --分数加成百分比
--        scoreRate = 8,
--        --金币分数加成百分比
--        coinRate = 12,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goodsNum = 1600  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[2][9]=
--    {
--        --分数加成百分比
--        scoreRate = 9,
--        --金币分数加成百分比
--        coinRate = 13,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goodsNum = 1800  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[2][10]=
--    {
--        --分数加成百分比
--        scoreRate = 31,
--        --金币分数加成百分比
--        coinRate = 35,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 3,
--         goodsId=18,
--         goodsNum = 8   	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 12,  -- 金币和钻石换算
--    }
--RoleLvs[2][11]=
--    {
--        --分数加成百分比
--        scoreRate = 32,
--        --金币分数加成百分比
--        coinRate = 36,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goldNum = 2500 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[2][12]=
--    {
--        --分数加成百分比
--        scoreRate = 33,
--        --金币分数加成百分比
--        coinRate = 37,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goldNum = 2600 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[2][13]=
--    {
--        --分数加成百分比
--        scoreRate = 34,
--        --金币分数加成百分比
--        coinRate = 38,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goldNum = 2700 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[2][14]=
--    {
--        --分数加成百分比
--        scoreRate = 35,
--        --金币分数加成百分比
--        coinRate = 39,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goldNum = 2800 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }	
--RoleLvs[2][15]=
--    {
--        --分数加成百分比
--        scoreRate = 36,
--        --金币分数加成百分比
--        coinRate = 40,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goldNum = 2900 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[2][16]=
--    {
--        --分数加成百分比
--        scoreRate = 37,
--        --金币分数加成百分比
--        coinRate = 41,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goldNum = 3000 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[2][17]=
--    {
--        --分数加成百分比
--        scoreRate = 38,
--        --金币分数加成百分比
--        coinRate = 42,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goldNum = 3100 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[2][18]=
--    {
--        --分数加成百分比
--        scoreRate = 39,
--        --金币分数加成百分比
--        coinRate = 43,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goldNum = 3200 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[2][19]=
--    {
--        --分数加成百分比
--        scoreRate = 40,
--        --金币分数加成百分比
--        coinRate = 44,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goldNum = 3300 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[2][20]=
--    {
--        --分数加成百分比
--        scoreRate = 41,
--        --金币分数加成百分比
--        coinRate = 45,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--            needsType = 3,
--            goodsId=18,
--            goodsNum = 10  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 16,  -- 金币和钻石换算
--    }
--RoleLvs[2][21]=
--    {
--        --分数加成百分比
--        scoreRate = 42,
--        --金币分数加成百分比
--        coinRate = 46,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 3600  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[2][22]=
--    {
--        --分数加成百分比
--        scoreRate = 43,
--        --金币分数加成百分比
--        coinRate = 47,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 3800  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[2][23]=
--    {
--        --分数加成百分比
--        scoreRate = 44,
--        --金币分数加成百分比
--        coinRate = 48,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 4000  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[2][24]=
--    {
--        --分数加成百分比
--        scoreRate = 45,
--        --金币分数加成百分比
--        coinRate = 49,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 4200  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[2][25]=
--    {
--        --分数加成百分比
--        scoreRate = 46,
--        --金币分数加成百分比
--        coinRate = 50,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 4400  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[2][26]=
--    {
--        --分数加成百分比
--        scoreRate = 47,
--        --金币分数加成百分比
--        coinRate = 51,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 4600  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[2][27]=
--    {
--        --分数加成百分比
--        scoreRate = 48,
--        --金币分数加成百分比
--        coinRate = 52,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 4800  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[2][28]=
--    {
--        --分数加成百分比
--        scoreRate = 49,
--        --金币分数加成百分比
--        coinRate = 53,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 5000  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[2][29]=
--    {
--        --分数加成百分比
--        scoreRate = 50,
--        --金币分数加成百分比
--        coinRate = 54,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 8,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 5200  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[2][30]=
--    {
--        --分数加成百分比
--        scoreRate = 51,
--        --金币分数加成百分比
--        coinRate = 55,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--            needsType = 3,
--            goodsId=18,
--            goodsNum = 10    
--    },
--         {
--            needsType = 3,
--			goodsId = 19,
--			goodsNum = 3  
--            },	
--	        --金币不足时
--        needDiamondNum = 24,  -- 金币和钻石换算
--    }
--RoleLvs[2][31]=
--    {
--        --分数加成百分比
--        scoreRate = 52,
--        --金币分数加成百分比
--        coinRate = 56,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 5600  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 5,  -- 金币和钻石换算
--    }
--RoleLvs[2][32]=
--    {
--        --分数加成百分比
--        scoreRate = 53,
--        --金币分数加成百分比
--        coinRate = 57,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 5900  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 5,  -- 金币和钻石换算
--    }
--RoleLvs[2][33]=
--    {
--        --分数加成百分比
--        scoreRate = 54,
--        --金币分数加成百分比
--        coinRate = 58,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 6200  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 5,  -- 金币和钻石换算
--    }
--RoleLvs[2][34]=
--    {
--        --分数加成百分比
--        scoreRate = 55,
--        --金币分数加成百分比
--        coinRate = 59,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 6500  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 5,  -- 金币和钻石换算
--    }
--RoleLvs[2][35]=
--    {
--        --分数加成百分比
--        scoreRate = 56,
--        --金币分数加成百分比
--        coinRate = 60,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 6800  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 6,  -- 金币和钻石换算
--    }
--RoleLvs[2][36]=
--    {
--        --分数加成百分比
--        scoreRate = 57,
--        --金币分数加成百分比
--        coinRate = 61,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 7100  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 6,  -- 金币和钻石换算
--    }
--RoleLvs[2][37]=
--    {
--        --分数加成百分比
--        scoreRate = 58,
--        --金币分数加成百分比
--        coinRate = 62,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 7400  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 6,  -- 金币和钻石换算
--    }
--RoleLvs[2][38]=
--    {
--        --分数加成百分比
--        scoreRate = 59,
--        --金币分数加成百分比
--        coinRate = 63,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--            needsType = 2,
--            goldNum = 7700  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 6,  -- 金币和钻石换算
--    }
--RoleLvs[2][39]=
--    {
--        --分数加成百分比
--        scoreRate = 60,
--        --金币分数加成百分比
--        coinRate = 64,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--        {
--            needsType = 3,
--			goodsId = 18,
--            goodsNum = 15 	 
--	},
--         {
--            needsType = 3,
--			goodsId = 19,
--            goodsNum = 5  	 
--	},	
--         {
--            needsType = 3,
--			goodsId = 20,
--            goodsNum = 1  	 
--	},
--        
--	        --金币不足时
--        needDiamondNum = 31,  -- 金币和钻石换算
--    }
--RoleLvs[2][40]=
--    {
--        --分数加成百分比
--        scoreRate = 61,
--        --金币分数加成百分比
--        coinRate = 65,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--        {
--            needsType = 2,
--            goldNum = 0  	 
--	},	 
--        		
--	        --金币不足时
--        needDiamondNum = 0,  -- 金币和钻石换算
--    }
--======================================================================

--[[
id=3的角色成长对应等级属性配置
]]
RoleLvs[3][1]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[3][2]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[3][3]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[3][4]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[3][5]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[3][6]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[3][7]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
--RoleLvs[3][8]=
--    {
--        --分数加成百分比
--        scoreRate = 8,
--        --金币分数加成百分比
--        coinRate = 12,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goodsNum = 1600  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[3][9]=
--    {
--        --分数加成百分比
--        scoreRate = 9,
--        --金币分数加成百分比
--        coinRate = 13,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goodsNum = 1800  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[3][10]=
--    {
--        --分数加成百分比
--        scoreRate = 31,
--        --金币分数加成百分比
--        coinRate = 35,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 3,
--         goodsId=18,
--         goodsNum = 8   	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 12,  -- 金币和钻石换算
--    }
--RoleLvs[3][11]=
--    {
--        --分数加成百分比
--        scoreRate = 32,
--        --金币分数加成百分比
--        coinRate = 36,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goodsNum = 2500 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[3][12]=
--    {
--        --分数加成百分比
--        scoreRate = 62,
--        --金币分数加成百分比
--        coinRate = 66,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =3,
--		 goodsId=18,
--         goodsNum = 10 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 16,  -- 金币和钻石换算
--    }
--RoleLvs[3][13]=
--    {
--        --分数加成百分比
--        scoreRate = 63,
--        --金币分数加成百分比
--        coinRate = 67,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 3000 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[3][14]=
--    {
--        --分数加成百分比
--        scoreRate = 64,
--        --金币分数加成百分比
--        coinRate = 68,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 3200 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[3][15]=
--    {
--        --分数加成百分比
--        scoreRate = 65,
--        --金币分数加成百分比
--        coinRate = 69,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 3400 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[3][16]=
--    {
--        --分数加成百分比
--        scoreRate = 66,
--        --金币分数加成百分比
--        coinRate = 70,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 3600 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[3][17]=
--    {
--        --分数加成百分比
--        scoreRate = 67,
--        --金币分数加成百分比
--        coinRate = 71,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 3800 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[3][18]=
--    {
--        --分数加成百分比
--        scoreRate = 68,
--        --金币分数加成百分比
--        coinRate = 72,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 4000 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[3][19]=
--    {
--        --分数加成百分比
--        scoreRate = 69,
--        --金币分数加成百分比
--        coinRate = 73,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 4200 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[3][20]=
--    {
--        --分数加成百分比
--        scoreRate = 70,
--        --金币分数加成百分比
--        coinRate = 74,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 4400 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[3][21]=
--    {
--        --分数加成百分比
--        scoreRate = 71,
--        --金币分数加成百分比
--        coinRate = 75,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 4600 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[3][22]=
--    {
--        --分数加成百分比
--        scoreRate = 72,
--        --金币分数加成百分比
--        coinRate = 76,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 4800 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[3][23]=
--    {
--        --分数加成百分比
--        scoreRate = 73,
--        --金币分数加成百分比
--        coinRate = 77,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 5000	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[3][24]=
--    {
--        --分数加成百分比
--        scoreRate = 74,
--        --金币分数加成百分比
--        coinRate = 78,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goldNum = 5200	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[3][25]=
--    {
--        --分数加成百分比
--        scoreRate = 75,
--        --金币分数加成百分比
--        coinRate = 79,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =3,
--		 goodsId = 18,
--	     goodsNum = 10	 
--	},	
--        {
--	     needsType =3,
--		 goodsId = 19,
--	     goodsNum = 5	 
--	},	 	
--	        --金币不足时
--        needDiamondNum = 31,  -- 金币和钻石换算
--    }
--RoleLvs[3][26]=
--    {
--        --分数加成百分比
--        scoreRate = 76,
--        --金币分数加成百分比
--        coinRate = 80,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 5600	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 5,  -- 金币和钻石换算
--    }
--RoleLvs[3][27]=
--    {
--        --分数加成百分比
--        scoreRate = 77,
--        --金币分数加成百分比
--        coinRate = 81,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 6000	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 5,  -- 金币和钻石换算
--    }
--RoleLvs[3][28]=
--    {
--        --分数加成百分比
--        scoreRate = 78,
--        --金币分数加成百分比
--        coinRate = 82,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 6400	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 5,  -- 金币和钻石换算
--    }
--RoleLvs[3][29]=
--    {
--        --分数加成百分比
--        scoreRate = 79,
--        --金币分数加成百分比
--        coinRate = 83,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 6800	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 6,  -- 金币和钻石换算
--    }
--RoleLvs[3][30]=
--    {
--        --分数加成百分比
--        scoreRate = 80,
--        --金币分数加成百分比
--        coinRate = 84,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 7200	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 6,  -- 金币和钻石换算
--    }
--RoleLvs[3][31]=
--    {
--        --分数加成百分比
--        scoreRate = 81,
--        --金币分数加成百分比
--        coinRate = 85,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 7600	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 6,  -- 金币和钻石换算
--    }
--RoleLvs[3][32]=
--    {
--        --分数加成百分比
--        scoreRate = 82,
--        --金币分数加成百分比
--        coinRate = 86,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 8000	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 7,  -- 金币和钻石换算
--    }
--RoleLvs[3][33]=
--    {
--        --分数加成百分比
--        scoreRate = 83,
--        --金币分数加成百分比
--        coinRate = 87,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 8400	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 7,  -- 金币和钻石换算
--    }
--RoleLvs[3][34]=
--    {
--        --分数加成百分比
--        scoreRate = 84,
--        --金币分数加成百分比
--        coinRate = 88,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 8800	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 7,  -- 金币和钻石换算
--    }
--RoleLvs[3][35]=
--    {
--        --分数加成百分比
--        scoreRate = 85,
--        --金币分数加成百分比
--        coinRate = 89,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =9200	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 8,  -- 金币和钻石换算
--    }
--RoleLvs[3][36]=
--    {
--        --分数加成百分比
--        scoreRate = 86,
--        --金币分数加成百分比
--        coinRate = 90,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =9600	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 8,  -- 金币和钻石换算
--    }
--RoleLvs[3][37]=
--    {
--        --分数加成百分比
--        scoreRate = 87,
--        --金币分数加成百分比
--        coinRate = 91,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--       
--        {
--	     needsType =3,
--		 goodsId =18,
--		 goodsNum =20	 
--	},	
--	    {
--	     needsType =3,
--		 goodsId =19,
--		 goodsNum =10	 
--	},	
--	    {
--	     needsType =3,
--		 goodsId =20,
--		 goodsNum =2	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 47,  -- 金币和钻石换算
--    }
--RoleLvs[3][38]=
--    {
--        --分数加成百分比
--        scoreRate = 88,
--        --金币分数加成百分比
--        coinRate = 92,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =10200	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 8,  -- 金币和钻石换算
--    }
--RoleLvs[3][39]=
--    {
--        --分数加成百分比
--        scoreRate = 89,
--        --金币分数加成百分比
--        coinRate = 93,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =10800	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 9,  -- 金币和钻石换算
--    }
--RoleLvs[3][40]=
--    {
--        --分数加成百分比
--        scoreRate = 90,
--        --金币分数加成百分比
--        coinRate = 94,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =11400	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 9,  -- 金币和钻石换算
--    }
--RoleLvs[3][41]=
--    {
--        --分数加成百分比
--        scoreRate = 91,
--        --金币分数加成百分比
--        coinRate = 95,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =12000	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 10,  -- 金币和钻石换算
--    }
--RoleLvs[3][42]=
--    {
--        --分数加成百分比
--        scoreRate = 92,
--        --金币分数加成百分比
--        coinRate = 96,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =12600	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 10,  -- 金币和钻石换算
--    }
--RoleLvs[3][43]=
--    {
--        --分数加成百分比
--        scoreRate = 93,
--        --金币分数加成百分比
--        coinRate = 97,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =13200	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 11,  -- 金币和钻石换算
--    }
--RoleLvs[3][44]=
--    {
--        --分数加成百分比
--        scoreRate = 94,
--        --金币分数加成百分比
--        coinRate = 98,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =13800	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 11,  -- 金币和钻石换算
--    }
--RoleLvs[3][45]=
--    {
--        --分数加成百分比
--        scoreRate = 95,
--        --金币分数加成百分比
--        coinRate = 99,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =14400	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 12,  -- 金币和钻石换算
--    }
--RoleLvs[3][46]=
--    {
--        --分数加成百分比
--        scoreRate = 96,
--        --金币分数加成百分比
--        coinRate = 100,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =15000	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 12,  -- 金币和钻石换算
--    }
--RoleLvs[3][47]=
--    {
--        --分数加成百分比
--        scoreRate = 97,
--        --金币分数加成百分比
--        coinRate = 101,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =15600	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 12,  -- 金币和钻石换算
--    }
--RoleLvs[3][48]=
--    {
--        --分数加成百分比
--        scoreRate = 98,
--        --金币分数加成百分比
--        coinRate = 102,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum =16200	 
--	},	
--   	        --金币不足时
--        needDiamondNum = 13,  -- 金币和钻石换算
--    }
--RoleLvs[3][49]=
--    {
--        --分数加成百分比
--        scoreRate = 99,
--        --金币分数加成百分比
--        coinRate = 103,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 20,
--        --升级需求说明
--        {
--	     needsType =3,
--		 goodsId =18,
--		 goodsNum =25	 
--	},	
--	    {
--	     needsType =3,
--		 goodsId =19,
--		 goodsNum =15	 
--	},	
--	    {
--	     needsType =3,
--		 goodsId =20,
--		 goodsNum =5	 
--	},	
--        
--   	        --金币不足时
--        needDiamondNum = 62,  -- 金币和钻石换算
--    }
--RoleLvs[3][50]=
--    {
--        --分数加成百分比
--        scoreRate = 100,
--        --金币分数加成百分比
--        coinRate = 104,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 25,
--        --升级需求说明
--        {
--	     needsType =2,
--		 goldNum =0
--	},	
--        
--   	        --金币不足时
--        needDiamondNum = 0,  -- 金币和钻石换算
--    }
--======================================================================

--[[
id=4的角色成长对应等级属性配置
]]
RoleLvs[4][1]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[4][2]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[4][3]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[4][4]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[4][5]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[4][6]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
--RoleLvs[4][7]=
--    {
--        --分数加成百分比
--        scoreRate = 7,
--        --金币分数加成百分比
--        coinRate = 11,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 3,	 
--	     goodsId=18,   	 
--	     goodsNum = 1  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[4][8]=
--    {
--        --分数加成百分比
--        scoreRate = 8,
--        --金币分数加成百分比
--        coinRate = 12,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goodsNum = 1600  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[4][9]=
--    {
--        --分数加成百分比
--        scoreRate = 9,
--        --金币分数加成百分比
--        coinRate = 13,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 2,	 
--	     goodsNum = 1800  	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[4][10]=
--    {
--        --分数加成百分比
--        scoreRate = 31,
--        --金币分数加成百分比
--        coinRate = 35,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType = 3,
--         goodsId=18,
--         goodsNum = 8   	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 12,  -- 金币和钻石换算
--    }
--RoleLvs[4][11]=
--    {
--        --分数加成百分比
--        scoreRate = 32,
--        --金币分数加成百分比
--        coinRate = 36,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 5,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--         goodsNum = 2500 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 2,  -- 金币和钻石换算
--    }
--RoleLvs[4][12]=
--    {
--        --分数加成百分比
--        scoreRate = 62,
--        --金币分数加成百分比
--        coinRate = 66,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =3,
--		 goodsId=18,
--         goodsNum = 10 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 16,  -- 金币和钻石换算
--    }
--RoleLvs[4][13]=
--    {
--        --分数加成百分比
--        scoreRate = 63,
--        --金币分数加成百分比
--        coinRate = 67,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goodsNum = 3000 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[4][14]=
--    {
--        --分数加成百分比
--        scoreRate = 64,
--        --金币分数加成百分比
--        coinRate = 68,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 10,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--	     goodsNum = 3200 	 
--	},	 
--	        --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[4][15]=
--    {
--        --分数加成百分比
--        scoreRate = 101,
--        --金币分数加成百分比
--        coinRate = 105,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =3,
--		 goodsId = 18,
--	     goodsNum = 15	 
--	},	
--        {
--	     needsType =3,
--		 goodsId = 19,
--	     goodsNum = 5	 
--	},	 	
--	        --金币不足时
--        needDiamondNum = 31,  -- 金币和钻石换算
--    }
--RoleLvs[4][16]=
--    {
--        --分数加成百分比
--        scoreRate = 102,
--        --金币分数加成百分比
--        coinRate = 106,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 3800	 
--	},	
--            --金币不足时
--        needDiamondNum = 3,  -- 金币和钻石换算
--    }
--RoleLvs[4][17]=
--    {
--        --分数加成百分比
--        scoreRate = 103,
--        --金币分数加成百分比
--        coinRate = 107,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 4400	 
--	},	
--            --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[4][18]=
--    {
--        --分数加成百分比
--        scoreRate = 104,
--        --金币分数加成百分比
--        coinRate = 108,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 5000	 
--	},	
--            --金币不足时
--        needDiamondNum = 4,  -- 金币和钻石换算
--    }
--RoleLvs[4][19]=
--    {
--        --分数加成百分比
--        scoreRate = 105,
--        --金币分数加成百分比
--        coinRate = 109,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 5600	 
--	},	
--            --金币不足时
--        needDiamondNum = 5,  -- 金币和钻石换算
--    }
--RoleLvs[4][20]=
--    {
--        --分数加成百分比
--        scoreRate = 106,
--        --金币分数加成百分比
--        coinRate = 110,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 6200	 
--	},	
--            --金币不足时
--        needDiamondNum = 5,  -- 金币和钻石换算
--    }
--RoleLvs[4][21]=
--    {
--        --分数加成百分比
--        scoreRate = 107,
--        --金币分数加成百分比
--        coinRate = 111,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 6800	 
--	},	
--            --金币不足时
--        needDiamondNum = 6,  -- 金币和钻石换算
--    }
--RoleLvs[4][22]=
--    {
--        --分数加成百分比
--        scoreRate = 108,
--        --金币分数加成百分比
--        coinRate = 112,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 7400	 
--	},	
--            --金币不足时
--        needDiamondNum = 6,  -- 金币和钻石换算
--    }
--RoleLvs[4][23]=
--    {
--        --分数加成百分比
--        scoreRate = 109,
--        --金币分数加成百分比
--        coinRate = 113,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 8000	 
--	},	
--            --金币不足时
--        needDiamondNum = 7,  -- 金币和钻石换算
--    }
--RoleLvs[4][24]=
--    {
--        --分数加成百分比
--        scoreRate = 110,
--        --金币分数加成百分比
--        coinRate = 114,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 8600	 
--	},	
--            --金币不足时
--        needDiamondNum = 7,  -- 金币和钻石换算
--    }
--RoleLvs[4][25]=
--    {
--        --分数加成百分比
--        scoreRate = 111,
--        --金币分数加成百分比
--        coinRate = 115,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 9200	 
--	},	
--            --金币不足时
--        needDiamondNum = 8,  -- 金币和钻石换算
--    }
--RoleLvs[4][26]=
--    {
--        --分数加成百分比
--        scoreRate = 112,
--        --金币分数加成百分比
--        coinRate = 116,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 9800	 
--	},	
--            --金币不足时
--        needDiamondNum = 8,  -- 金币和钻石换算
--    }
--RoleLvs[4][27]=
--    {
--        --分数加成百分比
--        scoreRate = 113,
--        --金币分数加成百分比
--        coinRate = 117,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 10400	 
--	},	
--            --金币不足时
--        needDiamondNum = 8,  -- 金币和钻石换算
--    }
--RoleLvs[4][28]=
--    {
--        --分数加成百分比
--        scoreRate = 114,
--        --金币分数加成百分比
--        coinRate = 118,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 11000	 
--	},	
--            --金币不足时
--        needDiamondNum = 9,  -- 金币和钻石换算
--    }
--RoleLvs[4][29]=
--    {
--        --分数加成百分比
--        scoreRate = 115,
--        --金币分数加成百分比
--        coinRate = 119,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 6,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 11600	 
--	},	
--            --金币不足时
--        needDiamondNum = 9,  -- 金币和钻石换算
--    }
--RoleLvs[4][30]=
--    {
--        --分数加成百分比
--        scoreRate = 116,
--        --金币分数加成百分比
--        coinRate = 120,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =3,
--		 goodsId =18,
--		 goodsNum = 20	 
--	},	
--	     {
--	     needsType =3,
--		 goodsId =19,
--		 goodsNum = 10	 
--	},	
--            --金币不足时
--        needDiamondNum = 62,  -- 金币和钻石换算
--    }
--RoleLvs[4][31]=
--    {
--        --分数加成百分比
--        scoreRate = 117,
--        --金币分数加成百分比
--        coinRate = 121,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 12000	 
--	},	
--            --金币不足时
--        needDiamondNum = 10,  -- 金币和钻石换算
--    }
--RoleLvs[4][32]=
--    {
--        --分数加成百分比
--        scoreRate = 118,
--        --金币分数加成百分比
--        coinRate = 122,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 12800	 
--	},	
--            --金币不足时
--        needDiamondNum = 10,  -- 金币和钻石换算
--    }
--RoleLvs[4][33]=
--    {
--        --分数加成百分比
--        scoreRate = 119,
--        --金币分数加成百分比
--        coinRate = 123,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 13600	 
--	},	
--            --金币不足时
--        needDiamondNum = 11,  -- 金币和钻石换算
--    }
--RoleLvs[4][34]=
--    {
--        --分数加成百分比
--        scoreRate = 120,
--        --金币分数加成百分比
--        coinRate = 124,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 14400	 
--	},	
--            --金币不足时
--        needDiamondNum = 12,  -- 金币和钻石换算
--    }
--RoleLvs[4][35]=
--    {
--        --分数加成百分比
--        scoreRate = 121,
--        --金币分数加成百分比
--        coinRate = 125,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 15200	 
--	},	
--            --金币不足时
--        needDiamondNum = 12,  -- 金币和钻石换算
--    }
--RoleLvs[4][36]=
--    {
--        --分数加成百分比
--        scoreRate = 122,
--        --金币分数加成百分比
--        coinRate = 126,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 16000	 
--	},	
--            --金币不足时
--        needDiamondNum = 13,  -- 金币和钻石换算
--    }
--RoleLvs[4][37]=
--    {
--        --分数加成百分比
--        scoreRate = 123,
--        --金币分数加成百分比
--        coinRate = 127,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 16800	 
--	},	
--            --金币不足时
--        needDiamondNum = 13,  -- 金币和钻石换算
--    }
--RoleLvs[4][38]=
--    {
--        --分数加成百分比
--        scoreRate = 124,
--        --金币分数加成百分比
--        coinRate = 128,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 17600	 
--	},	
--            --金币不足时
--        needDiamondNum = 14,  -- 金币和钻石换算
--    }
--RoleLvs[4][39]=
--    {
--        --分数加成百分比
--        scoreRate = 125,
--        --金币分数加成百分比
--        coinRate = 129,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 18400	 
--	},	
--            --金币不足时
--        needDiamondNum = 15,  -- 金币和钻石换算
--    }
--RoleLvs[4][40]=
--    {
--        --分数加成百分比
--        scoreRate = 126,
--        --金币分数加成百分比
--        coinRate = 130,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 19200	 
--	},	
--            --金币不足时
--        needDiamondNum = 15,  -- 金币和钻石换算
--    }
--RoleLvs[4][41]=
--    {
--        --分数加成百分比
--        scoreRate = 127,
--        --金币分数加成百分比
--        coinRate = 131,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 20000	 
--	},	
--            --金币不足时
--        needDiamondNum = 16,  -- 金币和钻石换算
--    }
--RoleLvs[4][42]=
--    {
--        --分数加成百分比
--        scoreRate = 128,
--        --金币分数加成百分比
--        coinRate = 132,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 20800	 
--	},	
--            --金币不足时
--        needDiamondNum = 16,  -- 金币和钻石换算
--    }
--RoleLvs[4][43]=
--    {
--        --分数加成百分比
--        scoreRate = 129,
--        --金币分数加成百分比
--        coinRate = 133,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 21600	 
--	},	
--            --金币不足时
--        needDiamondNum = 17,  -- 金币和钻石换算
--    }
--RoleLvs[4][44]=
--    {
--        --分数加成百分比
--        scoreRate = 130,
--        --金币分数加成百分比
--        coinRate = 134,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 9,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 22400	 
--	},	
--            --金币不足时
--        needDiamondNum = 18,  -- 金币和钻石换算
--    }
--RoleLvs[4][45]=
--    {
--        --分数加成百分比
--        scoreRate = 131,
--        --金币分数加成百分比
--        coinRate = 135,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--       {
--	     needsType =3,
--		 goodsId =18,
--		 goodsNum = 30	 
--	},	
--	     {
--	     needsType =3,
--		 goodsId =19,
--		 goodsNum = 20	 
--	},	
--	    {
--	     needsType =3,
--		 goodsId =20,
--		 goodsNum = 5 
--	},	
--            --金币不足时
--        needDiamondNum = 93,  -- 金币和钻石换算
--    }
--RoleLvs[4][46]=
--    {
--        --分数加成百分比
--        scoreRate = 132,
--        --金币分数加成百分比
--        coinRate = 136,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 23000	 
--	},	
--            --金币不足时
--        needDiamondNum = 18,  -- 金币和钻石换算
--    }
--RoleLvs[4][47]=
--    {
--        --分数加成百分比
--        scoreRate = 133,
--        --金币分数加成百分比
--        coinRate = 137,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 24000	 
--	},	
--            --金币不足时
--        needDiamondNum = 19,  -- 金币和钻石换算
--    }
--RoleLvs[4][48]=
--    {
--        --分数加成百分比
--        scoreRate = 134,
--        --金币分数加成百分比
--        coinRate = 138,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 25000	 
--	},	
--            --金币不足时
--        needDiamondNum = 20,  -- 金币和钻石换算
--    }
--RoleLvs[4][49]=
--    {
--        --分数加成百分比
--        scoreRate = 135,
--        --金币分数加成百分比
--        coinRate = 139,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 26000	 
--	},	
--            --金币不足时
--        needDiamondNum = 20,  -- 金币和钻石换算
--    }
--RoleLvs[4][50]=
--    {
--        --分数加成百分比
--        scoreRate = 136,
--        --金币分数加成百分比
--        coinRate = 140,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 27000	 
--	},	
--            --金币不足时
--        needDiamondNum = 21,  -- 金币和钻石换算
--    }
--RoleLvs[4][51]=
--    {
--        --分数加成百分比
--        scoreRate = 137,
--        --金币分数加成百分比
--        coinRate = 141,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 28000	 
--	},	
--            --金币不足时
--        needDiamondNum = 22,  -- 金币和钻石换算
--    }
--RoleLvs[4][52]=
--    {
--        --分数加成百分比
--        scoreRate = 138,
--        --金币分数加成百分比
--        coinRate = 142,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 29000	 
--	},	
--            --金币不足时
--        needDiamondNum = 23,  -- 金币和钻石换算
--    }
--RoleLvs[4][53]=
--    {
--        --分数加成百分比
--        scoreRate = 139,
--        --金币分数加成百分比
--        coinRate = 143,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 30000	 
--	},	
--            --金币不足时
--        needDiamondNum = 24,  -- 金币和钻石换算
--    }
--RoleLvs[4][54]=
--    {
--        --分数加成百分比
--        scoreRate = 140,
--        --金币分数加成百分比
--        coinRate = 144,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 31000	 
--	},	
--            --金币不足时
--        needDiamondNum = 24,  -- 金币和钻石换算
--    }
--RoleLvs[4][55]=
--    {
--        --分数加成百分比
--        scoreRate = 141,
--        --金币分数加成百分比
--        coinRate = 145,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 32000	 
--	},	
--            --金币不足时
--        needDiamondNum = 25,  -- 金币和钻石换算
--    }
--RoleLvs[4][56]=
--    {
--        --分数加成百分比
--        scoreRate = 142,
--        --金币分数加成百分比
--        coinRate = 146,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 33000	 
--	},	
--            --金币不足时
--        needDiamondNum = 26,  -- 金币和钻石换算
--    }
--RoleLvs[4][57]=
--    {
--        --分数加成百分比
--        scoreRate = 143,
--        --金币分数加成百分比
--        coinRate = 147,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 34000	 
--	},	
--            --金币不足时
--        needDiamondNum = 27,  -- 金币和钻石换算
--    }
--RoleLvs[4][58]=
--    {
--        --分数加成百分比
--        scoreRate = 144,
--        --金币分数加成百分比
--        coinRate = 148,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--       
--        {
--	     needsType =2,
--		 goldNum = 35000	 
--	},	
--            --金币不足时
--        needDiamondNum = 27,  -- 金币和钻石换算
--    }
--RoleLvs[4][59]=
--    {
--        --分数加成百分比
--        scoreRate = 145,
--        --金币分数加成百分比
--        coinRate = 149,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 12,
--        --升级需求说明
--        {
--	     needsType =3,
--		 goodsId =18,
--		 goodsNum = 45	 
--	},	
--	     {
--	     needsType =3,
--		 goodsId =19,
--		 goodsNum = 25	 
--	},	
--	    {
--	     needsType =3,
--		 goodsId =20,
--		 goodsNum = 10 
--	},
--       
--            --金币不足时
--        needDiamondNum = 124,  -- 金币和钻石换算
--    }
--RoleLvs[4][60]=
--    {
--        --分数加成百分比
--        scoreRate = 146,
--        --金币分数加成百分比
--        coinRate = 150,
--        --技能持续时间(s)(基础技能时间+等级加成时间)
--        skillTime = 15,
--        --升级需求说明
--        {
--	     needsType =2,
--		 goldNum = 0	 
--	},	
--        
--            --金币不足时
--        needDiamondNum = 0,  -- 金币和钻石换算
--    }
--=========================================================
--[[
id=5的角色成长对应等级属性配置
]]
RoleLvs[5][1]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[5][2]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[5][3]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[5][4]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[5][5]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }
RoleLvs[5][6]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 0.1,   --冲刺时间,单位：秒
        magnetTime = 0.1,   --磁铁时间,单位：秒
        giantTime = 0.1,   --巨人时间,单位：秒
        transTime=0.1,     --转换时间 (s)
        cloudTime=0.1,     --浮云时间(s)
    }