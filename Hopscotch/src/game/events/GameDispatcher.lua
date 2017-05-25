local GameDispatcher = class("GameDispatcher")

function GameDispatcher:ctor()
    cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
    self.m_listenerTags_={}
end

function GameDispatcher:getInstance()
    local instance = _G.GameDispatcher
    if instance then
        return instance
    end
    instance = GameDispatcher.new()
    _G.GameDispatcher = instance
    return instance
end

--[[
派发事件
]]
function GameDispatcher:dispatch(_eventName,_params)
    self:dispatchEvent({name=_eventName,data=_params})
end

--[[
监听事件
]]
function GameDispatcher:addListener(_eventName,_listener,_tag)
    return self:addEventListener(_eventName,_listener,_tag)
--    local _handle = self:addEventListener(_eventName,_listener,_tag)
--    self.m_handles_[_eventName] = _handle
end

--[[
根据事件名移除事件监听
]]
function GameDispatcher:removeListenerByName(_eventName)
    self:removeEventListenersByEvent(_eventName)
end

--[[
根据handle标识移除事件监听
]]
function GameDispatcher:removeListenerByHandle(_handle)
    self:removeEventListener(_handle)
end

--[[
根据事件Tag除事件监听
]]
function GameDispatcher:removeListenerByTag(_tag)
    self:removeEventListenersByTag(_tag)
end

return GameDispatcher