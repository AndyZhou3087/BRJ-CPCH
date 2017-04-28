
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
        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }
RoleLvs[1][2]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.1,   --冲刺时间,单位：秒
        magnetTime = 1.1,   --磁铁时间,单位：秒
        giantTime = 1.1,   --巨人时间,单位：秒
        transTime=1.1,     --转换时间 (s)
        cloudTime=1.1,     --浮云时间(s)
    }
RoleLvs[1][3]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.2,   --冲刺时间,单位：秒
        magnetTime = 1.2,   --磁铁时间,单位：秒
        giantTime = 1.2,   --巨人时间,单位：秒
        transTime=1.2,     --转换时间 (s)
        cloudTime=1.2,     --浮云时间(s)
    }
RoleLvs[1][4]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.3,   --冲刺时间,单位：秒
        magnetTime = 1.3,   --磁铁时间,单位：秒
        giantTime = 1.3,   --巨人时间,单位：秒
        transTime=1.3,     --转换时间 (s)
        cloudTime=1.3,     --浮云时间(s)
    }
RoleLvs[1][5]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.4,   --冲刺时间,单位：秒
        magnetTime = 1.4,   --磁铁时间,单位：秒
        giantTime = 1.4,   --巨人时间,单位：秒
        transTime=1.4,     --转换时间 (s)
        cloudTime=1.4,     --浮云时间(s)
    }
RoleLvs[1][6]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.5,   --冲刺时间,单位：秒
        magnetTime = 1.5,   --磁铁时间,单位：秒
        giantTime = 1.5,   --巨人时间,单位：秒
        transTime=1.5,     --转换时间 (s)
        cloudTime=1.5,     --浮云时间(s)
    }
RoleLvs[1][7]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.6,   --冲刺时间,单位：秒
        magnetTime = 1.6,   --磁铁时间,单位：秒
        giantTime = 1.6,   --巨人时间,单位：秒
        transTime=1.6,     --转换时间 (s)
        cloudTime=1.6,     --浮云时间(s)
    }
RoleLvs[1][8]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.7,   --冲刺时间,单位：秒
        magnetTime = 1.7,   --磁铁时间,单位：秒
        giantTime = 1.7,   --巨人时间,单位：秒
        transTime=1.7,     --转换时间 (s)
        cloudTime=1.7,     --浮云时间(s)
    }
RoleLvs[1][9]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.8,   --冲刺时间,单位：秒
        magnetTime = 1.8,   --磁铁时间,单位：秒
        giantTime = 1.8,   --巨人时间,单位：秒
        transTime=1.8,     --转换时间 (s)
        cloudTime=1.8,     --浮云时间(s)
    }
RoleLvs[1][10]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.9,   --冲刺时间,单位：秒
        magnetTime = 1.9,   --磁铁时间,单位：秒
        giantTime = 1.9,   --巨人时间,单位：秒
        transTime=1.9,     --转换时间 (s)
        cloudTime=1.9,     --浮云时间(s)
    }
RoleLvs[1][11]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1500},
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
RoleLvs[1][12]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.1,   --冲刺时间,单位：秒
        magnetTime = 2.1,   --磁铁时间,单位：秒
        giantTime = 2.1,   --巨人时间,单位：秒
        transTime=2.1,     --转换时间 (s)
        cloudTime=2.1,     --浮云时间(s)
    }
RoleLvs[1][13]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.2,   --冲刺时间,单位：秒
        magnetTime = 2.2,   --磁铁时间,单位：秒
        giantTime = 2.2,   --巨人时间,单位：秒
        transTime=2.2,     --转换时间 (s)
        cloudTime=2.2,     --浮云时间(s)
    }
RoleLvs[1][14]=
  {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.3,   --冲刺时间,单位：秒
        magnetTime = 2.3,   --磁铁时间,单位：秒
        giantTime = 2.3,   --巨人时间,单位：秒
        transTime=2.3,     --转换时间 (s)
        cloudTime=2.3,     --浮云时间(s)
    }
RoleLvs[1][15]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.4,   --冲刺时间,单位：秒
        magnetTime = 2.4,   --磁铁时间,单位：秒
        giantTime = 2.4,   --巨人时间,单位：秒
        transTime=2.4,     --转换时间 (s)
        cloudTime=2.4,     --浮云时间(s)
    }
RoleLvs[1][16]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.5,   --冲刺时间,单位：秒
        magnetTime = 2.5,   --磁铁时间,单位：秒
        giantTime = 2.5,   --巨人时间,单位：秒
        transTime=2.5,     --转换时间 (s)
        cloudTime=2.5,     --浮云时间(s)
    }
RoleLvs[1][17]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.6,   --冲刺时间,单位：秒
        magnetTime = 2.6,   --磁铁时间,单位：秒
        giantTime = 2.6,   --巨人时间,单位：秒
        transTime=2.6,     --转换时间 (s)
        cloudTime=2.6,     --浮云时间(s)
    }
RoleLvs[1][18]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.7,   --冲刺时间,单位：秒
        magnetTime = 2.7,   --磁铁时间,单位：秒
        giantTime = 2.7,   --巨人时间,单位：秒
        transTime=2.7,     --转换时间 (s)
        cloudTime=2.7,     --浮云时间(s)
    }
RoleLvs[1][19]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.8,   --冲刺时间,单位：秒
        magnetTime = 2.8,   --磁铁时间,单位：秒
        giantTime = 2.8,   --巨人时间,单位：秒
        transTime=2.8,     --转换时间 (s)
        cloudTime=2.8,     --浮云时间(s)
    }
RoleLvs[1][20]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.9,   --冲刺时间,单位：秒
        magnetTime = 2.9,   --磁铁时间,单位：秒
        giantTime = 2.9,   --巨人时间,单位：秒
        transTime=2.9,     --转换时间 (s)
        cloudTime=2.9,     --浮云时间(s)
    }
RoleLvs[1][21]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2500},
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
RoleLvs[1][22]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.1,   --冲刺时间,单位：秒
        magnetTime = 3.1,   --磁铁时间,单位：秒
        giantTime = 3.1,   --巨人时间,单位：秒
        transTime=3.1,     --转换时间 (s)
        cloudTime=3.1,     --浮云时间(s)
    }	
RoleLvs[1][23]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.2,   --冲刺时间,单位：秒
        magnetTime = 3.2,   --磁铁时间,单位：秒
        giantTime = 3.2,   --巨人时间,单位：秒
        transTime=3.2,     --转换时间 (s)
        cloudTime=3.2,     --浮云时间(s)
    }
RoleLvs[1][24]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.3,   --冲刺时间,单位：秒
        magnetTime = 3.3,   --磁铁时间,单位：秒
        giantTime = 3.3,   --巨人时间,单位：秒
        transTime=3.3,     --转换时间 (s)
        cloudTime=3.3,     --浮云时间(s)
    }
RoleLvs[1][25]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.4,   --冲刺时间,单位：秒
        magnetTime = 3.4,   --磁铁时间,单位：秒
        giantTime = 3.4,   --巨人时间,单位：秒
        transTime=3.4,     --转换时间 (s)
        cloudTime=3.4,     --浮云时间(s)
    }	 
RoleLvs[1][26]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.5,   --冲刺时间,单位：秒
        magnetTime = 3.5,   --磁铁时间,单位：秒
        giantTime = 3.5,   --巨人时间,单位：秒
        transTime=3.5,     --转换时间 (s)
        cloudTime=3.5,     --浮云时间(s)
    }
RoleLvs[1][27]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.6,   --冲刺时间,单位：秒
        magnetTime = 3.6,   --磁铁时间,单位：秒
        giantTime = 3.6,   --巨人时间,单位：秒
        transTime=3.6,     --转换时间 (s)
        cloudTime=3.6,     --浮云时间(s)
    }
RoleLvs[1][28]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.7,   --冲刺时间,单位：秒
        magnetTime = 3.7,   --磁铁时间,单位：秒
        giantTime = 3.7,   --巨人时间,单位：秒
        transTime=3.7,     --转换时间 (s)
        cloudTime=3.7,     --浮云时间(s)
    }
