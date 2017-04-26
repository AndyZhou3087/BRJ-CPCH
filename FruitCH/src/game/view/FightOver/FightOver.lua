--[[
结算界面
]]
local BaseUI = require("game.view.BaseUI")
local FightOver = class("FightOver",BaseUI)

local Scheduler = require("framework.scheduler")

local starFlashTime = 0.5

function FightOver:ctor(parm)
    FightOver.super.ctor(self)

    --阴影层
    self.m_bg = display.newColorLayer(cc.c4b(0,0,0,OPACITY)):addTo(self)
    GameController.pauseGame()
    AudioManager.stopAllSounds()
    
    self.m_fightover = cc.uiloader:load("json/FightOver.json")
    self:addChild(self.m_fightover)

    self.m_curLevel,self.m_levelIdx = GameDataManager.getCurLevelId()    --当前关卡
    
    self:initWidget()

    local Image_16 = cc.uiloader:seekNodeByName(self.m_fightover,"Image_16")
    Image_16:setPositionX(display.cx)
    
    local Panel_10 = cc.uiloader:seekNodeByName(self.m_fightover,"Panel_10")
    Panel_10:setPositionX(display.cx)

    --判断是胜利还是失败
    if parm.type == GAMEOVER_TYPE.Win then
        AudioManager.playSoundEffect(AudioManager.Sound_Effect_Type.Win_Sound)
        self:toWin()
    elseif parm.type == GAMEOVER_TYPE.Fail then
        self:toFail()
    end

    --启用onCleanup函数
    self:setNodeEventEnabled(true)
end

