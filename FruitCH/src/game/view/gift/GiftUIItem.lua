--[[
商店内容
]]
local GiftUIItem = class("GiftUIItem",function()
    return display.newNode()
end)

function GiftUIItem:ctor(parm)

    --启用onCleanup函数
    self:setNodeEventEnabled(true)

    local content = cc.uiloader:load("json/GiftUIItem.json")
    self:addChild(content)
    content:setPosition(cc.p(0,0))
    
    local icon = cc.uiloader:seekNodeByName(content,"icon")
    icon:setButtonEnabled(false)
    if parm.res then
        icon:setButtonImage("disabled",parm.res)
    end
    
    local count = cc.uiloader:seekNodeByName(content,"count")
    count:setString("x"..parm.count)

end

function GiftUIItem:onCleanup(parameters)
end

function GiftUIItem:toClose(_clean)
    self:removeFromParent(_clean)
end

return GiftUIItem