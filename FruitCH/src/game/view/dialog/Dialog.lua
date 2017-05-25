--[[
对话框界面
]]
local BaseUI = require("game.view.BaseUI")
local Dialog = class("Dialog",BaseUI)

--[[
@param1:类型
@param2:确定按钮文字
@Param3:取消按钮文字
]]
function Dialog:ctor(_type,_okStr,_cancleStr,_isClose,_pType)
    Dialog.super.ctor(self)

    self.m_type = _type or Alert_Type.Type_One

    local bg = display.newColorLayer(cc.c4b(0,0,0,200)):addTo(self)
    local _dialog = cc.uiloader:load("json/Dialog.json")
    self:addChild(_dialog)
    
    local _xy = cc.uiloader:seekNodeByName(_dialog,"Image_1")
    _xy:setPosition(display.cx,display.cy)
    local _xySize=_xy:getCascadeBoundingBox().size

--    self.m_title = cc.uiloader:seekNodeByName(_dialog,"title")    -- 提示信息
--    self:setTitle("信息提示")

    self.m_content = cc.uiloader:seekNodeByName(_dialog,"Label_6")      --提示内容
    self.m_content:setString("是否确认购买？")
    self.p_content = cc.uiloader:seekNodeByName(_dialog,"Label_8")
    self.p_content:setString("是否确认购买？")
    self.p_content:setVisible(false)
    if _pType == 1 then
    	self.m_content:setVisible(false)
    	self.p_content:setVisible(true)
    end

    local _leftBtn = cc.uiloader:seekNodeByName(_dialog,"Button_7")   --左边按钮
    _leftBtn:setVisible(false)

    local _rightBtn = cc.uiloader:seekNodeByName(_dialog,"Button_7_0")   --右边按钮
    _rightBtn:setVisible(false)

    if self.m_type == Alert_Type.Type_One then
        _leftBtn:setVisible(true)
        _leftBtn:setPosition(_xySize.width/2,_xySize.height/2-100)
        _rightBtn:setVisible(false)
        _leftBtn:onButtonClicked(function(_event)
            AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
            if self.m_okFunc then
                self.m_okFunc()
            elseif self.m_canCleFunc then
                self.m_canCleFunc()
            end
            self:toClose(true)
        end)
    elseif self.m_type == Alert_Type.Type_Two then
        _leftBtn:setVisible(true)
       _leftBtn:onButtonClicked(function(_event)
            AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
            if self.m_okFunc then
                self.m_okFunc()
            end
            if _isClose then
                self:toClose(true)
            end
        end)

        _rightBtn:setVisible(true)
        _rightBtn:onButtonClicked(function(_event)
            AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
            if self.m_canCleFunc then
                self.m_canCleFunc()
            end
           self:toClose(true)
        end)
    end
end
--设置弹窗标题
function Dialog:setTitle(_title)
    if self.m_title then
        self.m_title:setString(_title)
    end
end
--设置弹窗内容
function Dialog:setContent(_content)
    if self.m_content then
        self.m_content:setString(_content)
    end
end
--设置确认监听方法
function Dialog:setOkFunc(_func)
    self.m_okFunc = _func
end
--设置取消监听方法
function Dialog:setCancleFunc(_func)
    self.m_canCleFunc = _func
end

--关闭界面调用
function Dialog:toClose(_clean)
    Dialog.super.toClose(self,_clean)
end

return Dialog