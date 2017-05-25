--[[
暂停界面
]]
local BaseUI = require("game.view.BaseUI")
local Pause = class("Pause",BaseUI)

function Pause:ctor(parm)
    Pause.super.ctor(self)
    local bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    GameController.pauseGame(true) --游戏暂停

    local _pause = cc.uiloader:load("json/PauseUI.json")
    self:addChild(_pause)
    
    local Image_16 = cc.uiloader:seekNodeByName(_pause,"Image_16")
    Image_16:setPositionX(display.cx)
    local ImageX,ImageY = Image_16:getPosition()
    if parm.animation then
        self:popupLeft(ImageX,ImageY,Image_16)
    end
    
--    local Panel_9 = cc.uiloader:seekNodeByName(_pause,"Panel_9")
--    Panel_9:setPositionX(display.cx)
    
    local diaBtn = cc.uiloader:seekNodeByName(_pause,"DiamondBtn")
    diaBtn:onButtonClicked(function(_event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP,true)
    end)
    self.DiamondCount = cc.uiloader:seekNodeByName(_pause,"DiamondCount")
    self.DiamondCount:setString(GameDataManager.getDiamond())

    local goldBtn = cc.uiloader:seekNodeByName(_pause,"GoldBtn")
    goldBtn:onButtonClicked(function(_event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP,true)
    end)
    self.GoldCount = cc.uiloader:seekNodeByName(_pause,"GoldCount")
    self.GoldCount:setString(GameDataManager.getGold())
    
    --继续游戏
    local ContinueBtn=cc.uiloader:seekNodeByName(_pause,"ContinueBtn")
    ContinueBtn:onButtonClicked(function(event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        GameController.resumeGame(true)
        self:toClose(true)
    end)
    
    --重新开始
    self.RestartBtn=cc.uiloader:seekNodeByName(_pause,"RestartBtn")
    self.RestartBtn:onButtonClicked(function(event)
        ContinueBtn:setButtonEnabled(false)
        self.BackBtn:setButtonEnabled(false)
        self.RestartBtn:setButtonEnabled(false)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode then
            GameController.isFightOverBack = true
            GameController.setSignPop(false)
            GameController.resumeGame()
            app:enterSelectScene()
            Tools.delayCallFunc(0.01,function()
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_LOAD,{method=2,})
            end)
            Tools.delayCallFunc(0.1,function()
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_READY,GAME_TYPE_CONTROL)
            end)
        elseif GAME_TYPE_CONTROL == GAME_TYPE.EndlessMode then
            GameController.setSignPop(false)
            GameController.resumeGame()
            GameController.setMainSign(true)
            app:enterMainScene()
            Tools.delayCallFunc(0.01,function()
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_LOAD,{method=2,})
            end)
            Tools.delayCallFunc(0.1,function()
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_READY,GAME_TYPE_CONTROL)
            end)
            self:toClose(true)
        end
    end)
    
    self.BackBtn=cc.uiloader:seekNodeByName(_pause,"BackBtn")
    self.BackBtn:onButtonClicked(function(event)
        ContinueBtn:setButtonEnabled(false)
        self.RestartBtn:setButtonEnabled(false)
        self.BackBtn:setButtonEnabled(false)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        GameController.setSignPop(true)
        GameController.resumeGame()
        if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode then
            GameController.isBackMap = true
            GameController.isFightOverBack = true
            app:enterSelectScene()
        elseif GAME_TYPE_CONTROL == GAME_TYPE.EndlessMode then
            GameController.setMainSign(true)
            app:enterMainScene()
        end
    end)
    
    --启用onCleanup函数
    self:setNodeEventEnabled(true)
    
    --监听钻石
    self.diamondHandler = GameDispatcher:addListener(EventNames.EVENT_UPDATE_DIAMOND,handler(self,self.updateDiamond))
    --监听金币
    self.goldHandler = GameDispatcher:addListener(EventNames.EVENT_UPDATE_GOLD,handler(self,self.updateGold))
end

function Pause:updateDiamond()
    self.DiamondCount:setString(GameDataManager.getDiamond())
end

function Pause:updateGold()
    self.GoldCount:setString(GameDataManager.getGold())
end

--关闭界面调用
function Pause:toClose(_clean)
    GameDispatcher:removeListenerByHandle(self.diamondHandler)
    GameDispatcher:removeListenerByHandle(self.goldHandler)
    Pause.super.toClose(self,true)
end

--清理数据
function Pause:onCleanup()
    GameDispatcher:removeListenerByHandle(self.diamondHandler)
    GameDispatcher:removeListenerByHandle(self.goldHandler)
end

return Pause