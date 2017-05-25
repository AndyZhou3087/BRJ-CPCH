--[[
    地图元素基类
]]
local BaseElement = class("BaseElement", function()
    return display.newNode()
end)

--
function BaseElement:ctor(_params)
	
end

--被碰触
function BaseElement:collision()
end

--设置缓存标识
function BaseElement:setCahceType(_type)
    self.m_chaceType = _type
end
--添加是否已经移除显示列表标识，（由于缓存remove后还存在，故加此标识）
function BaseElement:setDisposed(_enable)
    self.m_isDisposed = _enable
end

--销毁
function BaseElement:dispose()
    if self.m_body then
        self.m_body:removeFromWorld()
    end
    self:removeFromParent(true)
end

return BaseElement