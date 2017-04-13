--[[
障碍配置表
]]

ObstacleConfig = {}

OBSTACLE_TYPE = 
{
    static = 1,    --固定
    hide = 2,   --隐藏
    fly = 3,    --飞行
    special = 4,    --特殊
    ice = 5,  --冰块障碍物
    spring = 6,  --弹簧
}

ObstacleConfig[1]=
{
    id = 1,
    type = OBSTACLE_TYPE.static,    --障碍类型
    isAnimate = false,           --是否为动画资源
    armatureName = "",
    res = "ui/obscale_1.png",     --资源路径
    att = 1,
}

ObstacleConfig[2]=
    {
        id = 2,
        type = OBSTACLE_TYPE.hide,    --障碍类型
        isAnimate = false,           --是否为动画资源
        armatureName = "",
        res = "ui/obscale_1.png",     --资源路径
        att = 1,
        dispx = 300,   --与角色相距多少像素时出现(单位：像素)
    }
    
ObstacleConfig[3]=
    {
        id = 3,
        type = OBSTACLE_TYPE.fly,    --障碍类型
        isAnimate = false,           --是否为动画资源
        armatureName = "",
        res = "ui/obscale_2.png",     --资源路径
        att = 1,
        dispx = 400,   --与屏幕相距多少像素时出现(单位：像素)
        speed = 2,   --飞行速度，即固定距离飞行的时间(单位：秒)
    }
    
ObstacleConfig[4]=
    {
        id = 4,
        type = OBSTACLE_TYPE.special,    --障碍类型
        isAnimate = true,           --是否为动画资源
        armatureName = "nan5",
        res = "ui/obscale_1.png",     --资源路径
        att = 1,
        dispx = 300,   --与屏幕相距多少像素时出现(单位：像素)
        speed = 3,   --飞行速度，即固定距离飞行的时间(单位：秒)
    }
    
ObstacleConfig[5]=
    {
        id = 5,
        type = OBSTACLE_TYPE.ice,    --障碍类型
        isAnimate = false,           --是否为动画资源
        armatureName = "muban_tanhuang",
        res = "ui/obscale_1.png",     --资源路径
        att = 1,
        cutSpeed = 15,  --此为需要减去的速度值，比如原本32的速度，减去15，速度则为为17
        length = 250,   --滑行距离，单位：px
    }
    
ObstacleConfig[6]=
    {
        id = 6,
        type = OBSTACLE_TYPE.spring,    --障碍类型
        isAnimate = true,           --是否为动画资源
        armatureName = "tanh",
        res = "ui/obscale_3.png",     --资源路径
        att = 1,
    }
    