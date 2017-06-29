--[[
    自定义滑动列表控件
    1.支持UIListView所有功能
    2.额外增加让条目滑动后始终显示全部功能
    3.额外增加当条目滑过指定区域时发生放大缩小变化，调用enableAreaChange()方法即可开启
 author:chjh0540237
]]
local c = cc
local UIScrollView = cc.ui.UIScrollView
local CustomListView = class("CustomListView",cc.ui.UIListView)

--设置滑动中指定区域内有放大缩小过渡变化
--_scaleEnable:滑动区域是否缩放
--_areaParam:{point=xxx,areaValue=xxx,scaleRate=xxx}
--若滑动列表为横向,则 point 代表X轴的该点以areaValue 为 区域的中心点来作条目在该区域变化判断
--若滑动列表为竖向,则 point 代表Y轴的该点以areaValue 为 区域的中心点来作条目在该区域变化判断
--scaleRate滑动条目缩放比例，可以不填
--不传参数则取当前列表大小中心位置
function CustomListView:enableAreaChange(_scaleEnable,_areaParam)
    self.m_isAreaEnabled_ = true
    self.m_area_ = _areaParam
    self.m_rate_ = 1
    self.m_isScale_ = _scaleEnable or false
    return self
end

function CustomListView:autoFixScroll()
    if UIScrollView.DIRECTION_VERTICAL == self.direction then
        self:autoFixY()
    else
        self:autoFixX()
    end
end

--横向滑动时，使条目显示全
function CustomListView:autoFixX()
    local item, pos = self:getFirstVisibleItem()
    local bound = item:getBoundingBox()
    local nodePoint = self.container:convertToWorldSpace(
        c.p(bound.x + bound.width/2, bound.y))
    local index
    local _rect=self:getViewRectInWorldSpace()
    if c.rectContainsPoint(_rect, nodePoint) then
        index = pos
    else
        index = pos + 1
    end
    local toItem = self.items_[index]
    bound = toItem:getBoundingBox()
    self:scrollToPos(-bound.x + self.viewRect_.x, 0)
end
--竖向滑动时，使条目显示全
function CustomListView:autoFixY()
    local item, pos = self:getFirstVisibleItem()
    local bound = item:getBoundingBox()
    local nodePoint = self.container:convertToWorldSpace(
        c.p(bound.x, bound.y+bound.height*0.5))
    local index
    local _rect=self:getViewRectInWorldSpace()
    if c.rectContainsPoint(_rect, nodePoint) then
        index = pos
    else
        index = pos + 1
    end
    local toItem = self.items_[index]
    bound = toItem:getBoundingBox()
    self:scrollToPos(0, -bound.y-bound.height+self.viewRect_.height+self.viewRect_.y)
end
 
function CustomListView:getFirstVisibleItem()
    for i=1,#self.items_ do
        if self:isItemInViewRect(self.items_[i]) then
            return self.items_[i], i
        end
    end
end
 
function CustomListView:scrollToPos(x, y)
--    local scrollLength = c.pGetLength(c.pSub(c.p(x, y), self.position_))
    self.position_ = c.p(x, y)
    local action = c.MoveTo:create(0.5, self.position_)
    self.scrollNode:runAction(transition.sequence({c.EaseExponentialOut:create(action),
        c.CallFunc:create(function()
            if self.m_isAreaEnabled_ then
                local _item,_index = self:getScaledItem_()
                self:callListener_{name = "scrollStop",item=_item,pos=_index}
            end
        end)
    }))
    self:scrollChange(x,y)
--    self.scrollNode:runAction(c.EaseElasticOut:create(action))
end
 
function CustomListView:getAllItem()
    return self.items_
end
 
function CustomListView:getFirstItem()
    return self.items_[1]
end
 
