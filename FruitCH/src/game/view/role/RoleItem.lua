--[[
角色被动技能
]]
local RoleItem = class("RoleItem",function()
    return display.newNode()
end)

function RoleItem:ctor(config)
    
    self:initContent(config)

end

--加载item
function RoleItem:initContent(config)
    local content = cc.uiloader:load("json/RoleItem.json")
    self:addChild(content)
    content:setScale(display.right/GroupSize.width)
    content:setPosition(cc.p(0,0))

    local img = cc.uiloader:seekNodeByName(content,"Image_13")
    --图片
    self.ItemFrame = cc.uiloader:seekNodeByName(content,"ImgBtn")
    self.ItemFrame:setTouchSwallowEnabled(false)
    self.ItemFrame:setButtonEnabled(false)
    self.ItemFrame:setButtonImage("disabled",config.res)

    --名字
    self.Describe = cc.uiloader:seekNodeByName(content,"LabelName")
    self.Describe:setString(config.discrebe)
    --进度条
    local fill = display.newSprite("Common/Common_slider_f.png")
    self.process = display.newProgressTimer(fill, display.PROGRESS_TIMER_BAR):addTo(img)
    self.process:setMidpoint(cc.p(0, 0.5))
    self.process:setBarChangeRate(cc.p(1,0))
    self.process:setPosition(img:getContentSize().width/2, img:getContentSize().height/2)
    self.process:setPercentage(0)
--    self.process = cc.ui.UILoadingBar.new({
--        scale9 = true,
--        capInsets = cc.rect(0,0,10,10), -- scale region
--        image =  "Common/Common_slider_f.png", -- loading bar image
--        viewRect = cc.rect(0,0,298,22), -- set loading bar rect
--        percent = 30, -- set loading bar percent
--        direction = 0
--    }):addTo(img)
end

function RoleItem:updateData(config)
    self.ItemFrame:setButtonImage("disabled",config.res)
    self.Describe:setString(config.discrebe)
end

function RoleItem:updateProcess(pro)
--    Tools.printDebug("---------------进度：",pro*100)
    local tage = self.process:getPercentage()
    local to1 = cc.ProgressTo:create(0.5, pro*100)
    local to2 = cc.Sequence:create(to1,cc.CallFunc:create(function()
        self.process:setPercentage(pro*100)
    end))
    self.process:runAction(to2)
end

return RoleItem