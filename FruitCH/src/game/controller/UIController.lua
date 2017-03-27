
local UIController = class("UIController")

local FightReadyUI = require("game.view.fightReady.FightReadyUI")
local FlyText = require("game.view.flyText.FlyText")
local Pause = require("game.view.Pause.Pause")
local FightOver = require("game.view.FightOver.FightOver")
local LoadingView = require("game.view.loading.LoadingView")
local ShopView = require("game.view.Shop.ShopView")
local RoleView = require("game.view.role.RoleView")

function UIController:ctor()
    --打开战斗准备界面
    GameDispatcher:addListener(EventNames.EVENT_OPEN_READY,handler(self,self.openReady))
    
    --飘字
    GameDispatcher:addListener(EventNames.EVENT_FLY_TEXT,handler(self,self.flyText))
    
    --打开暂停界面
    GameDispatcher:addListener(EventNames.EVENT_OPEN_PAUSE,handler(self,self.openPause))
    
    --结算
    GameDispatcher:addListener(EventNames.EVENT_OPEN_OVER,handler(self,self.openFightOver))
    
    --屏蔽
    GameDispatcher:addListener(EventNames.EVENT_OPEN_LOAD,handler(self,self.openLoad))
    
    --打开商城
    GameDispatcher:addListener(EventNames.EVENT_OPEN_SHOP,handler(self,self.openShop))
    
    --打开角色界面
    GameDispatcher:addListener(EventNames.EVENT_OPEN_ROLEVIEW,handler(self,self.openRoleView))
end

--打开战斗准备界面
function UIController:openReady(parm)
    local _ReadyUI =FightReadyUI.new(parm.data)
    _ReadyUI:show(UI_ZORDER.VIEW_ZORDER)
end

--飘字
function UIController:flyText(parameters)
    local _flyUi = FlyText.new(parameters.data)
    _flyUi:show(UI_ZORDER.TIPS_ZORDER)
end

function UIController:openPause(parameters)
    local _pauseUI = Pause.new()
    _pauseUI:show(UI_ZORDER.VIEW_ZORDER)
end

function UIController:openFightOver(parameters)
    local _overUI = FightOver.new(parameters.data)
    _overUI:show(UI_ZORDER.VIEW_ZORDER)
end

function UIController:openLoad(parameters)
    local _loadUI = LoadingView.new(parameters.data)
    _loadUI:show(UI_ZORDER.VIEW_ZORDER)
end

function UIController:openShop(parameters)
    local _shopUI = ShopView.new(parameters.data)
    _shopUI:show(UI_ZORDER.VIEW_ZORDER)
end

function UIController:openRoleView(parameters)
    local _roleUI = RoleView.new(parameters.data)
    _roleUI:show(UI_ZORDER.VIEW_ZORDER)
end

return UIController