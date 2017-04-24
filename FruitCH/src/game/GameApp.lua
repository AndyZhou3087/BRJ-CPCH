
require("launcher.config")
require("cocos.init")
require("framework.init")

require("game.events.EventNames")

require("game.config.GameConfig")
require("game.config.MapGroupConfig")
require("game.config.EndlessModeConfig")
require("game.config.ConfigA")
require("game.config.ConfigB")
require("game.config.ConfigC")
require("game.config.ConfigD")
require("game.config.ConfigS")
require("game.config.PaymentConfig")
require("game.config.RoleLelelConfig")
require("game.config.RoleConfig")
require("game.config.SelectLevelConfig")
require("game.config.GoodsConfig")
require("game.config.CoinsConfig")
require("game.config.ObstacleConfig")
require("game.config.ShopConfig")
require("game.config.SelectOtherConfig")
require("game.config.SignRewardConfig")
require("game.config.AchieveConfig")
require("game.config.TaskConfig")
require("game.config.GiftConfig")

PoolManager = require("game.tools.PoolManager")
TimeUtil = require("game.tools.TimeUtil")
GameController = require("game.controller.GameController")
Tables = require("game.tools.Tables")
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
--    GameApp.super.ctor(self)
    GameApp.super.ctor(self,"GameApp","game")    --替换app目录
    
    DataPersistence.insertAttribute("first_into",true)   --是否是初次玩游戏
    
    DataPersistence.insertAttribute("user_gold",2500)    --金币
    DataPersistence.insertAttribute("user_diamond",2500)  --钻石
    DataPersistence.insertAttribute("user_power",5)    --体力
    DataPersistence.insertAttribute("user_score",10)    --玩家积分
    DataPersistence.insertAttribute("record",0)       --存储记录 
    
    --音乐、音效
    DataPersistence.insertAttribute("music",true)
    DataPersistence.insertAttribute("sound",true)
    
    DataPersistence.insertAttribute("cur_roleID",1)      --当前使用角色id
    DataPersistence.insertAttribute("modle_list",{ModleVo={roleId =1,isOwn = true,roleLv = 1},})    --已经解锁的角色模型列表，元素为ModleVo
    
    --关卡相关
    DataPersistence.insertAttribute("fight_data",{})    --战斗数据,列表元素为LevelVo
    
    --物品相关
    DataPersistence.insertAttribute("goods_list",{})    --拥有物品列表，列表元素为GoodsVo
    
    --体力相关
    DataPersistence.insertAttribute("recover_power_endTime",0) --距体力回满结束时间戳
    
    --设置签到
    DataPersistence.insertAttribute("user_sign",{signs=0,day=10,month=8,year=2014})
    DataPersistence.insertAttribute("sign_reward",1)
    
    --设置成就
    DataPersistence.insertAttribute("achieve",{})
    
    --累积使用金币
    DataPersistence.insertAttribute("useGold_total",0)
    --累积使用钻石
    DataPersistence.insertAttribute("useDiamond_total",0)
    --累积使用道具
    DataPersistence.insertAttribute("useGood_total",{})
    
    --设置每日任务
    DataPersistence.insertAttribute("dailyTasks",{})
    --设置是否跨零点
    DataPersistence.insertAttribute("daily_time",{day=10,month=8,year=2014})
    --累计奔跑距离
    DataPersistence.insertAttribute("run_distance",0)
    --累计每日使用道具
    DataPersistence.insertAttribute("day_useGood_total",{})
    --累计获得金币
    DataPersistence.insertAttribute("getGold_total",0)
    
    --角色礼包每日领奖
    DataPersistence.insertAttribute("gift",{})
end

function GameApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    if DataPersistence.init() then
        self:enterScene("MainScene")
    end
end

function GameApp:enterSelectScene(parameters)
    cc.Director:getInstance():purgeCachedData()
    cc.FileUtils:getInstance():addSearchPath("res/")--切换场景时可能删除了资源路径
    self:enterScene("SelectScene")
end

function GameApp:enterMainScene(parameters)
    cc.Director:getInstance():purgeCachedData()
    cc.FileUtils:getInstance():addSearchPath("res/")--切换场景时可能删除了资源路径
    self:enterScene("MainScene")
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
        self.m_alert = Alert.new(_params.type,_params.okStr,_params.cancleStr,_params.isClose)
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
