--游戏公用配置文件

--测试输出
PrintDebug = true

GroupSize = cc.size(960,540)   --每一组配置的大小
--初始金币和钻石
InitGold = 2000
InitDiamond = 20

--移动速度帧率
FrameTime = 0.01

DefaultSpeed = 32
--移动速度
MoveSpeed = 0

--地图背景资源
GameBgRes = "Common/GameBg.jpg"

--前期无障碍缓存距离，单位：像素
CacheDis = 200

--1m=32px(1米=32像素)
--每秒移动像素
Pixel = 320
--每秒路程，单位:米
Miles = 10

--金币移动速度
GOLD_SPEED=40

--地图当前ZOder
MAP_ZORDER_MAX=0

--阴影程度
OPACITY=160

--商城是否打开
OPEN_SHOP = false

--是否处于新手引导中（战斗引导结束后的结算界面，和战斗准备界面）
GUIDE_ING = false

MAP_GROUP_INIT_NUM = 2    --初始化组合数

--角色保护时间（单位：秒）
GuardTime = 3

--分辨率
--RESOLUTION_TYPE = 
--{
--    phone = 1,
--    pad = 2,
--}
--GAME_RESOLUTION_CONTROL = RESOLUTION_TYPE.phone

--游戏类型
GAME_TYPE = 
    {
        LevelMode = 1 , --关卡模式
        EndlessMode = 2 , --无尽模式
    }
--游戏类型控制
GAME_TYPE_CONTROL = GAME_TYPE.LevelMode

GAMEOVER_TYPE =
{
    Win = 1,
    Fail = 2,
}

--弹窗类型
Alert_Type=
    {
        Type_One = 1,   --只有一个按钮
        Type_Two = 2    --两个按钮
    }

--界面层级配置
UI_ZORDER =
    {
        CLIP_ZORDER = 5,  --遮罩层级
        VIEW_ZORDER = 10,  --普通界面层级
        ALERT_ZORDER = 20,  --弹框界面层级
        TIPS_ZORDER = 30,  --提示信息层级
        DEBUG_ZORDER = 40,  --调试信息容器层级
    }


--元素tag定义
ELEMENT_TAG=
    {
        PLAYER_TAG = 1,  --角色
        Edge_Top = 2,  --上边界
        Edge_Down = 3,  --下边界
        OBSTACLE = 4,    --障碍
        GOLD_TAG = 5,   --金币
        GOOD_TAG = 6,    --道具
    }

--缓存元素类型
CACHE_TYPE=
    {
        Coin = 1,
        Sliver = 2,
        Copper = 3,
    }
