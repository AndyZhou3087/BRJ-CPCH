
require("launcher.config")
require("cocos.init")
require("framework.init")

require("game.events.EventNames")

require("game.config.GameConfig")
require("game.config.PaymentConfig")
require("game.config.RoleLelelConfig")
require("game.config.RoleConfig")
require("game.config.SelectLevelConfig")
require("game.config.GoodsConfig")
require("game.config.CoinsConfig")
require("game.config.ObsGroupConfig")
require("game.config.ObstacleConfig")
require("game.config.GoodGroupConfig")
require("game.config.ShopConfig")

PoolManager = require("game.tools.PoolManager")
TimeUtil = require("game.tools.TimeUtil")
GameController = require("game.controller.GameController")
GameDataManager = require("game.data.GameDataManager")
AudioManager = require("game.tools.AudioManager")
LoadResManager = require("game.tools.LoadResManager")
Tools = require("game.tools.Tools")
DataPersistence = require("game.tools.DataPersistence")
SDKUtil = require("game.tools.SDKUtil")

--自定义事件管理类
require("game.events.GameDispatcher"):getInstance()
require("game.controller.UIController").new()

local GameScene = require("game.scenes.GameScene")

local GameApp = class("GameApp", cc.mvc.AppBase)    --继承AppBase：app = self

function GameApp:ctor()
--    GameApp.super.ctor(self)
    GameApp.super.ctor(self,"GameApp","game")    --替换app目录
    
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
    DataPersistence.insertAttribute("user_sign",{signs=0,day=2014,month=8,year=10})
    DataPersistence.insertAttribute("sign_reward",1)
end

function GameApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
--   self:enterScene("GameScene")
    if DataPersistence.init() then
        self:enterScene("MainScene")
    end
end

function GameApp:enterSelectScene(parameters)
    cc.FileUtils:getInstance():addSearchPath("res/")--切换场景时可能删除了资源路径
    self:enterScene("SelectScene")
end

function GameApp:enterGameScene(parameters)
    cc.Director:getInstance():purgeCachedData()
--    self:enterScene("GameScene")
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

return GameApp
