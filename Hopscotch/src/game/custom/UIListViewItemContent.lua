--[[
    针对UIListView一行不能添加多列条目，在此封装了一个行容器
]]
local UIListViewItemContent = class("UIListViewItemContent",function()
	return display.newNode()
end)

function UIListViewItemContent:ctor()
    self.m_childs_ = {}
--    self.getContentSize = self.getCascadeBoundingBox
end

function UIListViewItemContent:addChild(_displayObj,_zOrder)
    if _displayObj then
        _zOrder = _zOrder or 0
--        local idx = #self.m_childs_+1
--        if idx == 3 then
--        	print("cao cao cao cao")
--        end
        self.m_childs_[#self.m_childs_+1] = _displayObj
        getmetatable(self).addChild(self,_displayObj,_zOrder)
    else
        print("chjh error UIListViewItemContent:addChild the param must not be nil")
    end
end

function UIListViewItemContent:executeTouchFunc(_point,_item)
    local itemW,itemH = _item:getItemSize()
    local contentX,contentY = self:getPosition()
    local contentSize = self:getContentSize()
--    printf("chjh cur click _item.size=(%f,%f),self.rect=(%f,%f,%f,%f)",itemW,itemH,contentX,contentY,contentSize.width,contentSize.height)
    for var=1, #self.m_childs_ do
        local childVo = self.m_childs_[var]
--        local childAnchor = childVo:getAnchorPoint()
        local childSize = childVo:getContentSize()
--        printf("chjh cur click point=(%f,%f),childs[%d].point=(%f,%f),size=(%f,%f),anchorP=(%f,%f)",_point.x,_point.y,var,childVo:getPositionX(),childVo:getPositionY(),childSize.width,childSize.height,childAnchor.x,childAnchor.y)
        if childVo.onClicked and iskindof(childVo,"UIListViewBaseItem") then
            local rect = cc.rect(childVo:getPositionX()+(contentX-contentSize.width*0.5), childVo:getPositionY(), childSize.width, childSize.height)
            if cc.rectContainsPoint(rect,_point) then
                childVo:onClicked()
                break
            end
        end
    end
end

return UIListViewItemContent