RoleLvs[1][29]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.8,   --冲刺时间,单位：秒
        magnetTime = 3.8,   --磁铁时间,单位：秒
        giantTime = 3.8,   --巨人时间,单位：秒
        transTime=3.8,     --转换时间 (s)
        cloudTime=3.8,     --浮云时间(s)
    }
RoleLvs[1][30]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.9,   --冲刺时间,单位：秒
        magnetTime = 3.9,   --磁铁时间,单位：秒
        giantTime = 3.9,   --巨人时间,单位：秒
        transTime=3.9,     --转换时间 (s)
        cloudTime=3.9,     --浮云时间(s)
    }	
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
        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }
RoleLvs[2][2]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.1,   --冲刺时间,单位：秒
        magnetTime = 1.1,   --磁铁时间,单位：秒
        giantTime = 1.1,   --巨人时间,单位：秒
        transTime=1.1,     --转换时间 (s)
        cloudTime=1.1,     --浮云时间(s)
    }
RoleLvs[2][3]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.2,   --冲刺时间,单位：秒
        magnetTime = 1.2,   --磁铁时间,单位：秒
        giantTime = 1.2,   --巨人时间,单位：秒
        transTime=1.2,     --转换时间 (s)
        cloudTime=1.2,     --浮云时间(s)
    }
RoleLvs[2][4]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.3,   --冲刺时间,单位：秒
        magnetTime = 1.3,   --磁铁时间,单位：秒
        giantTime = 1.3,   --巨人时间,单位：秒
        transTime=1.3,     --转换时间 (s)
        cloudTime=1.3,     --浮云时间(s)
    }
RoleLvs[2][5]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.4,   --冲刺时间,单位：秒
        magnetTime = 1.4,   --磁铁时间,单位：秒
        giantTime = 1.4,   --巨人时间,单位：秒
        transTime=1.4,     --转换时间 (s)
        cloudTime=1.4,     --浮云时间(s)
    }
RoleLvs[2][6]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.5,   --冲刺时间,单位：秒
        magnetTime = 1.5,   --磁铁时间,单位：秒
        giantTime = 1.5,   --巨人时间,单位：秒
        transTime=1.5,     --转换时间 (s)
        cloudTime=1.5,     --浮云时间(s)
    }
RoleLvs[2][7]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.6,   --冲刺时间,单位：秒
        magnetTime = 1.6,   --磁铁时间,单位：秒
        giantTime = 1.6,   --巨人时间,单位：秒
        transTime=1.6,     --转换时间 (s)
        cloudTime=1.6,     --浮云时间(s)
    }
RoleLvs[2][8]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.7,   --冲刺时间,单位：秒
        magnetTime = 1.7,   --磁铁时间,单位：秒
        giantTime = 1.7,   --巨人时间,单位：秒
        transTime=1.7,     --转换时间 (s)
        cloudTime=1.7,     --浮云时间(s)
    }
RoleLvs[2][9]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.8,   --冲刺时间,单位：秒
        magnetTime = 1.8,   --磁铁时间,单位：秒
        giantTime = 1.8,   --巨人时间,单位：秒
        transTime=1.8,     --转换时间 (s)
        cloudTime=1.8,     --浮云时间(s)
    }
RoleLvs[2][10]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.9,   --冲刺时间,单位：秒
        magnetTime = 1.9,   --磁铁时间,单位：秒
        giantTime = 1.9,   --巨人时间,单位：秒
        transTime=1.9,     --转换时间 (s)
        cloudTime=1.9,     --浮云时间(s)
    }
RoleLvs[2][11]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1500},
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
RoleLvs[2][12]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.1,   --冲刺时间,单位：秒
        magnetTime = 2.1,   --磁铁时间,单位：秒
        giantTime = 2.1,   --巨人时间,单位：秒
        transTime=2.1,     --转换时间 (s)
        cloudTime=2.1,     --浮云时间(s)
    }
RoleLvs[2][13]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.2,   --冲刺时间,单位：秒
        magnetTime = 2.2,   --磁铁时间,单位：秒
        giantTime = 2.2,   --巨人时间,单位：秒
        transTime=2.2,     --转换时间 (s)
        cloudTime=2.2,     --浮云时间(s)
    }
RoleLvs[2][14]=
  {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.3,   --冲刺时间,单位：秒
        magnetTime = 2.3,   --磁铁时间,单位：秒
        giantTime = 2.3,   --巨人时间,单位：秒
        transTime=2.3,     --转换时间 (s)
        cloudTime=2.3,     --浮云时间(s)
    }
RoleLvs[2][15]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.4,   --冲刺时间,单位：秒
        magnetTime = 2.4,   --磁铁时间,单位：秒
        giantTime = 2.4,   --巨人时间,单位：秒
        transTime=2.4,     --转换时间 (s)
        cloudTime=2.4,     --浮云时间(s)
    }
RoleLvs[2][16]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.5,   --冲刺时间,单位：秒
        magnetTime = 2.5,   --磁铁时间,单位：秒
        giantTime = 2.5,   --巨人时间,单位：秒
        transTime=2.5,     --转换时间 (s)
        cloudTime=2.5,     --浮云时间(s)
    }
RoleLvs[2][17]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.6,   --冲刺时间,单位：秒
        magnetTime = 2.6,   --磁铁时间,单位：秒
        giantTime = 2.6,   --巨人时间,单位：秒
        transTime=2.6,     --转换时间 (s)
        cloudTime=2.6,     --浮云时间(s)
    }
RoleLvs[2][18]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.7,   --冲刺时间,单位：秒
        magnetTime = 2.7,   --磁铁时间,单位：秒
        giantTime = 2.7,   --巨人时间,单位：秒
        transTime=2.7,     --转换时间 (s)
        cloudTime=2.7,     --浮云时间(s)
    }
RoleLvs[2][19]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.8,   --冲刺时间,单位：秒
        magnetTime = 2.8,   --磁铁时间,单位：秒
        giantTime = 2.8,   --巨人时间,单位：秒
        transTime=2.8,     --转换时间 (s)
        cloudTime=2.8,     --浮云时间(s)
    }
RoleLvs[2][20]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.9,   --冲刺时间,单位：秒
        magnetTime = 2.9,   --磁铁时间,单位：秒
        giantTime = 2.9,   --巨人时间,单位：秒
        transTime=2.9,     --转换时间 (s)
        cloudTime=2.9,     --浮云时间(s)
    }
RoleLvs[2][21]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2500},
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
RoleLvs[2][22]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.1,   --冲刺时间,单位：秒
        magnetTime = 3.1,   --磁铁时间,单位：秒
        giantTime = 3.1,   --巨人时间,单位：秒
        transTime=3.1,     --转换时间 (s)
        cloudTime=3.1,     --浮云时间(s)
    }	
RoleLvs[2][23]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.2,   --冲刺时间,单位：秒
        magnetTime = 3.2,   --磁铁时间,单位：秒
        giantTime = 3.2,   --巨人时间,单位：秒
        transTime=3.2,     --转换时间 (s)
        cloudTime=3.2,     --浮云时间(s)
    }
RoleLvs[2][24]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.3,   --冲刺时间,单位：秒
        magnetTime = 3.3,   --磁铁时间,单位：秒
        giantTime = 3.3,   --巨人时间,单位：秒
        transTime=3.3,     --转换时间 (s)
        cloudTime=3.3,     --浮云时间(s)
    }
RoleLvs[2][25]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.4,   --冲刺时间,单位：秒
        magnetTime = 3.4,   --磁铁时间,单位：秒
        giantTime = 3.4,   --巨人时间,单位：秒
        transTime=3.4,     --转换时间 (s)
        cloudTime=3.4,     --浮云时间(s)
    }	 
RoleLvs[2][26]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.5,   --冲刺时间,单位：秒
        magnetTime = 3.5,   --磁铁时间,单位：秒
        giantTime = 3.5,   --巨人时间,单位：秒
        transTime=3.5,     --转换时间 (s)
        cloudTime=3.5,     --浮云时间(s)
    }
RoleLvs[2][27]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.6,   --冲刺时间,单位：秒
        magnetTime = 3.6,   --磁铁时间,单位：秒
        giantTime = 3.6,   --巨人时间,单位：秒
        transTime=3.6,     --转换时间 (s)
        cloudTime=3.6,     --浮云时间(s)
    }
