--[[
背景移动
]]
local BackGroundMove = class("BackGroundMove", function()
    return display.newNode()
end)

local Scheduler = require("framework.scheduler")

--parm@1:传入的图片名称
--parm@2:横向or竖向移动:0横向，1竖向
--parm@3:移动速度
function BackGroundMove:ctor(_string,_dis,_speed)
    self.m_speed = _speed
    self.m_dis = _dis
    self.isFresh = false
    self.isFresh2 = false

    
    self.bg_1 = display.newSprite(_string):addTo(self)
    self.m_size = self.bg_1:getCascadeBoundingBox().size
    self.bg_1:setAnchorPoint(cc.p(0,0))
    self.bg_1:setPosition(cc.p(0,0))

    self.bg_2 = display.newSprite(_string):addTo(self)
    self.bg_2:setAnchorPoint(cc.p(0,0))
    
    if _dis == 0 then
        self.bg_2:setPosition(cc.p(self.m_size.width,0))
    else
        self.bg_2:setPosition(cc.p(0,self.m_size.height))
    end
    
    self.m_timer = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),FrameTime)

end

function BackGroundMove:onEnterFrame(dt)
    if self.m_dis == 0 then
        self:horupdate()
    else
        self:update()
    end
end

function BackGroundMove:update(parameters)
    
    if not tolua.isnull(self.bg_1) and not tolua.isnull(self.bg_2) then
        local x,y = self.bg_1:getPosition()
        local xx,yy = self.bg_2:getPosition()
        self.bg_1:setPosition(x,y-MoveSpeed*0.1)
        self.bg_2:setPosition(xx,yy-MoveSpeed*0.1)
        if y<=-self.m_size.height then
            if self.isFresh then
                self.isFresh = false
                self:createSprite1(self.m_res)
            end
            self.bg_1:setPosition(x,self.m_size.height+self.bg_2:getPositionY())
        end
        if yy<=-self.m_size.height then
            if self.isFresh2 then
                self.isFresh2 = false
                self:createSprite2(self.m_res)
            end
            self.bg_2:setPosition(xx,self.m_size.height+self.bg_1:getPositionY())
        end

        if not self.isFresh2 and not self.isFresh then
            if not tolua.isnull(self.m_excessive) then
                self.m_excessive:removeFromParent()
                self.m_excessive = nil
            end
        end
    end

end

function BackGroundMove:setReFresh(_res,_enable)
	self.m_res = _res
	self.isFresh = _enable
	self.isFresh2 = _enable
end

function BackGroundMove:createSprite1(_res)
    local old = self.bg_1
--    self.bg_1 = display.newSprite(_res):addTo(self)
--    self.bg_1:setAnchorPoint(cc.p(0,0))
    if _res == DistanceC.bgRes then
        self.m_bg1:setVisible(true)
        self.bg_1 = self.m_bg1
    elseif _res == DistanceB.bgRes then
        self.m_bg2:setVisible(true)
        self.bg_1 = self.m_bg2
    elseif _res == DistanceA.bgRes then
        self.m_bg3:setVisible(true)
        self.bg_1 = self.m_bg3
    elseif _res == DistanceS.bgRes then
        self.m_bg4:setVisible(true)
        self.bg_1 = self.m_bg4
    end
    old:removeFromParent()
    
    self.bg_1:setLocalZOrder(1)
    self.bg_2:setLocalZOrder(0)
    
end

function BackGroundMove:createSprite2(_res)

    local old = self.bg_2
--    self.bg_2 = display.newSprite(_res):addTo(self)
--    self.bg_2:setAnchorPoint(cc.p(0,0))
    if _res == DistanceC.bgRes then
        self.m_bgg1:setVisible(true)
        self.bg_2 = self.m_bgg1
    elseif _res == DistanceB.bgRes then
        self.m_bgg2:setVisible(true)
        self.bg_2 = self.m_bgg2
    elseif _res == DistanceA.bgRes then
        self.m_bgg3:setVisible(true)
        self.bg_2 = self.m_bgg3
    elseif _res == DistanceS.bgRes then
        self.m_bgg4:setVisible(true)
        self.bg_2 = self.m_bgg4
    end
    old:removeFromParent()

    self.bg_1:setLocalZOrder(0)
    self.bg_2:setLocalZOrder(1)
    
end

function BackGroundMove:horupdate(parameters)
    local x,y = self.bg_1:getPosition()
    local xx,yy = self.bg_2:getPosition()
    self.bg_1:setPosition(x-MoveSpeed*0.1,y)
    self.bg_2:setPosition(xx-MoveSpeed*0.1,yy)
    if x<=-self.m_size.width then
        self.bg_1:setPosition(self.m_size.width+self.bg_2:getPositionX(),y)
    end
    if xx<=-self.m_size.width then
        self.bg_2:setPosition(self.m_size.width+self.bg_1:getPositionX(),yy)
    end

end

function BackGroundMove:onEnter()
end

function BackGroundMove:onExit()
end

function BackGroundMove:stopUpdate(parameters)
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
end

function BackGroundMove:startUpdate(parameters)
    self.m_timer = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),FrameTime)
end

function BackGroundMove:dispose()
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
    
end

return BackGroundMove
