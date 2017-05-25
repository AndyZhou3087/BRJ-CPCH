--[[
    角色身上的buff类
]]
local BuffState = class("BuffState")

function BuffState:ctor(_params)
    self.m_type = _params.type
    self.m_time = _params.time
end

--获取buff类型
function BuffState:getType()
    return self.m_type
end

return BuffState