RoleLvs[2][28]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.7,   --冲刺时间,单位：秒
        magnetTime = 3.7,   --磁铁时间,单位：秒
        giantTime = 3.7,   --巨人时间,单位：秒
        transTime=3.7,     --转换时间 (s)
        cloudTime=3.7,     --浮云时间(s)
    }
RoleLvs[2][29]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.8,   --冲刺时间,单位：秒
        magnetTime = 3.8,   --磁铁时间,单位：秒
        giantTime = 3.8,   --巨人时间,单位：秒
        transTime=3.8,     --转换时间 (s)
        cloudTime=3.8,     --浮云时间(s)
    }
RoleLvs[2][30]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.9,   --冲刺时间,单位：秒
        magnetTime = 3.9,   --磁铁时间,单位：秒
        giantTime = 3.9,   --巨人时间,单位：秒
        transTime=3.9,     --转换时间 (s)
        cloudTime=3.9,     --浮云时间(s)
    }	
RoleLvs[2][31]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3500},
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
RoleLvs[2][32]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.1,   --冲刺时间,单位：秒
        magnetTime = 4.1,   --磁铁时间,单位：秒
        giantTime = 4.1,   --巨人时间,单位：秒
        transTime=4.1,     --转换时间 (s)
        cloudTime=4.1,     --浮云时间(s)
    }	
RoleLvs[2][33]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.2,   --冲刺时间,单位：秒
        magnetTime = 4.2,   --磁铁时间,单位：秒
        giantTime = 4.2,   --巨人时间,单位：秒
        transTime=4.2,     --转换时间 (s)
        cloudTime=4.2,     --浮云时间(s)
    }	
RoleLvs[2][34]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.3,   --冲刺时间,单位：秒
        magnetTime = 4.3,   --磁铁时间,单位：秒
        giantTime = 4.3,   --巨人时间,单位：秒
        transTime=4.3,     --转换时间 (s)
        cloudTime=4.3,     --浮云时间(s)
    }	
RoleLvs[2][35]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.4,   --冲刺时间,单位：秒
        magnetTime = 4.4,   --磁铁时间,单位：秒
        giantTime = 4.4,   --巨人时间,单位：秒
        transTime=4.4,     --转换时间 (s)
        cloudTime=4.4,     --浮云时间(s)
    }	
RoleLvs[2][36]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.5,   --冲刺时间,单位：秒
        magnetTime = 4.5,   --磁铁时间,单位：秒
        giantTime = 4.5,   --巨人时间,单位：秒
        transTime=4.5,     --转换时间 (s)
        cloudTime=4.5,     --浮云时间(s)
    }	
RoleLvs[2][37]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.6,   --冲刺时间,单位：秒
        magnetTime = 4.6,   --磁铁时间,单位：秒
        giantTime = 4.6,   --巨人时间,单位：秒
        transTime=4.6,     --转换时间 (s)
        cloudTime=4.6,     --浮云时间(s)
    }	
RoleLvs[2][38]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.7,   --冲刺时间,单位：秒
        magnetTime = 4.7,   --磁铁时间,单位：秒
        giantTime = 4.7,   --巨人时间,单位：秒
        transTime=4.7,     --转换时间 (s)
        cloudTime=4.7,     --浮云时间(s)
    }	
RoleLvs[2][39]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.8,   --冲刺时间,单位：秒
        magnetTime = 4.8,   --磁铁时间,单位：秒
        giantTime = 4.8,   --巨人时间,单位：秒
        transTime=4.8,     --转换时间 (s)
        cloudTime=4.8,     --浮云时间(s)
    }	
RoleLvs[2][40]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.9,   --冲刺时间,单位：秒
        magnetTime = 4.9,   --磁铁时间,单位：秒
        giantTime = 4.9,   --巨人时间,单位：秒
        transTime=4.9,     --转换时间 (s)
        cloudTime=4.9,     --浮云时间(s)
    }	
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
        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }
RoleLvs[3][2]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.1,   --冲刺时间,单位：秒
        magnetTime = 1.1,   --磁铁时间,单位：秒
        giantTime = 1.1,   --巨人时间,单位：秒
        transTime=1.1,     --转换时间 (s)
        cloudTime=1.1,     --浮云时间(s)
    }
RoleLvs[3][3]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.2,   --冲刺时间,单位：秒
        magnetTime = 1.2,   --磁铁时间,单位：秒
        giantTime = 1.2,   --巨人时间,单位：秒
        transTime=1.2,     --转换时间 (s)
        cloudTime=1.2,     --浮云时间(s)
    }
RoleLvs[3][4]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.3,   --冲刺时间,单位：秒
        magnetTime = 1.3,   --磁铁时间,单位：秒
        giantTime = 1.3,   --巨人时间,单位：秒
        transTime=1.3,     --转换时间 (s)
        cloudTime=1.3,     --浮云时间(s)
    }
RoleLvs[3][5]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.4,   --冲刺时间,单位：秒
        magnetTime = 1.4,   --磁铁时间,单位：秒
        giantTime = 1.4,   --巨人时间,单位：秒
        transTime=1.4,     --转换时间 (s)
        cloudTime=1.4,     --浮云时间(s)
    }
RoleLvs[3][6]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.5,   --冲刺时间,单位：秒
        magnetTime = 1.5,   --磁铁时间,单位：秒
        giantTime = 1.5,   --巨人时间,单位：秒
        transTime=1.5,     --转换时间 (s)
        cloudTime=1.5,     --浮云时间(s)
    }
RoleLvs[3][7]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.6,   --冲刺时间,单位：秒
        magnetTime = 1.6,   --磁铁时间,单位：秒
        giantTime = 1.6,   --巨人时间,单位：秒
        transTime=1.6,     --转换时间 (s)
        cloudTime=1.6,     --浮云时间(s)
    }
RoleLvs[3][8]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.7,   --冲刺时间,单位：秒
        magnetTime = 1.7,   --磁铁时间,单位：秒
        giantTime = 1.7,   --巨人时间,单位：秒
        transTime=1.7,     --转换时间 (s)
        cloudTime=1.7,     --浮云时间(s)
    }
RoleLvs[3][9]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.8,   --冲刺时间,单位：秒
        magnetTime = 1.8,   --磁铁时间,单位：秒
        giantTime = 1.8,   --巨人时间,单位：秒
        transTime=1.8,     --转换时间 (s)
        cloudTime=1.8,     --浮云时间(s)
    }
RoleLvs[3][10]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.9,   --冲刺时间,单位：秒
        magnetTime = 1.9,   --磁铁时间,单位：秒
        giantTime = 1.9,   --巨人时间,单位：秒
        transTime=1.9,     --转换时间 (s)
        cloudTime=1.9,     --浮云时间(s)
    }
RoleLvs[3][11]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1500},
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
RoleLvs[3][12]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.1,   --冲刺时间,单位：秒
        magnetTime = 2.1,   --磁铁时间,单位：秒
        giantTime = 2.1,   --巨人时间,单位：秒
        transTime=2.1,     --转换时间 (s)
        cloudTime=2.1,     --浮云时间(s)
    }
RoleLvs[3][13]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.2,   --冲刺时间,单位：秒
        magnetTime = 2.2,   --磁铁时间,单位：秒
        giantTime = 2.2,   --巨人时间,单位：秒
        transTime=2.2,     --转换时间 (s)
        cloudTime=2.2,     --浮云时间(s)
    }
RoleLvs[3][14]=
  {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.3,   --冲刺时间,单位：秒
        magnetTime = 2.3,   --磁铁时间,单位：秒
        giantTime = 2.3,   --巨人时间,单位：秒
        transTime=2.3,     --转换时间 (s)
        cloudTime=2.3,     --浮云时间(s)
    }
RoleLvs[3][15]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.4,   --冲刺时间,单位：秒
        magnetTime = 2.4,   --磁铁时间,单位：秒
        giantTime = 2.4,   --巨人时间,单位：秒
        transTime=2.4,     --转换时间 (s)
        cloudTime=2.4,     --浮云时间(s)
    }
RoleLvs[3][16]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.5,   --冲刺时间,单位：秒
        magnetTime = 2.5,   --磁铁时间,单位：秒
        giantTime = 2.5,   --巨人时间,单位：秒
        transTime=2.5,     --转换时间 (s)
        cloudTime=2.5,     --浮云时间(s)
    }
