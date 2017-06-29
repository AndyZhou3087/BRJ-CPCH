--[[
金币元素
]]
local BaseElement = require("game.view.element.BaseElement")
local CoinElement=class("CoinElement",BaseElement)

local PhysicSprite=require("game.custom.PhysicSprite")  

function CoinElement:ctor(parm)
    CoinElement.super.ctor(self)
    
    self.m_img = display.newSprite(parm.res):addTo(self)
    self.m_img:setAnchorPoint(cc.p(0,0))
    self.m_size = self.m_img:getCascadeBoundingBox().size

    self.m_isAttract=false   --是否被吸引
    self.m_group = 0
end

function CoinElement:getSize()
    return self.m_size
end

--被碰触
function CoinElement:collision()
--    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.GetGold_Sound)
    GameDataManager.addDiamond(1)
    GameDataManager.addGameDiamond(1)
    
    self:dispose()
end


--设置金币类型
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
    
    self.m_trans = nil
    
    self.m_isAttract = false
    self.m_target = nil
    self.m_group = 0
    
    self.super.dispose(self)
    
    if self.m_chaceType then
        PoolManager.putCacheObjByType(self.m_chaceType,self)
    end
end

return CoinElement