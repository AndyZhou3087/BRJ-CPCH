--[[
商店内容
]]
local ShopItem = class("ShopItem",function()
    return display.newNode()
end)

function ShopItem:ctor(type,id)

    self.m_type = type
    self.id = id
    
    --启用onCleanup函数
    self:setNodeEventEnabled(true)

    if self.m_type == Shop_Type.role then
        self:initRole()
    elseif self.m_type == Shop_Type.scene then
        self:initScene()
    elseif self.m_type == Shop_Type.diamond then
        self:initDiamond()
    end

end

--角色item
function ShopItem:initRole(parameters)
    --动画 
    if self.id == 0 then
        self.img = display.newSprite("role/role_1.png")
        self.img:setVisible(false)
    else
        self.img = display.newSprite(RoleConfig[self.id].roleImg)
        local animation = cc.AnimationCache:getInstance():getAnimation(RoleConfig[self.id].armatureName)
        local animate = cc.Animate:create(animation)
        self.img:runAction(cc.RepeatForever:create(animate))
        if GameDataManager.getRoleModle(self.id) then
            self.img:setColor(cc.c3b(255,255,255))
        else
            self.img:setColor(cc.c3b(0,0,0))
        end
    end
    self:addChild(self.img)
    self.img:setAnchorPoint(cc.p(0.5,0.5))
    self.img:setPosition(cc.p(0,0))
end

--场景item
function ShopItem:initScene(parameters)
    if self.id == 0 then
        self.img = display.newSprite("shop/scene_1.png")
        self.img:setVisible(false)
    else
        self.img = display.newSprite(SceneConfig[self.id].sceneIcon)
        if GameDataManager.getSceneModle(self.id) then
            self.img:setColor(cc.c3b(255,255,255))
        else
            self.img:setColor(cc.c3b(0,0,0))
        end
    end
    self:addChild(self.img)
    self.img:setAnchorPoint(cc.p(0.5,0.5))
    self.img:setPosition(cc.p(0,0))
end

--钻石item
function ShopItem:initDiamond(parameters)
    if self.id == 0 then
        self.img = display.newSprite("shop/diamond_1.png")
        self.img:setVisible(false)
    else
        self.img = display.newSprite(DiamondConfig[self.id].res)
    end
    self:addChild(self.img)
    self.img:setAnchorPoint(cc.p(0.5,0.5))
    self.img:setPosition(cc.p(0,0))
end

function ShopItem:getShopTypeID()
    return self.id
end

function ShopItem:updateSelf(parameters)
    self.img:setColor(cc.c3b(255,255,255))
end

function ShopItem:onCleanup(parameters)

end

function ShopItem:toClose(_clean)
    self:removeFromParent(_clean)
end

return ShopItem