RoleLvs[3][17]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.6,   --冲刺时间,单位：秒
        magnetTime = 2.6,   --磁铁时间,单位：秒
        giantTime = 2.6,   --巨人时间,单位：秒
        transTime=2.6,     --转换时间 (s)
        cloudTime=2.6,     --浮云时间(s)
    }
RoleLvs[3][18]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.7,   --冲刺时间,单位：秒
        magnetTime = 2.7,   --磁铁时间,单位：秒
        giantTime = 2.7,   --巨人时间,单位：秒
        transTime=2.7,     --转换时间 (s)
        cloudTime=2.7,     --浮云时间(s)
    }
RoleLvs[3][19]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.8,   --冲刺时间,单位：秒
        magnetTime = 2.8,   --磁铁时间,单位：秒
        giantTime = 2.8,   --巨人时间,单位：秒
        transTime=2.8,     --转换时间 (s)
        cloudTime=2.8,     --浮云时间(s)
    }
RoleLvs[3][20]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.9,   --冲刺时间,单位：秒
        magnetTime = 2.9,   --磁铁时间,单位：秒
        giantTime = 2.9,   --巨人时间,单位：秒
        transTime=2.9,     --转换时间 (s)
        cloudTime=2.9,     --浮云时间(s)
    }
RoleLvs[3][21]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2500},
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
RoleLvs[3][22]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.1,   --冲刺时间,单位：秒
        magnetTime = 3.1,   --磁铁时间,单位：秒
        giantTime = 3.1,   --巨人时间,单位：秒
        transTime=3.1,     --转换时间 (s)
        cloudTime=3.1,     --浮云时间(s)
    }	
RoleLvs[3][23]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.2,   --冲刺时间,单位：秒
        magnetTime = 3.2,   --磁铁时间,单位：秒
        giantTime = 3.2,   --巨人时间,单位：秒
        transTime=3.2,     --转换时间 (s)
        cloudTime=3.2,     --浮云时间(s)
    }
RoleLvs[3][24]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.3,   --冲刺时间,单位：秒
        magnetTime = 3.3,   --磁铁时间,单位：秒
        giantTime = 3.3,   --巨人时间,单位：秒
        transTime=3.3,     --转换时间 (s)
        cloudTime=3.3,     --浮云时间(s)
    }
RoleLvs[3][25]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.4,   --冲刺时间,单位：秒
        magnetTime = 3.4,   --磁铁时间,单位：秒
        giantTime = 3.4,   --巨人时间,单位：秒
        transTime=3.4,     --转换时间 (s)
        cloudTime=3.4,     --浮云时间(s)
    }	 
RoleLvs[3][26]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.5,   --冲刺时间,单位：秒
        magnetTime = 3.5,   --磁铁时间,单位：秒
        giantTime = 3.5,   --巨人时间,单位：秒
        transTime=3.5,     --转换时间 (s)
        cloudTime=3.5,     --浮云时间(s)
    }
RoleLvs[3][27]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.6,   --冲刺时间,单位：秒
        magnetTime = 3.6,   --磁铁时间,单位：秒
        giantTime = 3.6,   --巨人时间,单位：秒
        transTime=3.6,     --转换时间 (s)
        cloudTime=3.6,     --浮云时间(s)
    }
RoleLvs[3][28]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.7,   --冲刺时间,单位：秒
        magnetTime = 3.7,   --磁铁时间,单位：秒
        giantTime = 3.7,   --巨人时间,单位：秒
        transTime=3.7,     --转换时间 (s)
        cloudTime=3.7,     --浮云时间(s)
    }
RoleLvs[3][29]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.8,   --冲刺时间,单位：秒
        magnetTime = 3.8,   --磁铁时间,单位：秒
        giantTime = 3.8,   --巨人时间,单位：秒
        transTime=3.8,     --转换时间 (s)
        cloudTime=3.8,     --浮云时间(s)
    }
RoleLvs[3][30]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.9,   --冲刺时间,单位：秒
        magnetTime = 3.9,   --磁铁时间,单位：秒
        giantTime = 3.9,   --巨人时间,单位：秒
        transTime=3.9,     --转换时间 (s)
        cloudTime=3.9,     --浮云时间(s)
    }	
RoleLvs[3][31]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3500},
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
RoleLvs[3][32]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.1,   --冲刺时间,单位：秒
        magnetTime = 4.1,   --磁铁时间,单位：秒
        giantTime = 4.1,   --巨人时间,单位：秒
        transTime=4.1,     --转换时间 (s)
        cloudTime=4.1,     --浮云时间(s)
    }	
RoleLvs[3][33]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.2,   --冲刺时间,单位：秒
        magnetTime = 4.2,   --磁铁时间,单位：秒
        giantTime = 4.2,   --巨人时间,单位：秒
        transTime=4.2,     --转换时间 (s)
        cloudTime=4.2,     --浮云时间(s)
    }	
RoleLvs[3][34]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.3,   --冲刺时间,单位：秒
        magnetTime = 4.3,   --磁铁时间,单位：秒
        giantTime = 4.3,   --巨人时间,单位：秒
        transTime=4.3,     --转换时间 (s)
        cloudTime=4.3,     --浮云时间(s)
    }	
RoleLvs[3][35]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.4,   --冲刺时间,单位：秒
        magnetTime = 4.4,   --磁铁时间,单位：秒
        giantTime = 4.4,   --巨人时间,单位：秒
        transTime=4.4,     --转换时间 (s)
        cloudTime=4.4,     --浮云时间(s)
    }	
RoleLvs[3][36]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.5,   --冲刺时间,单位：秒
        magnetTime = 4.5,   --磁铁时间,单位：秒
        giantTime = 4.5,   --巨人时间,单位：秒
        transTime=4.5,     --转换时间 (s)
        cloudTime=4.5,     --浮云时间(s)
    }	
RoleLvs[3][37]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.6,   --冲刺时间,单位：秒
        magnetTime = 4.6,   --磁铁时间,单位：秒
        giantTime = 4.6,   --巨人时间,单位：秒
        transTime=4.6,     --转换时间 (s)
        cloudTime=4.6,     --浮云时间(s)
    }	
RoleLvs[3][38]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.7,   --冲刺时间,单位：秒
        magnetTime = 4.7,   --磁铁时间,单位：秒
        giantTime = 4.7,   --巨人时间,单位：秒
        transTime=4.7,     --转换时间 (s)
        cloudTime=4.7,     --浮云时间(s)
    }	
RoleLvs[3][39]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.8,   --冲刺时间,单位：秒
        magnetTime = 4.8,   --磁铁时间,单位：秒
        giantTime = 4.8,   --巨人时间,单位：秒
        transTime=4.8,     --转换时间 (s)
        cloudTime=4.8,     --浮云时间(s)
    }	
RoleLvs[3][40]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.9,   --冲刺时间,单位：秒
        magnetTime = 4.9,   --磁铁时间,单位：秒
        giantTime = 4.9,   --巨人时间,单位：秒
        transTime=4.9,     --转换时间 (s)
        cloudTime=4.9,     --浮云时间(s)
    }	

RoleLvs[3][41]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4500},
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
RoleLvs[3][42]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.1,   --冲刺时间,单位：秒
        magnetTime = 5.1,   --磁铁时间,单位：秒
        giantTime = 5.1,   --巨人时间,单位：秒
        transTime=5.1,     --转换时间 (s)
        cloudTime=5.1,     --浮云时间(s)
    }
RoleLvs[3][43]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.2,   --冲刺时间,单位：秒
        magnetTime = 5.2,   --磁铁时间,单位：秒
        giantTime = 5.2,   --巨人时间,单位：秒
        transTime=5.2,     --转换时间 (s)
        cloudTime=5.2,     --浮云时间(s)
    }
RoleLvs[3][44]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.3,   --冲刺时间,单位：秒
        magnetTime = 5.3,   --磁铁时间,单位：秒
        giantTime = 5.3,   --巨人时间,单位：秒
        transTime=5.3,     --转换时间 (s)
        cloudTime=5.3,     --浮云时间(s)
    }
