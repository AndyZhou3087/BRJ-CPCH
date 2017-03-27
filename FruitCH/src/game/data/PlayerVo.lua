--[[
人物数据
]]
local PlayerVo = 
{
    m_roleId = 0,   --角色id
    m_modelId = 0,   --角色模型id
    m_level = 0,      --等级
    m_hp = 1,     --血量
    m_att = 1,           -- 攻击力
    m_sprintTime = 0,   --冲刺时间,单位：秒
    m_magnetTime = 0,   --磁铁时间,单位：秒
    m_giantTime = 0,   --巨人时间,单位：秒
    m_transTime=0,     --转换时间 (s)
    m_cloudTime=0,     --浮云时间(s)

}

return PlayerVo