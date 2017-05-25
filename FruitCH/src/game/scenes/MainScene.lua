local MainUI = require("game.view.main.MainUI")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self:initData()
    self.m_mainUI = MainUI.new()
    self:addChild(self.m_mainUI)
    
    self:setKeypadEnabled(true)
    self:addNodeEventListener(cc.KEYPAD_EVENT, function (event)
        if event.key == "back" then
            local id,gId,eid = GameController.getCurGiftId()  --获取可用礼包计费点
            local info = GiftConfig[eid]
            app:alert({
                type=Alert_Type.Type_Two,
                content=info.exitDes,
                isClose = true,
                okFunc=function(parameters)
                    local payId = info.exitPayId
                    local oId = SDKUtil.getOrderId(payId)
                    SDKUtil.toPay({goodsId=payId,orderId=oId,callback=function(_res)
                        if SDKUtil.PayResult.Success == _res then
                            if info.gold then
                                GameDataManager.addGold(info.gold)
                            end
                            if info.diamond then
                                GameDataManager.addDiamond(info.diamond)
                            end
                            if info.goods then
                                for var=1, #info.goods do
                                    local info2 = info.goods[var]
                                    GameDataManager.addGoods(info2.id,info2.count)
                                end
                            end
                            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买成功"})
                            SDKUtil.umentOnEvent(SDKUtil.EventId.GiftBuy..eid)
                        else
                            GameDispatcher:dispatch(EventNames.EVENT_FLY_TEXT,{text ="购买失败"})
                        end
                    end})
                end,
                cancleFunc=function(parameters)
                	SDKUtil.exitGame()
                end
            })
        end
    end)

end

--数据初始化
function MainScene:initData()
    GameDataManager.init()
    GameDataManager.SaveData()
    TimeUtil.init()
end

function MainScene:onEnter()
    if GameDataManager.isMusicOpen()==false then
        AudioManager.open(1)
    end
    if GameDataManager.isSoundOpen()==false then
        AudioManager.open(2)
    end
    AudioManager.playGroundMusic(AudioManager.Ground_Music_Type.Main_Bg,true)
    if not tolua.isnull(self.m_mainUI) then
        self.m_mainUI:addedToScene()
    end
end

function MainScene:onExit()
end

return MainScene
