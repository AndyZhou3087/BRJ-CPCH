--[[
人物数据
]]
local PlayerVo = 
{
    m_roleId = 0,   --角色id
    m_modelId = 0,   --角色模型id
    m_level = 0,      --等级
    m_nick = "",        --昵称
    m_lifeNum = 1,  --生命数量
    m_speed = 0,    --移动速度

    m_sprintTime = 0,   --冲刺时间
    m_magnetTime = 0,   --磁铁时间
    m_invincibleTime = 0,   --无敌时间
    m_time_ex = 0,  --额外增加的时间
    m_rocketTime = 0,    --普通火箭时间
    m_superRocketTime = 0,  --超级火箭时间
    
    m_sprintTimeAdd=0,     --冲刺时间延长 (s)
    m_invincibleTimeAdd=0,     --无敌时间延长(s)
    m_protectTimeAdd=0,       --护盾时间延长(s)
}

return PlayerVo