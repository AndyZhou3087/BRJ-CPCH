--[[
结算界面
]]
local BaseUI = require("game.view.BaseUI")
local FightOver = class("FightOver",BaseUI)

function FightOver:ctor(parm)
    FightOver.super.ctor(self)

    --阴影层
    self.m_bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    GameController.pauseGame()
    
    self.m_fightover = cc.uiloader:load("json/FightOver.json")
    self:addChild(self.m_fightover)

    self.m_curLevel,self.m_levelIdx = GameDataManager.getCurLevelId()    --当前关卡
    
    self:initWidget()


    --判断是胜利还是失败
    if parm.type == GAMEOVER_TYPE.Win then
        self:toWin()
    elseif parm.type == GAMEOVER_TYPE.Fail then
        self:toFail()
--        self:init()
--        self:Clearing()
--        self:starEffect(3)
    end

    --启用onCleanup函数
    self:setNodeEventEnabled(true)
end

function FightOver:initWidget()
    self.m_score = cc.uiloader:seekNodeByName(self.m_fightover,"AtlasLabel_3")
    local totalScore = GameDataManager.getAllScore()
    self.m_score:setString(totalScore)

    self.m_goldCount = cc.uiloader:seekNodeByName(self.m_fightover,"GoldCount")
    local goldCount = math.floor(GameDataManager.getLevelCoin()/3)+GameDataManager.getGold()
    self.m_goldCount:setString(goldCount)

    self.m_diaCount = cc.uiloader:seekNodeByName(self.m_fightover,"DiamondCount")
    self.m_diaCount:setString(GameDataManager.getDiamond())

    self.diaBtn = cc.uiloader:seekNodeByName(self.m_fightover,"DiamondBtn")
    self.diaBtn:onButtonClicked(function(_event)
        --        Tools.printDebug("钻石")
    end)

    self.goldBtn = cc.uiloader:seekNodeByName(self.m_fightover,"GoldBtn")
    self.goldBtn:onButtonClicked(function(_event)
        --        Tools.printDebug("金币")
    end)

    for var=1, 3 do
        self["star_"..var] = cc.uiloader:seekNodeByName(self.m_fightover,"Star_"..var)
        self["star_"..var]:setButtonEnabled(false)
    end

    self.level = cc.uiloader:seekNodeByName(self.m_fightover,"LevelCount")
    self.level:setString(self.m_curLevel)
    self.LevelTips = cc.uiloader:seekNodeByName(self.m_fightover,"LevelTips")
    self.LevelTips:setButtonEnabled(false)
    self.ScroeLabel = cc.uiloader:seekNodeByName(self.m_fightover,"ScroeLabel")
    self.ScroeLabel:setString(GameDataManager.getAllScore())
    self.RecordScore = cc.uiloader:seekNodeByName(self.m_fightover,"RecordScore")
    self.RecordScore:setString("历史最高分:"..Tools.StringToComma(GameDataManager.getHistoryScore(self.m_curLevel)))

    self.backBtn = cc.uiloader:seekNodeByName(self.m_fightover,"Backbtn")
    self.backBtn:onButtonClicked(function(_event)
        self:toClose(true)
        GameController.resumeGame()
        app:enterSelectScene()
    end)

    self.Continuebtn = cc.uiloader:seekNodeByName(self.m_fightover,"Continuebtn")
    self.continueLabel = cc.uiloader:seekNodeByName(self.m_fightover,"WinFail")
    self.continueLabel:setButtonEnabled(false)
end

--过关胜利界面
function FightOver:toWin()
    local _isFirst = GameDataManager.saveLevelData()  --存储关卡数据
    
--    if _isFirst == true then
--        local _leveCon = SelectLevel[self.m_curLevel]
--        if _leveCon then
--            local _addPower = _leveCon.powerAward[_starNum]
--            if _addPower then
--                GameDataManager.addPower(_addPower)
--            end
--            local _addGold = _leveCon.coinAwardFirst[_starNum]     --首次通关金币奖励
--            if _addGold then
--                GameDataManager.addGold(_addGold+self.m_allGolds)
--                self.m_golds:setString(self.m_allGolds+_addGold)
--            end
--        end
--    else
        local _coins = SelectLevel[self.m_curLevel].coinAward
        if _coins then
            GameDataManager.addGold(_coins)
        end
        local _power = SelectLevel[self.m_curLevel].powerAward
        if _power then
        	GameDataManager.addPower(_power)
        end
--    end
    GameDataManager.addPower(SelectLevel[self.m_curLevel].costPower)
    
    for var=1, 3 do
        self["star_"..var]:setButtonImage("disabled","ui/StarLight.png")
    end
    self.LevelTips:setButtonImage("disabled","ui/Over_win.png")
    self.Continuebtn:setButtonImage("normal","Common/Common_c1_1.png")
    self.Continuebtn:setButtonImage("pressed","Common/Common_c1_2.png")
    self.continueLabel:setButtonImage("disabled","ui/Pause_continue.png")
    self.RecordScore:setString("历史最高分:"..Tools.StringToComma(GameDataManager.getHistoryScore(self.m_curLevel), ","))
    

    self.Continuebtn:onButtonClicked(function(_event)
--        if GameDataManager.getUlockLevelsNum() <= 1 and _isFirst == true then
--            app:enterMainScene()
--            self:toClose(true)
--            return
--        end
        if  self.m_curLevel < #SelectLevel then
            GameController.resumeGame()
            GameDataManager.setCurLevelId(self.m_curLevel+1,self.m_levelIdx+1)
            app:enterSelectScene()
            Tools.delayCallFunc(0.01,function()
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_LOAD,{method=2,})
            end)
            Tools.delayCallFunc(0.5,function()
                GameDispatcher:dispatch(EventNames.EVENT_OPEN_READY,GAME_TYPE_CONTROL)
            end)
            self:toClose(true)
        else
        
        end

    end)
end

function FightOver:toFail()
    for var=1, 3 do
        self["star_"..var]:setButtonImage("disabled","ui/StarDark.png")
    end
    self.LevelTips:setButtonImage("disabled","ui/Over_fail.png")
    self.Continuebtn:setButtonImage("normal","Common/Common_c2_1.png")
    self.Continuebtn:setButtonImage("pressed","Common/Common_c2_2.png")
    self.continueLabel:setButtonImage("disabled","ui/Pause_restart.png")
    self.RecordScore:setString("历史最高分:"..Tools.StringToComma(GameDataManager.getHistoryScore(self.m_curLevel), ","))

    self.Continuebtn:onButtonClicked(function(_event)
        GameController.resumeGame()
        app:enterSelectScene()
        Tools.delayCallFunc(0.01,function()
            GameDispatcher:dispatch(EventNames.EVENT_OPEN_LOAD,{method=2,})
        end)
        Tools.delayCallFunc(0.5,function()
            GameDispatcher:dispatch(EventNames.EVENT_OPEN_READY,GAME_TYPE_CONTROL)
        end)
        self:toClose(true)

    end)
end


function FightOver:onCleanup()
    AudioManager.setFightSoundEnable(true)
end

--添加到舞台时调用
function FightOver:addedToScene()
end

--关闭界面调用
function FightOver:toClose(_clean)
    FightOver.super.toClose(self,_clean)
end

return FightOver