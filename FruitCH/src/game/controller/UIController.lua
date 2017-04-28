
local UIController = class("UIController")

local FightReadyUI = require("game.view.fightReady.FightReadyUI")
local FlyText = require("game.view.flyText.FlyText")
local Pause = require("game.view.Pause.Pause")
local FightOver = require("game.view.FightOver.FightOver")
local LoadingView = require("game.view.loading.LoadingView")
local ShopView = require("game.view.Shop.ShopView")
local RoleView = require("game.view.role.RoleView")
local RewardUI = require("game.view.fightReady.RewardUI")
local ClippingView=require("game.view.clipping.ClippingView")
local SignUI = require("game.view.sign.SignUI")
local AchieveQuest = require("game.view.AchieveQuest.AchieveQuest")
local ReviveView = require("game.view.revive.ReviveUI")
local GiftView = require("game.view.gift.GiftView")

local ClipGuideView = require("game.view.clipping.ClipGuideView")
local GuideView = require("game.view.guide.GuideView")

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
    
    --打开奖励界面
    GameDispatcher:addListener(EventNames.EVENT_OPEN_REWARDPROP,handler(self,self.openRewardView))
    
    --打开遮罩界面
    GameDispatcher:addListener(EventNames.EVENT_OPEN_CLIPP,handler(self,self.openClipp))
    
    --签到界面
    GameDispatcher:addListener(EventNames.EVENT_OPEN_SIGNUI,handler(self,self.openSign))
    
    --成就任务界面
    GameDispatcher:addListener(EventNames.EVENT_ACHIEVE_QUEST,handler(self,self.openAchideve))
    
    --复活界面
    GameDispatcher:addListener(EventNames.EVENT_REVIVE_VIEW,handler(self,self.openRevive))
    
    --角色礼包界面
    GameDispatcher:addListener(EventNames.EVENT_OPEN_GIFTROLE,handler(self,self.openGiftView))
    
    --新手引导遮罩
    GameDispatcher:addListener(EventNames.EVENT_GUIDE_CLIP,handler(self,self.openGuideClipView))
    
    --新手说明界面
    GameDispatcher:addListener(EventNames.EVENT_GUIDE_EXPLAIN,handler(self,self.openGuideView))
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
    local _pauseUI = Pause.new(parameters.data)
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

function UIController:openRewardView(parameters)
    local _rewardUI = RewardUI.new(parameters.data)
    _rewardUI:show(UI_ZORDER.VIEW_ZORDER)
end

--打开遮罩界面
function UIController:openClipp(parameters)
    local _clippUI = ClippingView.new(parameters.data)
    _clippUI:show(UI_ZORDER.CLIP_ZORDER)
end

--打开签到
function UIController:openSign(parameters)
    local _signUI = SignUI.new(parameters.data)
    _signUI:show(UI_ZORDER.VIEW_ZORDER)
end

function UIController:openAchideve(parameters)
    local _achUI = AchieveQuest.new(parameters.data)
    _achUI:show(UI_ZORDER.VIEW_ZORDER)
end

function UIController:openRevive(parameters)
    local _reviveUI = ReviveView.new(parameters.data)
    _reviveUI:show(UI_ZORDER.VIEW_ZORDER)
end

function UIController:openGiftView(parameters)
    local _GiftView = GiftView.new(parameters.data)
    _GiftView:show(UI_ZORDER.VIEW_ZORDER)
end

function UIController:openGuideClipView(parameters)
    local _clippUI = ClipGuideView.new(parameters.data)
    _clippUI:show(UI_ZORDER.TIPS_ZORDER)
end

function UIController:openGuideView(parameters)
    local _guideUI = GuideView.new(parameters.data)
    _guideUI:show(UI_ZORDER.ALERT_ZORDER)
end

return UIController