RoleLvs[3][45]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.4,   --冲刺时间,单位：秒
        magnetTime = 5.4,   --磁铁时间,单位：秒
        giantTime = 5.4,   --巨人时间,单位：秒
        transTime=5.4,     --转换时间 (s)
        cloudTime=5.4,     --浮云时间(s)
    }
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
        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }
RoleLvs[4][2]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.1,   --冲刺时间,单位：秒
        magnetTime = 1.1,   --磁铁时间,单位：秒
        giantTime = 1.1,   --巨人时间,单位：秒
        transTime=1.1,     --转换时间 (s)
        cloudTime=1.1,     --浮云时间(s)
    }
RoleLvs[4][3]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.2,   --冲刺时间,单位：秒
        magnetTime = 1.2,   --磁铁时间,单位：秒
        giantTime = 1.2,   --巨人时间,单位：秒
        transTime=1.2,     --转换时间 (s)
        cloudTime=1.2,     --浮云时间(s)
    }
RoleLvs[4][4]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.3,   --冲刺时间,单位：秒
        magnetTime = 1.3,   --磁铁时间,单位：秒
        giantTime = 1.3,   --巨人时间,单位：秒
        transTime=1.3,     --转换时间 (s)
        cloudTime=1.3,     --浮云时间(s)
    }
RoleLvs[4][5]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.4,   --冲刺时间,单位：秒
        magnetTime = 1.4,   --磁铁时间,单位：秒
        giantTime = 1.4,   --巨人时间,单位：秒
        transTime=1.4,     --转换时间 (s)
        cloudTime=1.4,     --浮云时间(s)
    }
RoleLvs[4][6]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.5,   --冲刺时间,单位：秒
        magnetTime = 1.5,   --磁铁时间,单位：秒
        giantTime = 1.5,   --巨人时间,单位：秒
        transTime=1.5,     --转换时间 (s)
        cloudTime=1.5,     --浮云时间(s)
    }
RoleLvs[4][7]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.6,   --冲刺时间,单位：秒
        magnetTime = 1.6,   --磁铁时间,单位：秒
        giantTime = 1.6,   --巨人时间,单位：秒
        transTime=1.6,     --转换时间 (s)
        cloudTime=1.6,     --浮云时间(s)
    }
RoleLvs[4][8]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.7,   --冲刺时间,单位：秒
        magnetTime = 1.7,   --磁铁时间,单位：秒
        giantTime = 1.7,   --巨人时间,单位：秒
        transTime=1.7,     --转换时间 (s)
        cloudTime=1.7,     --浮云时间(s)
    }
RoleLvs[4][9]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.8,   --冲刺时间,单位：秒
        magnetTime = 1.8,   --磁铁时间,单位：秒
        giantTime = 1.8,   --巨人时间,单位：秒
        transTime=1.8,     --转换时间 (s)
        cloudTime=1.8,     --浮云时间(s)
    }
RoleLvs[4][10]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.9,   --冲刺时间,单位：秒
        magnetTime = 1.9,   --磁铁时间,单位：秒
        giantTime = 1.9,   --巨人时间,单位：秒
        transTime=1.9,     --转换时间 (s)
        cloudTime=1.9,     --浮云时间(s)
    }
RoleLvs[4][11]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1500},
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
RoleLvs[4][12]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.1,   --冲刺时间,单位：秒
        magnetTime = 2.1,   --磁铁时间,单位：秒
        giantTime = 2.1,   --巨人时间,单位：秒
        transTime=2.1,     --转换时间 (s)
        cloudTime=2.1,     --浮云时间(s)
    }
RoleLvs[4][13]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.2,   --冲刺时间,单位：秒
        magnetTime = 2.2,   --磁铁时间,单位：秒
        giantTime = 2.2,   --巨人时间,单位：秒
        transTime=2.2,     --转换时间 (s)
        cloudTime=2.2,     --浮云时间(s)
    }
RoleLvs[4][14]=
  {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.3,   --冲刺时间,单位：秒
        magnetTime = 2.3,   --磁铁时间,单位：秒
        giantTime = 2.3,   --巨人时间,单位：秒
        transTime=2.3,     --转换时间 (s)
        cloudTime=2.3,     --浮云时间(s)
    }
RoleLvs[4][15]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.4,   --冲刺时间,单位：秒
        magnetTime = 2.4,   --磁铁时间,单位：秒
        giantTime = 2.4,   --巨人时间,单位：秒
        transTime=2.4,     --转换时间 (s)
        cloudTime=2.4,     --浮云时间(s)
    }
RoleLvs[4][16]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.5,   --冲刺时间,单位：秒
        magnetTime = 2.5,   --磁铁时间,单位：秒
        giantTime = 2.5,   --巨人时间,单位：秒
        transTime=2.5,     --转换时间 (s)
        cloudTime=2.5,     --浮云时间(s)
    }
RoleLvs[4][17]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.6,   --冲刺时间,单位：秒
        magnetTime = 2.6,   --磁铁时间,单位：秒
        giantTime = 2.6,   --巨人时间,单位：秒
        transTime=2.6,     --转换时间 (s)
        cloudTime=2.6,     --浮云时间(s)
    }
RoleLvs[4][18]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.7,   --冲刺时间,单位：秒
        magnetTime = 2.7,   --磁铁时间,单位：秒
        giantTime = 2.7,   --巨人时间,单位：秒
        transTime=2.7,     --转换时间 (s)
        cloudTime=2.7,     --浮云时间(s)
    }
RoleLvs[4][19]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.8,   --冲刺时间,单位：秒
        magnetTime = 2.8,   --磁铁时间,单位：秒
        giantTime = 2.8,   --巨人时间,单位：秒
        transTime=2.8,     --转换时间 (s)
        cloudTime=2.8,     --浮云时间(s)
    }
RoleLvs[4][20]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.9,   --冲刺时间,单位：秒
        magnetTime = 2.9,   --磁铁时间,单位：秒
        giantTime = 2.9,   --巨人时间,单位：秒
        transTime=2.9,     --转换时间 (s)
        cloudTime=2.9,     --浮云时间(s)
    }
RoleLvs[4][21]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2500},
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
RoleLvs[4][22]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.1,   --冲刺时间,单位：秒
        magnetTime = 3.1,   --磁铁时间,单位：秒
        giantTime = 3.1,   --巨人时间,单位：秒
        transTime=3.1,     --转换时间 (s)
        cloudTime=3.1,     --浮云时间(s)
    }	
RoleLvs[4][23]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.2,   --冲刺时间,单位：秒
        magnetTime = 3.2,   --磁铁时间,单位：秒
        giantTime = 3.2,   --巨人时间,单位：秒
        transTime=3.2,     --转换时间 (s)
        cloudTime=3.2,     --浮云时间(s)
    }
RoleLvs[4][24]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.3,   --冲刺时间,单位：秒
        magnetTime = 3.3,   --磁铁时间,单位：秒
        giantTime = 3.3,   --巨人时间,单位：秒
        transTime=3.3,     --转换时间 (s)
        cloudTime=3.3,     --浮云时间(s)
    }
RoleLvs[4][25]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.4,   --冲刺时间,单位：秒
        magnetTime = 3.4,   --磁铁时间,单位：秒
        giantTime = 3.4,   --巨人时间,单位：秒
        transTime=3.4,     --转换时间 (s)
        cloudTime=3.4,     --浮云时间(s)
    }	 
RoleLvs[4][26]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.5,   --冲刺时间,单位：秒
        magnetTime = 3.5,   --磁铁时间,单位：秒
        giantTime = 3.5,   --巨人时间,单位：秒
        transTime=3.5,     --转换时间 (s)
        cloudTime=3.5,     --浮云时间(s)
    }
RoleLvs[4][27]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.6,   --冲刺时间,单位：秒
        magnetTime = 3.6,   --磁铁时间,单位：秒
        giantTime = 3.6,   --巨人时间,单位：秒
        transTime=3.6,     --转换时间 (s)
        cloudTime=3.6,     --浮云时间(s)
    }
RoleLvs[4][28]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.7,   --冲刺时间,单位：秒
        magnetTime = 3.7,   --磁铁时间,单位：秒
        giantTime = 3.7,   --巨人时间,单位：秒
        transTime=3.7,     --转换时间 (s)
        cloudTime=3.7,     --浮云时间(s)
    }
