--[[
    道具元素
]]
local BaseElement = require("game.view.element.BaseElement")
local GoodsElement=class("GoodsElement",BaseElement)    

local PhysicSprite=require("game.custom.PhysicSprite")
local Special_MATERIAL=cc.PhysicsMaterial(0,0,0)


function GoodsElement:ctor(_id)
    GoodsElement.super.ctor(self,_id)
    self.m_goodsCon = GoodsConfig[_id]
    self.m_goodsId = _id
     
    self.m_isAttract=false
    self.m_isRetain=false
    
    --特效
--    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("effect/daoju0.png", "effect/daoju0.plist" , "effect/daoju.ExportJson" )
--    local effect = ccs.Armature:create("daoju")
--    self:addChild(effect)
--    effect:getAnimation():playWithIndex(0)
--    effect=cc.POSITION_TYPE_GROUPED
    self.m_img = PhysicSprite.new(self.m_goodsCon.res):addTo(self)
    self.m_img:setAnchorPoint(cc.p(0,0))
    self:addBody(cc.p(20,25))

end  

function GoodsElement:addBody(_offset)
    local size=self.m_img:getCascadeBoundingBox()
    self.m_body=cc.PhysicsBody:createBox(size,Special_MATERIAL,_offset)
    self.m_body:setCategoryBitmask(0x1111)
    self.m_body:setContactTestBitmask(0x1111)
    self.m_body:setCollisionBitmask(0x0000)
    self.m_body:setDynamic(false)
    self.m_body:setTag(ELEMENT_TAG.GOOD_TAG)
    self:setPhysicsBody(self.m_body)
end

--是否被吸引
function GoodsElement:isAttract()
    return self.m_isAttract
end

--设置吸引金币的目标
function GoodsElement:setAttract(target)
    self.m_isAttract=true   
    self.m_target=target
end

function GoodsElement:setRetain()
    if self.m_isRetain==false then
      self.m_isRetain=true
      self:retain()
    end   
end

--获取吸引金币的对象
function GoodsElement:getTarget(parameters)
    return self.m_target    
end

--被碰触
function GoodsElement:collision(_isAtracted)
--    AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Prop_Sound)
    GameDataManager.useGoodsExp(self.m_goodsId)

    self:dispose()
end

function GoodsElement:dispose(parameters)
    self.super.dispose(self)
end

return GoodsElement