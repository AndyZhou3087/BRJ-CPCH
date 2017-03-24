--[[
    用于绑定刚体的精灵
]]

local PhysicSprite = class("PhysicSprite",function(filename, x, y, params)
    return display.newSprite(filename,x, y, params)
end)

PhysicSprite.Counterforce_Left = 1      --左向反作用力
PhysicSprite.Counterforce_Right = 2     --右向反作用力

function PhysicSprite:ctor(parameters)

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

--销毁刚体
function PhysicSprite:dispose(_body)

    local _body = self:getPhysicsBody()
    if _body then
    	_body:removeFromWorld()
    end
    self:removeAllChildren()
    self:removeFromParent(true)
end

return PhysicSprite