RoleLvs[4][29]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.8,   --冲刺时间,单位：秒
        magnetTime = 3.8,   --磁铁时间,单位：秒
        giantTime = 3.8,   --巨人时间,单位：秒
        transTime=3.8,     --转换时间 (s)
        cloudTime=3.8,     --浮云时间(s)
    }
RoleLvs[4][30]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.9,   --冲刺时间,单位：秒
        magnetTime = 3.9,   --磁铁时间,单位：秒
        giantTime = 3.9,   --巨人时间,单位：秒
        transTime=3.9,     --转换时间 (s)
        cloudTime=3.9,     --浮云时间(s)
    }	
RoleLvs[4][31]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3500},
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
RoleLvs[4][32]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.1,   --冲刺时间,单位：秒
        magnetTime = 4.1,   --磁铁时间,单位：秒
        giantTime = 4.1,   --巨人时间,单位：秒
        transTime=4.1,     --转换时间 (s)
        cloudTime=4.1,     --浮云时间(s)
    }	
RoleLvs[4][33]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.2,   --冲刺时间,单位：秒
        magnetTime = 4.2,   --磁铁时间,单位：秒
        giantTime = 4.2,   --巨人时间,单位：秒
        transTime=4.2,     --转换时间 (s)
        cloudTime=4.2,     --浮云时间(s)
    }	
RoleLvs[4][34]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.3,   --冲刺时间,单位：秒
        magnetTime = 4.3,   --磁铁时间,单位：秒
        giantTime = 4.3,   --巨人时间,单位：秒
        transTime=4.3,     --转换时间 (s)
        cloudTime=4.3,     --浮云时间(s)
    }	
RoleLvs[4][35]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.4,   --冲刺时间,单位：秒
        magnetTime = 4.4,   --磁铁时间,单位：秒
        giantTime = 4.4,   --巨人时间,单位：秒
        transTime=4.4,     --转换时间 (s)
        cloudTime=4.4,     --浮云时间(s)
    }	
RoleLvs[4][36]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.5,   --冲刺时间,单位：秒
        magnetTime = 4.5,   --磁铁时间,单位：秒
        giantTime = 4.5,   --巨人时间,单位：秒
        transTime=4.5,     --转换时间 (s)
        cloudTime=4.5,     --浮云时间(s)
    }	
RoleLvs[4][37]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.6,   --冲刺时间,单位：秒
        magnetTime = 4.6,   --磁铁时间,单位：秒
        giantTime = 4.6,   --巨人时间,单位：秒
        transTime=4.6,     --转换时间 (s)
        cloudTime=4.6,     --浮云时间(s)
    }	
RoleLvs[4][38]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.7,   --冲刺时间,单位：秒
        magnetTime = 4.7,   --磁铁时间,单位：秒
        giantTime = 4.7,   --巨人时间,单位：秒
        transTime=4.7,     --转换时间 (s)
        cloudTime=4.7,     --浮云时间(s)
    }	
RoleLvs[4][39]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.8,   --冲刺时间,单位：秒
        magnetTime = 4.8,   --磁铁时间,单位：秒
        giantTime = 4.8,   --巨人时间,单位：秒
        transTime=4.8,     --转换时间 (s)
        cloudTime=4.8,     --浮云时间(s)
    }	
RoleLvs[4][40]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.9,   --冲刺时间,单位：秒
        magnetTime = 4.9,   --磁铁时间,单位：秒
        giantTime = 4.9,   --巨人时间,单位：秒
        transTime=4.9,     --转换时间 (s)
        cloudTime=4.9,     --浮云时间(s)
    }	

RoleLvs[4][41]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4500},
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
RoleLvs[4][42]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.1,   --冲刺时间,单位：秒
        magnetTime = 5.1,   --磁铁时间,单位：秒
        giantTime = 5.1,   --巨人时间,单位：秒
        transTime=5.1,     --转换时间 (s)
        cloudTime=5.1,     --浮云时间(s)
    }
RoleLvs[4][43]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.2,   --冲刺时间,单位：秒
        magnetTime = 5.2,   --磁铁时间,单位：秒
        giantTime = 5.2,   --巨人时间,单位：秒
        transTime=5.2,     --转换时间 (s)
        cloudTime=5.2,     --浮云时间(s)
    }
RoleLvs[4][44]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.3,   --冲刺时间,单位：秒
        magnetTime = 5.3,   --磁铁时间,单位：秒
        giantTime = 5.3,   --巨人时间,单位：秒
        transTime=5.3,     --转换时间 (s)
        cloudTime=5.3,     --浮云时间(s)
    }
RoleLvs[4][45]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.4,   --冲刺时间,单位：秒
        magnetTime = 5.4,   --磁铁时间,单位：秒
        giantTime = 5.4,   --巨人时间,单位：秒
        transTime=5.4,     --转换时间 (s)
        cloudTime=5.4,     --浮云时间(s)
    }
RoleLvs[4][46]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.5,   --冲刺时间,单位：秒
        magnetTime = 5.5,   --磁铁时间,单位：秒
        giantTime = 5.5,   --巨人时间,单位：秒
        transTime=5.5,     --转换时间 (s)
        cloudTime=5.5,     --浮云时间(s)
    }
RoleLvs[4][47]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.6,   --冲刺时间,单位：秒
        magnetTime = 5.6,   --磁铁时间,单位：秒
        giantTime = 5.6,   --巨人时间,单位：秒
        transTime=5.6,     --转换时间 (s)
        cloudTime=5.6,     --浮云时间(s)
    }
RoleLvs[4][48]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.7,   --冲刺时间,单位：秒
        magnetTime = 5.7,   --磁铁时间,单位：秒
        giantTime = 5.7,   --巨人时间,单位：秒
        transTime=5.7,     --转换时间 (s)
        cloudTime=5.7,     --浮云时间(s)
    }
RoleLvs[4][49]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.8,   --冲刺时间,单位：秒
        magnetTime = 5.8,   --磁铁时间,单位：秒
        giantTime = 5.8,   --巨人时间,单位：秒
        transTime=5.8,     --转换时间 (s)
        cloudTime=5.8,     --浮云时间(s)
    }
RoleLvs[4][50]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.9,   --冲刺时间,单位：秒
        magnetTime = 5.9,   --磁铁时间,单位：秒
        giantTime = 5.9,   --巨人时间,单位：秒
        transTime=5.9,     --转换时间 (s)
        cloudTime=5.9,     --浮云时间(s)
    }
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
        sprintTime = 1,   --冲刺时间,单位：秒
        magnetTime = 1,   --磁铁时间,单位：秒
        giantTime = 1,   --巨人时间,单位：秒
        transTime=1,     --转换时间 (s)
        cloudTime=1,     --浮云时间(s)
    }
RoleLvs[5][2]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.1,   --冲刺时间,单位：秒
        magnetTime = 1.1,   --磁铁时间,单位：秒
        giantTime = 1.1,   --巨人时间,单位：秒
        transTime=1.1,     --转换时间 (s)
        cloudTime=1.1,     --浮云时间(s)
    }
RoleLvs[5][3]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.2,   --冲刺时间,单位：秒
        magnetTime = 1.2,   --磁铁时间,单位：秒
        giantTime = 1.2,   --巨人时间,单位：秒
        transTime=1.2,     --转换时间 (s)
        cloudTime=1.2,     --浮云时间(s)
    }
RoleLvs[5][4]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.3,   --冲刺时间,单位：秒
        magnetTime = 1.3,   --磁铁时间,单位：秒
        giantTime = 1.3,   --巨人时间,单位：秒
        transTime=1.3,     --转换时间 (s)
        cloudTime=1.3,     --浮云时间(s)
    }
RoleLvs[5][5]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.4,   --冲刺时间,单位：秒
        magnetTime = 1.4,   --磁铁时间,单位：秒
        giantTime = 1.4,   --巨人时间,单位：秒
        transTime=1.4,     --转换时间 (s)
        cloudTime=1.4,     --浮云时间(s)
    }
RoleLvs[5][6]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.5,   --冲刺时间,单位：秒
        magnetTime = 1.5,   --磁铁时间,单位：秒
        giantTime = 1.5,   --巨人时间,单位：秒
        transTime=1.5,     --转换时间 (s)
        cloudTime=1.5,     --浮云时间(s)
    }
