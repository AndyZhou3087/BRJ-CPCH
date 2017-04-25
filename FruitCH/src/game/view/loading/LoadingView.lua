--[[
加载界面
]]
local BaseUI = require("game.view.BaseUI")
local LoadingView = class("LoadingView",BaseUI)
local Scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

function LoadingView:ctor(parameters)
    LoadingView.super.ctor(self)
    if parameters.method == 1 then
        print("方案1.带动画黑屏")
        self.m_bg = display.newColorLayer(cc.c4b(0,0,0,255)):addTo(self)
        self:loadAction()
    elseif parameters.method == 2 then
        print("方案2.透明层屏蔽点击事件")
        self.m_bg2 = display.newColorLayer(cc.c4b(0,0,0,0)):addTo(self)
    end
    GameDispatcher:addListener(EventNames.EVENT_LOADING_OVER,handler(self,self.loadingOver))
    
    self.autoHandler = Tools.delayCallFunc(2,function()
        self:toClose(true)
    end)
    
    --启用onCleanup函数
    self:setNodeEventEnabled(true)
end

--动画和文字效果
function LoadingView:loadAction(parameters)
    local _loading = cc.uiloader:load("ui/loading_ui.json")
    self:addChild(_loading)

    local _text = cc.uiloader:seekNodeByName(_loading,"Label_1")
    _text:setPosition(display.cx,display.cy-50)
    local _textSize = _text:getCascadeBoundingBox().size

    self.m_loadText=cc.uiloader:seekNodeByName(_loading,"action")
    self.m_loadText:setPosition(display.cx+_textSize.width/2,display.cy-50)

    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("pet/cnm0.png","pet/cnm0.plist","pet/cnm.ExportJson")
    local _cnm =ccs.Armature:create("cnm"):addTo(self)
    _cnm:setPosition(display.cx,display.cy+50)
    _cnm:setScale(0.5)

    local function playAction(parameters)
        _cnm:getAnimation():play("run")
    end

    playAction()

    local function onInterval(dt)
        self.m_handler1 =Tools.delayCallFunc(0.1,function()
            self.m_loadText:setString("")
        end)
        self.m_handler2 =Tools.delayCallFunc(0.3,function()
            self.m_loadText:setString(".")
        end)
        self.m_handler3 =Tools.delayCallFunc(0.5,function()
            self.m_loadText:setString("..")
        end)
        self.m_handler4 =Tools.delayCallFunc(0.7,function()
            self.m_loadText:setString("...")
        end)
    end
    onInterval()
    self.m_handle = Scheduler.scheduleGlobal(onInterval,1.6)

    local tips=cc.uiloader:seekNodeByName(_loading,"tips")
    tips:setPosition(display.cx,display.cy/2)
    tips:setString(LOADING_TIPS[math.random(1,#LOADING_TIPS)])
end

function LoadingView:loadingOver()
    print("关闭读取界面")
    self:toClose(true)
end

--清理数据
function LoadingView:onCleanup()
    if self.m_handle then
        Scheduler.unscheduleGlobal(self.m_handle)
        self.m_handle = nil
    end
    if self.m_handler1 then
        Scheduler.unscheduleGlobal(self.m_handler1)
        self.m_handler1 = nil
    end
    if self.m_handler2 then
        Scheduler.unscheduleGlobal(self.m_handler2)
        self.m_handler2 = nil
    end
    if self.m_handler3 then
        Scheduler.unscheduleGlobal(self.m_handler3)
        self.m_handler3 = nil
    end
    if self.m_handler4 then
        Scheduler.unscheduleGlobal(self.m_handler4)
        self.m_handler4 = nil
    end
    
    if self.autoHandler then
        Scheduler.unscheduleGlobal(self.autoHandler)
        self.autoHandler = nil
    end
    
    GameDispatcher:removeListenerByName(EventNames.EVENT_LOADING_OVER)
end

--关闭界面调用
function LoadingView:toClose(_clean)
    LoadingView.super.toClose(self,_clean)
end

return LoadingView