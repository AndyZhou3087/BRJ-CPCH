--[[
    UIListView控件里的基础条目类,为能够精确获得到点击事件，锚点必须为0，0
]]
local UIListViewBaseItem = class("UIListViewBaseItem",function()
	return display.newNode()
end)

--function UIListViewBaseItem:getSize()
--    
--end

--_touchEnable是否开启触摸监听
function UIListViewBaseItem:ctor(_touchEnable)
    if self.getSize then
        self.getContentSize = self.getSize
    else
        self.getContentSize = self.getCascadeBoundingBox
    end
    if _touchEnable then
        self.m_shakeValue = 5
        self.m_preX = 0
        self.m_preY = 0
        self.m_isMoving = false

        self:setTouchSwallowEnabled(false)
        self:setTouchEnabled(true)
        self:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
            if event.name == "began" then
                self.m_preX = event.x
                self.m_preY = event.y
                --            self:onBegan(event)
--                print("chjh touch begin")
                return true
            elseif event.name=="ended" then
                --            app:debug("chjh 111 click task item name=")
                if self.m_isMoving then
                    --                app:debug("chjh 222 click task item name="..self.m_data.m_name)
                    self.m_isMoving = false
                    --                self:onEnded(event)
                    return true
                end
                self:onClicked(event)
                --            app:debug("chjh 333 click task item name="..self.m_data.m_name)
                return true
            elseif event.name == "moved" then
                if self:isShake(event) then
                    return
                end
                self.m_isMoving = true
                --            self:onMoved(event)
            end
        end)
    end
end

--排除手势抖动
function UIListViewBaseItem:isShake(_event)
    if math.abs(_event.x - self.m_preX) < self.m_shakeValue
        and math.abs(_event.y - self.m_preY) < self.m_shakeValue then
        return true
    end
end

----鼠标开始事件
--function UIListViewBaseItem:onBegan(_param)
--	
--end
----鼠标结束事件
--function UIListViewBaseItem:onEnded(_param)
--
--end
--鼠标点击事件
function UIListViewBaseItem:onClicked(_param)

end
----鼠标移动事件
--function UIListViewBaseItem:onMoved(_param)
--end

return UIListViewBaseItem