RoleLvs[5][7]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.6,   --冲刺时间,单位：秒
        magnetTime = 1.6,   --磁铁时间,单位：秒
        giantTime = 1.6,   --巨人时间,单位：秒
        transTime=1.6,     --转换时间 (s)
        cloudTime=1.6,     --浮云时间(s)
    }
RoleLvs[5][8]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.7,   --冲刺时间,单位：秒
        magnetTime = 1.7,   --磁铁时间,单位：秒
        giantTime = 1.7,   --巨人时间,单位：秒
        transTime=1.7,     --转换时间 (s)
        cloudTime=1.7,     --浮云时间(s)
    }
RoleLvs[5][9]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.8,   --冲刺时间,单位：秒
        magnetTime = 1.8,   --磁铁时间,单位：秒
        giantTime = 1.8,   --巨人时间,单位：秒
        transTime=1.8,     --转换时间 (s)
        cloudTime=1.8,     --浮云时间(s)
    }
RoleLvs[5][10]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 1.9,   --冲刺时间,单位：秒
        magnetTime = 1.9,   --磁铁时间,单位：秒
        giantTime = 1.9,   --巨人时间,单位：秒
        transTime=1.9,     --转换时间 (s)
        cloudTime=1.9,     --浮云时间(s)
    }
RoleLvs[5][11]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1500},
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
RoleLvs[5][12]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.1,   --冲刺时间,单位：秒
        magnetTime = 2.1,   --磁铁时间,单位：秒
        giantTime = 2.1,   --巨人时间,单位：秒
        transTime=2.1,     --转换时间 (s)
        cloudTime=2.1,     --浮云时间(s)
    }
RoleLvs[5][13]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.2,   --冲刺时间,单位：秒
        magnetTime = 2.2,   --磁铁时间,单位：秒
        giantTime = 2.2,   --巨人时间,单位：秒
        transTime=2.2,     --转换时间 (s)
        cloudTime=2.2,     --浮云时间(s)
    }
RoleLvs[5][14]=
  {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.3,   --冲刺时间,单位：秒
        magnetTime = 2.3,   --磁铁时间,单位：秒
        giantTime = 2.3,   --巨人时间,单位：秒
        transTime=2.3,     --转换时间 (s)
        cloudTime=2.3,     --浮云时间(s)
    }
RoleLvs[5][15]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 1900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.4,   --冲刺时间,单位：秒
        magnetTime = 2.4,   --磁铁时间,单位：秒
        giantTime = 2.4,   --巨人时间,单位：秒
        transTime=2.4,     --转换时间 (s)
        cloudTime=2.4,     --浮云时间(s)
    }
RoleLvs[5][16]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.5,   --冲刺时间,单位：秒
        magnetTime = 2.5,   --磁铁时间,单位：秒
        giantTime = 2.5,   --巨人时间,单位：秒
        transTime=2.5,     --转换时间 (s)
        cloudTime=2.5,     --浮云时间(s)
    }
RoleLvs[5][17]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.6,   --冲刺时间,单位：秒
        magnetTime = 2.6,   --磁铁时间,单位：秒
        giantTime = 2.6,   --巨人时间,单位：秒
        transTime=2.6,     --转换时间 (s)
        cloudTime=2.6,     --浮云时间(s)
    }
RoleLvs[5][18]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.7,   --冲刺时间,单位：秒
        magnetTime = 2.7,   --磁铁时间,单位：秒
        giantTime = 2.7,   --巨人时间,单位：秒
        transTime=2.7,     --转换时间 (s)
        cloudTime=2.7,     --浮云时间(s)
    }
RoleLvs[5][19]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.8,   --冲刺时间,单位：秒
        magnetTime = 2.8,   --磁铁时间,单位：秒
        giantTime = 2.8,   --巨人时间,单位：秒
        transTime=2.8,     --转换时间 (s)
        cloudTime=2.8,     --浮云时间(s)
    }
RoleLvs[5][20]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 2.9,   --冲刺时间,单位：秒
        magnetTime = 2.9,   --磁铁时间,单位：秒
        giantTime = 2.9,   --巨人时间,单位：秒
        transTime=2.9,     --转换时间 (s)
        cloudTime=2.9,     --浮云时间(s)
    }
RoleLvs[5][21]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2500},
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
RoleLvs[5][22]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.1,   --冲刺时间,单位：秒
        magnetTime = 3.1,   --磁铁时间,单位：秒
        giantTime = 3.1,   --巨人时间,单位：秒
        transTime=3.1,     --转换时间 (s)
        cloudTime=3.1,     --浮云时间(s)
    }	
RoleLvs[5][23]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.2,   --冲刺时间,单位：秒
        magnetTime = 3.2,   --磁铁时间,单位：秒
        giantTime = 3.2,   --巨人时间,单位：秒
        transTime=3.2,     --转换时间 (s)
        cloudTime=3.2,     --浮云时间(s)
    }
RoleLvs[5][24]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.3,   --冲刺时间,单位：秒
        magnetTime = 3.3,   --磁铁时间,单位：秒
        giantTime = 3.3,   --巨人时间,单位：秒
        transTime=3.3,     --转换时间 (s)
        cloudTime=3.3,     --浮云时间(s)
    }
RoleLvs[5][25]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 2900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.4,   --冲刺时间,单位：秒
        magnetTime = 3.4,   --磁铁时间,单位：秒
        giantTime = 3.4,   --巨人时间,单位：秒
        transTime=3.4,     --转换时间 (s)
        cloudTime=3.4,     --浮云时间(s)
    }	 
RoleLvs[5][26]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.5,   --冲刺时间,单位：秒
        magnetTime = 3.5,   --磁铁时间,单位：秒
        giantTime = 3.5,   --巨人时间,单位：秒
        transTime=3.5,     --转换时间 (s)
        cloudTime=3.5,     --浮云时间(s)
    }
RoleLvs[5][27]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.6,   --冲刺时间,单位：秒
        magnetTime = 3.6,   --磁铁时间,单位：秒
        giantTime = 3.6,   --巨人时间,单位：秒
        transTime=3.6,     --转换时间 (s)
        cloudTime=3.6,     --浮云时间(s)
    }
RoleLvs[5][28]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.7,   --冲刺时间,单位：秒
        magnetTime = 3.7,   --磁铁时间,单位：秒
        giantTime = 3.7,   --巨人时间,单位：秒
        transTime=3.7,     --转换时间 (s)
        cloudTime=3.7,     --浮云时间(s)
    }
RoleLvs[5][29]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.8,   --冲刺时间,单位：秒
        magnetTime = 3.8,   --磁铁时间,单位：秒
        giantTime = 3.8,   --巨人时间,单位：秒
        transTime=3.8,     --转换时间 (s)
        cloudTime=3.8,     --浮云时间(s)
    }
RoleLvs[5][30]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 3.9,   --冲刺时间,单位：秒
        magnetTime = 3.9,   --磁铁时间,单位：秒
        giantTime = 3.9,   --巨人时间,单位：秒
        transTime=3.9,     --转换时间 (s)
        cloudTime=3.9,     --浮云时间(s)
    }	
RoleLvs[5][31]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3500},
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
RoleLvs[5][32]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.1,   --冲刺时间,单位：秒
        magnetTime = 4.1,   --磁铁时间,单位：秒
        giantTime = 4.1,   --巨人时间,单位：秒
        transTime=4.1,     --转换时间 (s)
        cloudTime=4.1,     --浮云时间(s)
    }	
RoleLvs[5][33]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.2,   --冲刺时间,单位：秒
        magnetTime = 4.2,   --磁铁时间,单位：秒
        giantTime = 4.2,   --巨人时间,单位：秒
        transTime=4.2,     --转换时间 (s)
        cloudTime=4.2,     --浮云时间(s)
    }	
RoleLvs[5][34]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.3,   --冲刺时间,单位：秒
        magnetTime = 4.3,   --磁铁时间,单位：秒
        giantTime = 4.3,   --巨人时间,单位：秒
        transTime=4.3,     --转换时间 (s)
        cloudTime=4.3,     --浮云时间(s)
    }	
RoleLvs[5][35]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 3900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.4,   --冲刺时间,单位：秒
        magnetTime = 4.4,   --磁铁时间,单位：秒
        giantTime = 4.4,   --巨人时间,单位：秒
        transTime=4.4,     --转换时间 (s)
        cloudTime=4.4,     --浮云时间(s)
    }	
