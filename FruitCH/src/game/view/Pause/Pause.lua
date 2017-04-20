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
    
    local Panel_9 = cc.uiloader:seekNodeByName(_pause,"Panel_9")
    Panel_9:setPositionX(display.cx)
    
    local diaBtn = cc.uiloader:seekNodeByName(_pause,"DiamondBtn")
    diaBtn:onButtonClicked(function(_event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP,true)
    end)

    local goldBtn = cc.uiloader:seekNodeByName(_pause,"GoldBtn")
    goldBtn:onButtonClicked(function(_event)
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Button_Click_Sound)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP,true)
    end)
    
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
            app:enterSelectScene()
        elseif GAME_TYPE_CONTROL == GAME_TYPE.EndlessMode then
            app:enterMainScene()
        end
    end)
    
    --启用onCleanup函数
    self:setNodeEventEnabled(true)
end

--关闭界面调用
function Pause:toClose(_clean)
    Pause.super.toClose(self,true)
end

--清理数据
function Pause:onCleanup()

end

return Pause