function FightOver:initWidget()
    self.m_score = cc.uiloader:seekNodeByName(self.m_fightover,"AtlasLabel_3")
    local totalScore = GameDataManager.getAllScore()
    self.m_score:setString(totalScore)

    self.m_goldCount = cc.uiloader:seekNodeByName(self.m_fightover,"GoldCount")
    self.m_goldCount:setString(GameDataManager.getAllFightCoins()+GameDataManager.getGold())

    self.m_diaCount = cc.uiloader:seekNodeByName(self.m_fightover,"DiamondCount")
    self.m_diaCount:setString(GameDataManager.getDiamond())

    self.diaBtn = cc.uiloader:seekNodeByName(self.m_fightover,"DiamondBtn")
    self.diaBtn:onButtonClicked(function(_event)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP,true)
    end)

    self.goldBtn = cc.uiloader:seekNodeByName(self.m_fightover,"GoldBtn")
    self.goldBtn:onButtonClicked(function(_event)
        GameDispatcher:dispatch(EventNames.EVENT_OPEN_SHOP,true)
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
    self.ScroeLabel:setVisible(false)
--    self.ScroeLabel:setString(GameDataManager.getAllScore())
    self.ScroeLabel_1 = cc.uiloader:seekNodeByName(self.m_fightover,"ScroeLabel_1")
    self.ScroeLabel_1:setVisible(false)
    self.label_1 = cc.uiloader:seekNodeByName(self.m_fightover,"label")
    self.label_2 = cc.uiloader:seekNodeByName(self.m_fightover,"label_1")
    self.ScroeLabel_2 = cc.uiloader:seekNodeByName(self.m_fightover,"ScroeLabel_2")
    self.ScroeLabel_2:setVisible(false)
    self.label_3 = cc.uiloader:seekNodeByName(self.m_fightover,"label_ScroeLabel_2")
    self.label_4 = cc.uiloader:seekNodeByName(self.m_fightover,"label_1_ScroeLabel_2")
    self.label_5 = cc.uiloader:seekNodeByName(self.m_fightover,"label_2_ScroeLabel_2")
    
    self.RecordScore = cc.uiloader:seekNodeByName(self.m_fightover,"RecordScore")
    self.RecordScore:setString("历史最高分:"..Tools.StringToComma(GameDataManager.getHistoryScore(self.m_curLevel)))
    self.GetGold = cc.uiloader:seekNodeByName(self.m_fightover,"GetGold")
    self.GetGold:setString("获得金币：")

    self.backBtn = cc.uiloader:seekNodeByName(self.m_fightover,"Backbtn")
    self.backBtn:onButtonClicked(function(_event)
        GameController.setSignPop(true)
        GameController.resumeGame()
        if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode then
            app:enterSelectScene()
        elseif GAME_TYPE_CONTROL == GAME_TYPE.EndlessMode then
            app:enterMainScene()
        end
        self:toClose(true)
    end)

    self.Continuebtn = cc.uiloader:seekNodeByName(self.m_fightover,"Continuebtn")
    self.continueLabel = cc.uiloader:seekNodeByName(self.m_fightover,"WinFail")
    self.continueLabel:setButtonEnabled(false)
end

function FightOver:starAction(obj)
    obj:setVisible(true)
    obj:setScale(1.2)
    local x,y = obj:getPosition()
    obj:setPosition(cc.p(x+50,y-50))
    local rotate1 = cc.RotateBy:create(starFlashTime,360)
    local scale = cc.ScaleTo:create(starFlashTime,1)
    local move = cc.MoveBy:create(0.5,cc.p(-50,50))
    local spawn = cc.Spawn:create(rotate1,scale,move)
    obj:runAction(spawn)
    
end

--过关胜利界面
function FightOver:toWin()
    local _isFirst = GameDataManager.saveLevelData()  --存储关卡数据
    self.initGoldCount = GameDataManager.getGold()
    self.getGoldCount = 0
    self.getScore = 0
    GameDataManager.addGold(GameDataManager.getAllFightCoins())

    local _leveCon = SelectLevel[self.m_curLevel]
    if _leveCon then
        local _coins = _leveCon.coinAward
        if _coins then
            GameDataManager.addGold(_coins)
        end
        local _power = _leveCon.powerAward
        if _power then
            GameDataManager.addPower(_power)
        end
        GameDataManager.addPower(_leveCon.costPower)
        
        local star = _leveCon.getStar(GameDataManager.getAllScore())
        for var=1, 3 do
            if var <= star then
                self["star_"..var]:setButtonImage("disabled","ui/StarLight.png")
                self["star_"..var]:setVisible(false)
                --星星动画
                if self["handler"..var] then
                    Scheduler.unscheduleGlobal(self["handler"..var])
                    self["handler"..var] = nil
                end
                self["handler"..var] = Tools.delayCallFunc(starFlashTime*var,function()
                    self:starAction(self["star_"..var])
                end)
            else
                self["star_"..var]:setVisible(false)
            end
        end
    end
    
    self.LevelTips:setButtonImage("disabled","ui/Over_win.png")
    self.Continuebtn:setButtonImage("normal","Common/Common_c1_1.png")
    self.Continuebtn:setButtonImage("pressed","Common/Common_c1_2.png")
    self.continueLabel:setButtonImage("disabled","ui/Pause_continue.png")
    self.RecordScore:setString("历史最高分:"..Tools.StringToComma(GameDataManager.getHistoryScore(self.m_curLevel), ","))
    self.GetGold:setString("获得金币："..GameDataManager.getAllFightCoins())

    self.Continuebtn:onButtonClicked(function(_event)
        self.backBtn:setButtonEnabled(false)
        self.Continuebtn:setButtonEnabled(false)
        if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode then
            if  self.m_curLevel < #SelectLevel then
                GameController.setSignPop(false)
                GameController.resumeGame()
                GameDataManager.setCurLevelId(self.m_curLevel+1,self.m_levelIdx+1)
                app:enterSelectScene()
                Tools.delayCallFunc(0.01,function()
                    GameDispatcher:dispatch(EventNames.EVENT_OPEN_LOAD,{method=2,})
                end)
                Tools.delayCallFunc(0.1,function()
                    GameDispatcher:dispatch(EventNames.EVENT_OPEN_READY,GAME_TYPE_CONTROL)
                end)
                self:toClose(true)
            else

            end
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
    
    --金币更新效果
    self.updateGoleHandler = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),0.05)
    self.updateScoresHandler = Scheduler.scheduleGlobal(handler(self,self.updateScores),0.01)
end