function CustomListView:getLastItem()
    return self.items_[#self.items_]
end
-- override
function CustomListView:onTouch_(event)
    if "began" == event.name and not self:isTouchInViewRect(event) then
        printInfo("UIScrollView - touch didn't in viewRect")
        return false
    end
 
    if "began" == event.name and self.touchOnContent then
        local cascadeBound = self.scrollNode:getCascadeBoundingBox()
        if not cc.rectContainsPoint(cascadeBound, cc.p(event.x, event.y)) then
            return false
        end
    end
 
    if "began" == event.name then
        self.prevX_ = event.x
        self.prevY_ = event.y
        self.bDrag_ = false
        local x,y = self.scrollNode:getPosition()
        self.position_ = {x = x, y = y}
 
        transition.stopTarget(self.scrollNode)
        self:callListener_{name = "began", x = event.x, y = event.y}
 
        self:enableScrollBar()
        -- self:changeViewRectToNodeSpaceIf()
 
        self.scaleToWorldSpace_ = self:scaleToParent_()
 
        return true
    elseif "moved" == event.name then
        if self:isShake(event) then
            return
        end
 
        self.bDrag_ = true
        self.speed.x = event.x - event.prevX
        self.speed.y = event.y - event.prevY
 
        if self.direction == UIScrollView.DIRECTION_VERTICAL then
            self.speed.x = 0
        elseif self.direction == UIScrollView.DIRECTION_HORIZONTAL then
            self.speed.y = 0
        else
            -- do nothing
        end
 
        self:scrollBy(self.speed.x, self.speed.y)
        self:scrollChange()
        self:callListener_{name = "moved", x = event.x, y = event.y}
    elseif "ended" == event.name then
        if self.bDrag_ then
            self.bDrag_ = false
            self:scrollAuto()
         -- self:autoFixScroll()
            self:callListener_{name = "ended", x = event.x, y = event.y}
 
            self:disableScrollBar()
        else
            self:callListener_{name = "clicked", x = event.x, y = event.y}
        end
    end
end

 --滚动变化
function CustomListView:scrollChange(x,y)
    if not self.m_isAreaEnabled_ then
    	return
    end
    local scrollX,scrollY = x or self:getScrollNode():getPositionX(),y or self:getScrollNode():getPositionY()
--    printf("当前正在滚动 scrollNode.pos=(%f,%f)",scrollX,scrollY)
    local line  -- = self.viewRect_.width*0.5
    local min,max -- = lineX-80,lineX+80
    local bound
    local _w,_h = self.items_[1]:getItemSize()
    local item
    
    if UIScrollView.DIRECTION_VERTICAL == self.direction then
        if self.m_area_ then
        	line = self.m_area_.point or self.viewRect_.height*0.5
        	_h = self.m_area_.areaValue or _h
            self.m_rate_ = self.m_area_.scaleRate or 1
        else
            line = self.viewRect_.height*0.5
        end
        min,max = line-_h*0.5,line+_h*0.5
        for i=1,#self.items_ do
            item = self.items_[i] 
            local _x,_y = item:getPosition()
            bound = {x=_x,y=_y-self.viewRect_.y,width=_w,height=_h}
            local cury = bound.y+bound.height*0.5+scrollY
            if cury>min and cury<=line then
                if self.m_isScale_ then
                    self.items_[i]:getContent():setScale(cury/min*self.m_rate_)
                end
                item._isScaled = true
                item:setLocalZOrder(1)
            elseif cury>line and cury<max then
                if self.m_isScale_ then
                    self.items_[i]:getContent():setScale((line-(cury-line))/min*self.m_rate_)
                end
                item._isScaled = true
                item:setLocalZOrder(1)
            else
                self.items_[i]:getContent():setScale(1)
                item._isScaled = false
                item:setLocalZOrder(0)
            end
        end
    else
        if self.m_area_ then
            line = self.m_area_.point or self.viewRect_.width*0.5
            _w = self.m_area_.areaValue or _w
            self.m_rate_ = self.m_area_.scaleRate or 1
        else
            line = self.viewRect_.width*0.5
        end
        min,max = line-_w*0.5,line+_w*0.5
        for i=1,#self.items_ do
            item = self.items_[i] 
            local _x,_y = item:getPosition()

            bound = {x=_x-self.viewRect_.x,y=_y,width=_w,height=_h}
            local curX = bound.x+bound.width*0.5+scrollX
            if curX>min and curX<=line then
                if self.m_isScale_ then
                    self.items_[i]:getContent():setScale(curX/min*self.m_rate_)
                end
                item._isScaled = true
                item:setLocalZOrder(1)
            elseif curX>line and curX<max then
                if self.m_isScale_ then
                    self.items_[i]:getContent():setScale((line-(curX-line))/min*self.m_rate_)
                end
                item._isScaled = true
                item:setLocalZOrder(1)
            else
                self.items_[i]:getContent():setScale(1)
                item._isScaled = false
                item:setLocalZOrder(0)
            end
        end
    end
end
 
function CustomListView:scrollAuto()
    local status = self:twiningScroll()
    if status == "normal" then
        self:elasticScroll(true)
    elseif status == "sideShow" then
        self:elasticScroll(false)
    end
end
 
function CustomListView:twiningScroll()
    if self:isSideShow() then
        -- printInfo("UIScrollView - side is show, so elastic scroll")
        return "sideShow"
    end
    if math.abs(self.speed.x) < 10 and math.abs(self.speed.y) < 10 then
        -- printInfo("#DEBUG, UIScrollView - isn't twinking scroll:"
        --     .. self.speed.x .. " " .. self.speed.y)
        return "normal"
    end
 
    local disX, disY = self:moveXY(0, 0, self.speed.x*6, self.speed.y*6)
 
    transition.moveBy(self.scrollNode,
                      {x = disX, y = disY, time = 0.3,
                       easing = "sineOut",
                       onComplete = function()
                           self:elasticScroll(true)
    end})
end
 
function CustomListView:elasticScroll(fix)
    local cascadeBound = self:getScrollNodeRect()
    local disX, disY = 0, 0
    local viewRect = self:getViewRectInWorldSpace()
 
    -- dump(cascadeBound, "UIScrollView - cascBoundingBox:")
    -- dump(viewRect, "UIScrollView - viewRect:")
 
    if cascadeBound.width < viewRect.width then
        disX = viewRect.x - cascadeBound.x
    else
        if cascadeBound.x > viewRect.x then
            disX = viewRect.x - cascadeBound.x
        elseif cascadeBound.x + cascadeBound.width < viewRect.x + viewRect.width then
            disX = viewRect.x + viewRect.width - cascadeBound.x - cascadeBound.width
        end
    end
 
    if cascadeBound.height < viewRect.height then
        disY = viewRect.y + viewRect.height - cascadeBound.y - cascadeBound.height
    else
        if cascadeBound.y > viewRect.y then
            disY = viewRect.y - cascadeBound.y
        elseif cascadeBound.y + cascadeBound.height < viewRect.y + viewRect.height then
            disY = viewRect.y + viewRect.height - cascadeBound.y - cascadeBound.height
        end
    end
    if 0 == disX and 0 == disY then
        if fix then
            self:autoFixScroll()
        end
        return
    end
    self:scrollChange(self.scrollNode:getPositionX()+disX,self.scrollNode:getPositionY()+disY) 
    transition.moveBy(self.scrollNode,
                      {x = disX, y = disY, time = 0.3,
                       easing = "backout",
                       onComplete = function()
                           self:callListener_{name = "scrollEnd"}
--                            self:callListener_{name = "scrollStop"}
    end})
end

function CustomListView:getScaledItem_()
    for i=1,#self.items_ do
        if self.items_[i]._isScaled then
            return self.items_[i],i
        end
    end
    return nil
end

return CustomListView