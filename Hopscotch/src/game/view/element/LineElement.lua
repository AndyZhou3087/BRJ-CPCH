--[[
特殊楼层钢架元素
]]
local BaseElement = require("game.view.element.BaseElement")
local LineElement=class("LineElement",BaseElement)    

local PhysicSprite=require("game.custom.PhysicSprite")


function LineElement:ctor(arr)
    LineElement.super.ctor(self)

    self.arrMove = arr
    self.moveCount = 1
    --钢架线
    self.line_1 = PhysicSprite.new("#Special_line.png"):addTo(self)
    self.line_2 = PhysicSprite.new("#Special_line.png"):addTo(self)
    self.line_1:setAnchorPoint(cc.p(0,1))
    self.line_2:setAnchorPoint(cc.p(0,1))
    self.line_2:setPositionX(50)
    
    local shake = cc.RotateTo:create(1.5,-4)
    local shake2 = cc.RotateTo:create(1.5,4)
    local seq = cc.Sequence:create(shake,shake2)
    local repeat1 = cc.RepeatForever:create(seq)
    self.line_1:runAction(repeat1)
    
    local shake = cc.RotateTo:create(1.5,-4)
    local shake2 = cc.RotateTo:create(1.5,4)
    local seq = cc.Sequence:create(shake,shake2)
    local repeat2 = cc.RepeatForever:create(seq)
    self.line_2:runAction(repeat2)
    
end

function LineElement:moveUp()
    if self.moveCount == #self.arrMove then
        return
    end
    self:stopAllActions()
    self.moveCount = self.moveCount + 1
    local scale = 8.5-(self.arrMove[self.moveCount]-1)
    local toScale = cc.ScaleTo:create(0.2,self:getScaleX(),scale)
    self:runAction(toScale)
end

function LineElement:dispose()
    self:stopAllActions()
    self.super.dispose(self)
end

return LineElement