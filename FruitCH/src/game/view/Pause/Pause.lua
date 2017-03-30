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
    
    local diaBtn = cc.uiloader:seekNodeByName(_pause,"DiamondBtn")
    diaBtn:onButtonClicked(function(_event)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP,true)
    end)

    local goldBtn = cc.uiloader:seekNodeByName(_pause,"GoldBtn")
    goldBtn:onButtonClicked(function(_event)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP,true)
    end)
    
    --继续游戏
    local ContinueBtn=cc.uiloader:seekNodeByName(_pause,"ContinueBtn")
    ContinueBtn:onButtonClicked(function(event)
        GameController.resumeGame(true)
        self:toClose(true)
    end)
    
    --重新开始
    local RestartBtn=cc.uiloader:seekNodeByName(_pause,"RestartBtn")
    RestartBtn:onButtonClicked(function(event)
        GameController.resumeGame()
        app:enterSelectScene()
        Tools.delayCallFunc(0.01,function()
            GameDispatcher:dispatch(EventNames.EVENT_OPEN_LOAD,{method=2,})
        end)
        Tools.delayCallFunc(0.5,function()
            GameDispatcher:dispatch(EventNames.EVENT_OPEN_READY,GAME_TYPE_CONTROL)
        end)
    end)
    
    local BackBtn=cc.uiloader:seekNodeByName(_pause,"BackBtn")
    BackBtn:onButtonClicked(function(event)
        GameController.resumeGame()
        self:toClose(true)
        app:enterSelectScene()
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