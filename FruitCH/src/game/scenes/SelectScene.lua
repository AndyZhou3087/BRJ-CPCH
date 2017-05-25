local SelectUI = require("game.view.Select.SelectUI")

local SelectScene = class("SelectScene", function()
    return display.newScene("SelectScene")
end)

function SelectScene:ctor()
    self.m_SelectUI = SelectUI.new()
    self:addChild(self.m_SelectUI)
    
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

function SelectScene:onEnter()
    AudioManager.playGroundMusic(AudioManager.Ground_Music_Type.Main_Bg,true)
    if not tolua.isnull(self.m_SelectUI) then
        self.m_SelectUI:addedToScene()
    end
end

function SelectScene:onExit()
    
end

--场景销毁
function SelectScene:onCleanup()
    GameDataManager.SaveData()
end

return SelectScene