function FightOver:toFail()
    for var=1, 3 do
        self["star_"..var]:setButtonImage("disabled","ui/StarDark.png")
    end
    self:StringToComma(GameDataManager.getAllScore())
    self.LevelTips:setButtonImage("disabled","ui/Over_fail.png")
    self.Continuebtn:setButtonImage("normal","Common/Common_c2_1.png")
    self.Continuebtn:setButtonImage("pressed","Common/Common_c2_2.png")
    self.continueLabel:setButtonImage("disabled","ui/Pause_restart.png")
    self.RecordScore:setString("历史最高分:"..Tools.StringToComma(GameDataManager.getHistoryScore(self.m_curLevel), ","))

    self.Continuebtn:onButtonClicked(function(_event)
        self.backBtn:setButtonEnabled(false)
        self.Continuebtn:setButtonEnabled(false)
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
            self:toClose(true)
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
end

function FightOver:onEnterFrame(parameters)
    self.initGoldCount = self.initGoldCount + 1
    self.getGoldCount = self.getGoldCount + 1
    self.GetGold:setString("获得金币："..self.getGoldCount)
    self.m_goldCount:setString(self.initGoldCount)
    if self.getGoldCount >= GameDataManager.getAllFightCoins() then
        self.getGoldCount = GameDataManager.getAllFightCoins()
        self.initGoldCount = GameDataManager.getGold()
        self.GetGold:setString("获得金币："..self.getGoldCount)
        self.m_goldCount:setString(self.initGoldCount)
        if self.updateGoleHandler then
            Scheduler.unscheduleGlobal(self.updateGoleHandler)
            self.updateGoleHandler = nil
        end
    end
end

function FightOver:updateScores(parameters)
    self.getScore = self.getScore + 100
    self:StringToComma(self.getScore)
    if self.getScore >= GameDataManager.getAllScore() then
        self.getScore = GameDataManager.getAllScore()
        self:StringToComma(self.getScore)
        if self.updateScoresHandler then
            Scheduler.unscheduleGlobal(self.updateScoresHandler)
            self.updateScoresHandler = nil
        end
    end
end


--数字转换，三位数逗号转换
function FightOver:StringToComma(count)
    local mCount = 0;
    if count >= 1000000 then
        local str1 = math.floor(count / 1000000);
        local str2 = count % 1000000;
        local str3 = math.floor(str2 / 1000);
        local str4 = str2 % 1000;
        if str3 < 10 then
            str3 = "00"..str3;
        elseif str3 < 100 then
            str3 = "0"..str3;
        end
        if str4 < 10 then
            str4 = "00"..str4;
        elseif str4 < 100 then
            str4 = "0"..str4;
        end
--        mCount = str1..","..str3..","..str4;
        self.ScroeLabel:setVisible(false)
        self.ScroeLabel_1:setVisible(false)
        self.ScroeLabel_2:setVisible(true)
        self.label_3:setString(str1)
        self.label_4:setString(str3)
        self.label_5:setString(str4)
    elseif count >= 1000 then
        local str1 = math.floor(count / 1000);
        local str2 = count % 1000;
        if str2 < 10 then
            str2 = "00"..str2;
        elseif str2 < 100 then
            str2 = "0"..str2;
        end
--        mCount = str1..","..str2;
        self.ScroeLabel:setVisible(false)
        self.ScroeLabel_1:setVisible(true)
        self.ScroeLabel_2:setVisible(false)
        self.label_1:setString(str1)
        self.label_2:setString(str2)
    else
--        mCount = count;
        self.ScroeLabel:setVisible(true)
        self.ScroeLabel_1:setVisible(false)
        self.ScroeLabel_2:setVisible(false)
        self.ScroeLabel:setString(count)
    end
--    return mCount;
end


function FightOver:onCleanup()
    AudioManager.setFightSoundEnable(true)
    if self.updateGoleHandler then
        Scheduler.unscheduleGlobal(self.updateGoleHandler)
        self.updateGoleHandler = nil
    end
    if self.updateScoresHandler then
        Scheduler.unscheduleGlobal(self.updateScoresHandler)
        self.updateScoresHandler = nil
    end
    for var=1, 3 do
        if self["handler"..var] then
            Scheduler.unscheduleGlobal(self["handler"..var])
            self["handler"..var] = nil
        end
    end
end

--添加到舞台时调用
function FightOver:addedToScene()
end

--关闭界面调用
function FightOver:toClose(_clean)
    if self.updateGoleHandler then
        Scheduler.unscheduleGlobal(self.updateGoleHandler)
        self.updateGoleHandler = nil
    end
    if self.updateScoresHandler then
        Scheduler.unscheduleGlobal(self.updateScoresHandler)
        self.updateScoresHandler = nil
    end
    for var=1, 3 do
        if self["handler"..var] then
            Scheduler.unscheduleGlobal(self["handler"..var])
            self["handler"..var] = nil
        end
    end
    FightOver.super.toClose(self,_clean)
end

return FightOver