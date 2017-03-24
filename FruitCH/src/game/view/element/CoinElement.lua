--[[
金币元素
]]
local BaseElement = require("game.view.element.BaseElement")
local CoinElement=class("CoinElement",BaseElement)

local PhysicSprite=require("game.custom.PhysicSprite")
local Special_MATERIAL=cc.PhysicsMaterial(0,0,0)    

local Scheduler = require("framework.scheduler")

function CoinElement:ctor(parm)
    CoinElement.super.ctor(self)
    
    self.m_type = parm.type
    
    self.m_img = PhysicSprite.new(parm.res):addTo(self)
    self.m_size = self.m_img:getCascadeBoundingBox().size
    self:addBody()

    self.m_isAttract=false   --是否被吸引
    self.m_group = 0
    
end

function CoinElement:addBody(parameters)
    self.m_body=cc.PhysicsBody:createBox(self.m_size,Special_MATERIAL)
    self.m_body:setCategoryBitmask(0x1111)
    self.m_body:setContactTestBitmask(0x1111)
    self.m_body:setCollisionBitmask(0x0000)
    self.m_body:setDynamic(false)
    self.m_body:setTag(ELEMENT_TAG.GOLD_TAG)
    self:setPhysicsBody(self.m_body)
end

function CoinElement:getSize()
    return self.m_size
end

--被碰触
function CoinElement:collision()
--    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Gold_Sound)
    if self.m_type == Coin_Type.Coin_Copper then
        GameDataManager.addLevelCoin(1)
    elseif self.m_type == Coin_Type.Coin_Silver then
        GameDataManager.addLevelCoin(2)
    else
        GameDataManager.addLevelCoin(3)
    end
    GameDataManager.addCurrencyCount(self.m_type,1)
     --关卡获得金币 
    self:dispose()
end

--设置金币金额
function CoinElement:setCoinType(_type)
    self.m_type = _type
end

--是否被吸引
function CoinElement:isAttract()
    return self.m_isAttract
end

--设置吸引金币的目标
function CoinElement:setAttract(target)
    self.m_isAttract=true   
    self.m_target=target
end

--获取吸引金币的对象
function CoinElement:getTarget(parameters)
    return self.m_target    
end

--设置所属组
function CoinElement:setGroup(_group)
    self.m_group = _group
end
function CoinElement:getGroup()
    return self.m_group
end

--缓存时用于判断是否已经销毁
function CoinElement:isDisposed()
    return self.m_isDisposed
end

function CoinElement:dispose(parameters)
 
    if self.m_isDisposed then
        return
    end
    self.m_isDisposed = true
    
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
    
    self.m_isAttract = false
    self.m_target = nil
    self.m_group = 0
    self.super.dispose(self)
    
    if self.m_chaceType then
        PoolManager.putCacheObjByType(self.m_chaceType,self)
    end 
end

return CoinElement