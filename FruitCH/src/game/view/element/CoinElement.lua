--[[
金币元素
]]
local BaseElement = require("game.view.element.BaseElement")
local CoinElement=class("CoinElement",BaseElement)

local PhysicSprite=require("game.custom.PhysicSprite")  

local Scheduler = require("framework.scheduler")

function CoinElement:ctor(parm)
    CoinElement.super.ctor(self)
    
    self.m_type = parm.type
    
    self.m_img = PhysicSprite.new("Common/"..parm.res):addTo(self)
    self:setAnchorPoint(cc.p(0,0))
    self.m_img:setAnchorPoint(cc.p(0,0))
    self.m_size = self.m_img:getCascadeBoundingBox().size

    self.m_isAttract=false   --是否被吸引
    self.m_group = 0
    
    self.moveHandler = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),FrameTime)
end

function CoinElement:getSize()
    return self.m_size
end

function CoinElement:onEnterFrame()
    local _x,_y = self:getPosition()
    self:setPosition(_x-MoveSpeed*0.1,_y)
    if self:getPositionX()<=display.right and self.m_type ~= Coin_Type.Coin_Gold then
    	if GameController.isInState(PLAYER_STATE.TransformGold) and not self.m_trans then
    	   self.m_trans = true
           local old = self.m_img
           self.m_img = PhysicSprite.new("Common/Common_gold.png"):addTo(self)
           old:removeFromParent()
    	end
        if not GameController.isInState(PLAYER_STATE.TransformGold) then
            self.m_trans = false
    	end
    end
    if self:getPositionX()<=-self:getSize().width then
        if not tolua.isnull(self) then
            self:dispose()
        end
    end
end

--被碰触
function CoinElement:collision()
    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.GetGold_Sound)
    if GameController.isInState(PLAYER_STATE.TransformGold) then
    	GameDataManager.addLevelCoin(3)
        self:dispose()
        return
    end

    if self.m_type == Coin_Type.Coin_Copper then
        GameDataManager.addLevelCoin(1)
    elseif self.m_type == Coin_Type.Coin_Silver then
        GameDataManager.addLevelCoin(2)
    else
        GameDataManager.addLevelCoin(3)
    end
    GameDataManager.addCurrencyCount(self.m_type,1)

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