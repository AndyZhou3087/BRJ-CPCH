--[[生物活体类]]
local Scheduler = require("framework.scheduler")
local BaseElement = require("game.view.element.BaseElement")
local LiveThing = class("LiveThing", BaseElement)

function LiveThing:ctor(_params)
    LiveThing.super.ctor(self,_params)
  --  self:setAnchorPoint(cc.p(0,0))
end

--加载模型
function LiveThing:initModel()
    local curArmatureObj = ARMATURE[self.m_modelId]
    Tools.printDebug("模型 id="..self.m_modelId)
    if nil == curArmatureObj then
        Tools.printDebug("找不到模型 id="..self.m_modelId)
        return
    end
    self.m_armatureName = curArmatureObj.name
    self.m_armaturePath = curArmatureObj.path

    self:setDirect(self.m_direct)
    self.m_armature:getAnimation():play(self.m_state)
end

--设置生物姿势
function LiveThing:setState(_state)
    if self.m_state == _state then
        return
    end
    self.m_state = _state
    if self.m_armature ~= nil then
        local temp = self.m_armature;
        self.m_armature:getAnimation():play(self.m_state)
    end
end

--得到生物体姿势
function LiveThing:getState()
    return self.m_state
end

--刷新生物
function LiveThing:update()

end

--销毁生物
function LiveThing:dispose()
    self:removeFromParent(true)
end

--得到生物体大小
function LiveThing:getSize()
    if self.m_armature then
        return self.m_armature:getContentSize()
    else
        return cc.size(0,0)
    end
end

return LiveThing
