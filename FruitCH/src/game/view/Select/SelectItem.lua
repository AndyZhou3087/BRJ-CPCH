
local SelectItem = class("SelectItem",function()
    return display.newNode()
end)

function SelectItem:ctor(parameters)
    self.parm = parameters

    self.chapterBtn = cc.ui.UIPushButton.new(parameters.res, {scale9 = true})
        :setButtonSize(parameters.rect[1],parameters.rect[2])
        :onButtonClicked(function(event)
            Tools.printDebug("chjh button click")
            Tools.printDebug("----------关卡：",parameters._id)
            self:initLevelVo(parameters._id)
        end)
        :addTo(self)
    self.chapterBtn:setTouchSwallowEnabled(false)
    self.chapterBtn:setAnchorPoint(0,0)
    self.chapterBtn:setPosition(cc.p(parameters.pos.x,parameters.pos.y))
    
    self:initLevelData()
    
end

function SelectItem:initLevelVo(level)
    GameDataManager.setCurLevelId(level,level)
    GameDispatcher:dispatch(EventNames.EVENT_OPEN_READY,GAME_TYPE.LevelMode)
--    GameDataManager.generatePlayerVo()  --产生新的角色数据对象
--    app:enterGameScene()
end

function SelectItem:initLevelData(level)
    if not GameDataManager.getFightData(self.parm._id-1) then
        self.chapterBtn:setButtonEnabled(false)
        self.chapterBtn:setColor(cc.c3b(0,0,0))
        if self.parm._id == 1 then
            self.chapterBtn:setButtonEnabled(true)
            self.chapterBtn:setColor(cc.c3b(255,255,255))
        end
    else
        self.chapterBtn:setButtonEnabled(true)
        self.chapterBtn:setColor(cc.c3b(255,255,255))
    end
end

function SelectItem:onCleanup(parameters)

end

function SelectItem:dispose(_clean)
    self:removeFromParent(_clean)
end

return SelectItem