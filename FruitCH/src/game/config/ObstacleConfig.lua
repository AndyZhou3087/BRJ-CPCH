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
        dispx = 300,   --与角色相距多少像素时出现(单位：像素)
        speed = 2,   --飞行速度，即固定距离飞行的时间(单位：秒)
    }
    
ObstacleConfig[4]=
    {
        id = 4,
        type = OBSTACLE_TYPE.special,    --障碍类型
        isAnimate = true,           --是否为动画资源
        armatureName = "muban_tanhuang",
        res = "ui/obscale_1.png",     --资源路径
        att = 1,
    }
    