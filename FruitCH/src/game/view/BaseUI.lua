local BaseUI = class("BaseUI",function()
    return display.newNode()
end)

function BaseUI:ctor()
    self.m_size_ = nil
    self.m_buttonClicked = false
    self.m_isAlive = true
end

--添加到显示层上时自动调用
function BaseUI:addedToScene()

end

--显示界面
--@param:显示层级索引
function BaseUI:show(_zorder)
    _zorder = _zorder or 0
    local _curScene = display.getRunningScene()
    if _curScene then
        _curScene:addChild(self,_zorder)
        self:addedToScene()
    end
end
--关闭界面时统一调用
function BaseUI:toClose(_clean)
    --AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.UI_Close_Sound,false)
    self:removeFromParent(_clean)
end

--设置整个层上的按钮1秒之内点击无效
function BaseUI:setButtonDisabled()
    self.m_buttonClicked = true

    --1秒之后按钮才能点
    local scheduler = require("framework.scheduler")
    scheduler.performWithDelayGlobal(function()
        self.m_buttonClicked = false
    end,1)
end

--获取界面尺寸
function BaseUI:getSize()
    if self.m_size_ then
        return self.m_size_
    else
        return self:getCascadeBoundingBox().size
    end
end

--刷新界面数据
function BaseUI:refreshData()
end

--弹出界面(左边进)
--[[
@param1:x坐标
@param2:y坐标
@Param3:需要执行动画的精灵
@Param4:执行动画后要调用的内容
]]
function BaseUI:popupLeft(_x,_y,_performer,_manage)
    _x = _x or display.cx
    _y = _y or display.cy
    if _performer == nil then
        Tools.printDebug("_performer not found")
    end
    _performer:setPosition(_x-584,_y)
    local move1 = cc.MoveTo:create(0.12,{x=_x+20,y=_y})
    local move2 = cc.MoveTo:create(0.15,{x=_x-10,y=_y})
    local move3 = cc.MoveTo:create(0.1,{x=_x+10,y=_y})
    local move4 = cc.MoveTo:create(0.05,{x=_x,y=_y})
    local guides = cc.CallFunc:create(function()
        if _manage ~= nil then
            _manage()
        end
    end)
    local moves = cc.Sequence:create(move1,move2,move3,move4,guides)
    _performer:runAction(moves)
end

--弹出界面(上边进)
function BaseUI:popupUp(_x,_y,_performer)
    _x = _x or display.cx
    _y = _y or display.cy
    if _performer == nil then
        Tools.printDebug("_performer not found")
    end
    local move1 = cc.MoveTo:create(0.1,{x=_x,y=_y-10})
    local move2 = cc.MoveTo:create(0.12,{x=_x,y=_y+6})
    local move3 = cc.MoveTo:create(0.1,{x=_x,y=_y-3})
    local move4 = cc.MoveTo:create(0.05,{x=_x,y=_y})
    local moves = cc.Sequence:create(move1,move2,move3,move4)
    _performer:runAction(moves)
end

--关闭界面(右边出)
function BaseUI:closeRight(_x,_y,_performer,_manage)
    _x = _x or display.cx
    _y = _y or display.cy
    if _performer == nil then
        Tools.printDebug("_performer not found")
    end
    local move5 = cc.MoveTo:create(0.1,{x=_x-50,y=_y})
    local move6 = cc.MoveTo:create(0.2,{x=_x+800,y=_y})
    local over = cc.CallFunc:create(function()
        if _manage ~= nil then
            _manage()
        end
        self:toClose(true)
    end)
    local moves2 = cc.Sequence:create(move5,move6,over)
    _performer:runAction(moves2)
end

--关闭界面(下边出)
function BaseUI:closeDown(_x,_y,_performer,_manage)
    _x = _x or display.cx
    _y = _y or display.cy
    if _performer == nil then
        Tools.printDebug("_performer not found")
    end
    local move5 = cc.MoveTo:create(0.1,{x=_x,y=_y+20})
    local move6 = cc.MoveTo:create(0.2,{x=_x,y=_y-500})
    local over = cc.CallFunc:create(function()
        if _manage ~= nil then
            _manage()
        end
        self:toClose(true)
    end)
    local moves2 = cc.Sequence:create(move5,move6,over)
    _performer:runAction(moves2)
end

return BaseUI