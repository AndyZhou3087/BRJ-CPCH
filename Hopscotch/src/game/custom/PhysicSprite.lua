--[[
    用于绑定刚体的精灵
]]

local PhysicSprite = class("PhysicSprite",function(filename, x, y, params)
    return display.newSprite(filename,x, y, params)
end)

PhysicSprite.Counterforce_Left = 1      --左向反作用力
PhysicSprite.Counterforce_Right = 2     --右向反作用力

function PhysicSprite:ctor(parameters)
	self.m_direction = 0
	self.m_isDestroy=false    --是否待销毁
	self.m_pre = nil
    self.m_behind = nil
    self.m_up = nil
end


function PhysicSprite:setDestroy(_enable)
    self.m_isDestroy=_enable
end

function PhysicSprite:isDestroy(parameters)
	return self.m_isDestroy
end

--碰撞
function PhysicSprite:collision()
    self:dispose()
end

function PhysicSprite:getSize()
	return self.m_size
end

function PhysicSprite:setSize(size)
    self.m_size=size	
end

--设置缓存标识
function PhysicSprite:setCahceType(_type)
    self.m_chaceType = _type
end
--添加是否已经移除显示列表标识，（由于缓存remove后还存在，故加此标识）
function PhysicSprite:setDisposed(_enable)
    self.m_isDisposed = _enable
end

--销毁刚体
function PhysicSprite:dispose(_body)
    if self.m_isDisposed then
    	return
    end
    
    self.m_isDisposed = true
    if not tolua.isnull(self.m_pre) then
    	self.m_pre.m_behind = nil
    end
    if not tolua.isnull(self.m_behind) then
    	self.m_behind.m_pre = nil
    end
    self.m_direction = 0
    self.m_isDestroy=false    --是否待销毁
    self.m_pre = nil
    self.m_behind = nil
    self.m_up = nil
    local _body = self:getPhysicsBody()
    if _body then
    	_body:removeFromWorld()
    end
    self:removeAllChildren()
    self:removeFromParent(true)
    
    if self.m_chaceType then
        PoolManager.putCacheObjByType(self.m_chaceType,self)
    end
end

return PhysicSprite