RoleLvs[5][36]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.5,   --冲刺时间,单位：秒
        magnetTime = 4.5,   --磁铁时间,单位：秒
        giantTime = 4.5,   --巨人时间,单位：秒
        transTime=4.5,     --转换时间 (s)
        cloudTime=4.5,     --浮云时间(s)
    }	
RoleLvs[5][37]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.6,   --冲刺时间,单位：秒
        magnetTime = 4.6,   --磁铁时间,单位：秒
        giantTime = 4.6,   --巨人时间,单位：秒
        transTime=4.6,     --转换时间 (s)
        cloudTime=4.6,     --浮云时间(s)
    }	
RoleLvs[5][38]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.7,   --冲刺时间,单位：秒
        magnetTime = 4.7,   --磁铁时间,单位：秒
        giantTime = 4.7,   --巨人时间,单位：秒
        transTime=4.7,     --转换时间 (s)
        cloudTime=4.7,     --浮云时间(s)
    }	
RoleLvs[5][39]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.8,   --冲刺时间,单位：秒
        magnetTime = 4.8,   --磁铁时间,单位：秒
        giantTime = 4.8,   --巨人时间,单位：秒
        transTime=4.8,     --转换时间 (s)
        cloudTime=4.8,     --浮云时间(s)
    }	
RoleLvs[5][40]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 4.9,   --冲刺时间,单位：秒
        magnetTime = 4.9,   --磁铁时间,单位：秒
        giantTime = 4.9,   --巨人时间,单位：秒
        transTime=4.9,     --转换时间 (s)
        cloudTime=4.9,     --浮云时间(s)
    }	

RoleLvs[5][41]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4500},
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
RoleLvs[5][42]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.1,   --冲刺时间,单位：秒
        magnetTime = 5.1,   --磁铁时间,单位：秒
        giantTime = 5.1,   --巨人时间,单位：秒
        transTime=5.1,     --转换时间 (s)
        cloudTime=5.1,     --浮云时间(s)
    }
RoleLvs[5][43]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.2,   --冲刺时间,单位：秒
        magnetTime = 5.2,   --磁铁时间,单位：秒
        giantTime = 5.2,   --巨人时间,单位：秒
        transTime=5.2,     --转换时间 (s)
        cloudTime=5.2,     --浮云时间(s)
    }
RoleLvs[5][44]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.3,   --冲刺时间,单位：秒
        magnetTime = 5.3,   --磁铁时间,单位：秒
        giantTime = 5.3,   --巨人时间,单位：秒
        transTime=5.3,     --转换时间 (s)
        cloudTime=5.3,     --浮云时间(s)
    }
RoleLvs[5][45]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 4900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.4,   --冲刺时间,单位：秒
        magnetTime = 5.4,   --磁铁时间,单位：秒
        giantTime = 5.4,   --巨人时间,单位：秒
        transTime=5.4,     --转换时间 (s)
        cloudTime=5.4,     --浮云时间(s)
    }
RoleLvs[5][46]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.5,   --冲刺时间,单位：秒
        magnetTime = 5.5,   --磁铁时间,单位：秒
        giantTime = 5.5,   --巨人时间,单位：秒
        transTime=5.5,     --转换时间 (s)
        cloudTime=5.5,     --浮云时间(s)
    }
RoleLvs[5][47]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.6,   --冲刺时间,单位：秒
        magnetTime = 5.6,   --磁铁时间,单位：秒
        giantTime = 5.6,   --巨人时间,单位：秒
        transTime=5.6,     --转换时间 (s)
        cloudTime=5.6,     --浮云时间(s)
    }
RoleLvs[5][48]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.7,   --冲刺时间,单位：秒
        magnetTime = 5.7,   --磁铁时间,单位：秒
        giantTime = 5.7,   --巨人时间,单位：秒
        transTime=5.7,     --转换时间 (s)
        cloudTime=5.7,     --浮云时间(s)
    }
RoleLvs[5][49]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.8,   --冲刺时间,单位：秒
        magnetTime = 5.8,   --磁铁时间,单位：秒
        giantTime = 5.8,   --巨人时间,单位：秒
        transTime=5.8,     --转换时间 (s)
        cloudTime=5.8,     --浮云时间(s)
    }
RoleLvs[5][50]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 5.9,   --冲刺时间,单位：秒
        magnetTime = 5.9,   --磁铁时间,单位：秒
        giantTime = 5.9,   --巨人时间,单位：秒
        transTime=5.9,     --转换时间 (s)
        cloudTime=5.9,     --浮云时间(s)
    }
RoleLvs[5][51]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5500},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 6,   --冲刺时间,单位：秒
        magnetTime = 6,   --磁铁时间,单位：秒
        giantTime = 6,   --巨人时间,单位：秒
        transTime=6,     --转换时间 (s)
        cloudTime=6,     --浮云时间(s)
    }
RoleLvs[5][52]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5600},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 6.1,   --冲刺时间,单位：秒
        magnetTime = 6.1,   --磁铁时间,单位：秒
        giantTime = 6.1,   --巨人时间,单位：秒
        transTime=6.1,     --转换时间 (s)
        cloudTime=6.1,     --浮云时间(s)
    }	
RoleLvs[5][53]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5700},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 6.2,   --冲刺时间,单位：秒
        magnetTime = 6.2,   --磁铁时间,单位：秒
        giantTime = 6.2,   --巨人时间,单位：秒
        transTime=6.2,     --转换时间 (s)
        cloudTime=6.2,     --浮云时间(s)
    }	
RoleLvs[5][54]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5800},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 6.3,   --冲刺时间,单位：秒
        magnetTime = 6.3,   --磁铁时间,单位：秒
        giantTime = 6.3,   --巨人时间,单位：秒
        transTime=6.3,     --转换时间 (s)
        cloudTime=6.3,     --浮云时间(s)
    }		
RoleLvs[5][55]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 5900},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 6.4,   --冲刺时间,单位：秒
        magnetTime = 6.4,   --磁铁时间,单位：秒
        giantTime = 6.4,   --巨人时间,单位：秒
        transTime=6.4,     --转换时间 (s)
        cloudTime=6.4,     --浮云时间(s)
    }		
RoleLvs[5][56]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 6000},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 6.5,   --冲刺时间,单位：秒
        magnetTime = 6.5,   --磁铁时间,单位：秒
        giantTime = 6.5,   --巨人时间,单位：秒
        transTime=6.5,     --转换时间 (s)
        cloudTime=6.5,     --浮云时间(s)
    }		
RoleLvs[5][57]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 6100},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 6.6,   --冲刺时间,单位：秒
        magnetTime = 6.6,   --磁铁时间,单位：秒
        giantTime = 6.6,   --巨人时间,单位：秒
        transTime=6.6,     --转换时间 (s)
        cloudTime=6.6,     --浮云时间(s)
    }	
RoleLvs[5][58]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 6200},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 6.7,   --冲刺时间,单位：秒
        magnetTime = 6.7,   --磁铁时间,单位：秒
        giantTime = 6.7,   --巨人时间,单位：秒
        transTime=6.7,     --转换时间 (s)
        cloudTime=6.7,     --浮云时间(s)
    }		
RoleLvs[5][59]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 6300},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 6.8,   --冲刺时间,单位：秒
        magnetTime = 6.8,   --磁铁时间,单位：秒
        giantTime = 6.8,   --巨人时间,单位：秒
        transTime=6.8,     --转换时间 (s)
        cloudTime=6.8,     --浮云时间(s)
    }
RoleLvs[5][60]=
    {
        --升级需求(type为升级花费的类型，金币或钻石，num为数值)
        upgrade = {type = UPGRADE_TYPE.Gold,Num = 6400},
        --分数加成百分比
        scoreRate = 1,
        --金币分数加成百分比
        coinRate = 5,
        --被动技能时间加成
        sprintTime = 6.9,   --冲刺时间,单位：秒
        magnetTime = 6.9,   --磁铁时间,单位：秒
        giantTime = 6.9,   --巨人时间,单位：秒
        transTime=6.9,     --转换时间 (s)
        cloudTime=6.9,     --浮云时间(s)
    }		
