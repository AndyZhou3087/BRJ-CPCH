
require("launcher.config")
require("cocos.init")
require("framework.init")

require("game.events.EventNames")

require("game.config.GameConfig")
require("game.config.RoomsBgConfig")
require("game.config.RoomGoodsConfig")
require("game.config.OrnamentsConfig")
require("game.config.CoinsConfig")
require("game.config.MapGroupConfig")
require("game.config.PaymentConfig")
require("game.config.RoleConfig")
require("game.config.GoodsConfig")
require("game.config.ShopConfig")
require("game.config.SignRewardConfig")
require("game.config.GiftConfig")

PoolManager = require("game.tools.PoolManager")
TimeUtil = require("game.tools.TimeUtil")
GameController = require("game.controller.GameController")
GameDataManager = require("game.data.GameDataManager")
AudioManager = require("game.tools.AudioManager")
LoadResManager = require("game.tools.LoadResManager")
Tools = require("game.tools.Tools")
DataPersistence = require("game.tools.DataPersistence")
SDKUtil = require("game.tools.SDKUtil")

local Alert = require("game.view.dialog.Dialog")

--自定义事件管理类
require("game.events.GameDispatcher"):getInstance()
require("game.controller.UIController").new()

local GameScene = require("game.scenes.GameScene")

local GameApp = class("GameApp", cc.mvc.AppBase)    --继承AppBase：app = self

function GameApp:ctor()
    GameApp.super.ctor(self,"GameApp","game")    --替换app目录
    
    DataPersistence.insertAttribute("user_gold",InitGold)    --金币
    DataPersistence.insertAttribute("user_diamond",InitDiamond)  --钻石
    DataPersistence.insertAttribute("user_score",10)    --玩家积分

    --音乐、音效
    DataPersistence.insertAttribute("music",true)
    DataPersistence.insertAttribute("sound",true)

    DataPersistence.insertAttribute("cur_roleID",1)      --当前使用角色id
    DataPersistence.insertAttribute("modle_list",{ModleVo={roleId =1,isOwn = true,roleLv = 1},})    --已经解锁的角色模型列表，元素为ModleVo

    --物品相关
    DataPersistence.insertAttribute("goods_list",{})    --拥有物品列表，列表元素为GoodsVo

    --体力相关
--    DataPersistence.insertAttribute("recover_power_endTime",0) --距体力回满结束时间戳

    --设置签到
--    DataPersistence.insertAttribute("user_sign",{signs=0,day=10,month=8,year=2014})
--    DataPersistence.insertAttribute("sign_reward",1)

    --角色礼包每日领奖
--    DataPersistence.insertAttribute("rolegift",{})

    --vip礼包每日领奖
--    DataPersistence.insertAttribute("vipgift",{})
end

function GameApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    if DataPersistence.init() then
        self:enterScene("MainScene")
    end
end

function GameApp:enterGameScene(parameters)
    cc.Director:getInstance():purgeCachedData()
    Tools.delayCallFunc(0.01,function()
        self.m_fightScene = GameScene.new(handler(self,self.checkEnterFight))
        --物理场景太二了，不加retain会立马给我清除了
        self.m_fightScene:retain()
    end)
end

--进入战斗场景
function GameApp:checkEnterFight(parameters)
    if not tolua.isnull(self.m_fightScene) then
        display.replaceScene(self.m_fightScene)
    end
end

--[[弹窗
--@param:
{
type:弹框类型
content:弹框内容
title:弹框标题
okStr:确认按钮文字
cancleStr:取消按钮文字
okFunc:确认回调
cancleFunc:取消回调
isClose:点击确认后就关闭毕弹窗
}
--]]
function GameApp:alert(_params)
    local runScene = display.getRunningScene()
    if not tolua.isnull(self.m_alert) and self.m_alert:getParent()~=runScene then
        self.m_alert:toClose(true)
        self.m_alert = nil
    end
    if tolua.isnull(self.m_alert) then
        self.m_alert = Alert.new(_params.type,_params.okStr,_params.cancleStr,_params.isClose,_params.pType)
        self.m_alert:show(UI_ZORDER.ALERT_ZORDER)
    end
    if _params.title then
        self.m_alert:setTitle(_params.title)
    end
    if _params.content then
        self.m_alert:setContent(_params.content)
    end
    if _params.okFunc then
        self.m_alert:setOkFunc(_params.okFunc)
    end
    if _params.cancleFunc then
        self.m_alert:setCancleFunc(_params.cancleFunc)
    end
    return self.m_alert
end

return GameApp
