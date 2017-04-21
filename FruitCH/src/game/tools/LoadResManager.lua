--[[
资源加载管理类
]]
local LoadResManager = {}
local PreLoadType = 
    {
        Animation=1,--动画类型
        Sound=2,--声音类型
        Texture=3,--图片类型
    }
--战斗中预加载资源
local fightRes = {
--    {type = PreLoadType.Texture,plist="map/room/room.plist",png="map/room/room.png"},
--    {type = PreLoadType.Texture,plist="map/room/obstacle.plist",png="map/room/obstacle.png"},
    {type = PreLoadType.Animation,plist="role/nv_pao0.plist",png="role/nv_pao0.png",json="role/nv_pao.ExportJson"},
    {type = PreLoadType.Animation,plist="role/chongci0.plist",png="role/chongci0.png",json="role/chongci.ExportJson"},
    {type = PreLoadType.Animation,plist="role/nan30.plist",png="role/nan30.png",json="role/nan3.ExportJson"},
    {type = PreLoadType.Animation,plist="role/nan40.plist",png="role/nan40.png",json="role/nan4.ExportJson"},
    {type = PreLoadType.Animation,plist="role/nan50.plist",png="role/nan50.png",json="role/nan5.ExportJson"},
    {type = PreLoadType.Animation,plist="role/nan60.plist",png="role/nan60.png",json="role/nan6.ExportJson"},
    {type = PreLoadType.Animation,plist="armature/xiaoshi0.plist",png="armature/xiaoshi0.png",json="armature/xiaoshi.ExportJson"},
    {type = PreLoadType.Animation,plist="armature/nan5fp0.plist",png="armature/nan5fp0.png",json="armature/nan5fp.ExportJson"},
    {type = PreLoadType.Animation,plist="armature/tanh0.plist",png="armature/tanh0.png",json="armature/tanh.ExportJson"},
    {type = PreLoadType.Animation,plist="armature/xitieshi0.plist",png="armature/xitieshi0.png",json="armature/xitieshi.ExportJson"},
    {type = PreLoadType.Animation,plist="armature/dc0.plist",png="armature/dc0.png",json="armature/dc.ExportJson"},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Button_Click_Sound},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Dart_Sound},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Diamond_Cost},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Get_Prop_Sound},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.GetGold_Sound},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Jump_Sound},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Magnet_Sound},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Player_Up_Lv},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.RoleMan_Dead},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.RoleWomen_Dead},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Sprint_Sound},
    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Win_Sound},
}

--加载战斗场景资源
function LoadResManager.toLoadFightRes(_completeFunc)
    local curFightRes = clone(fightRes)
    local function toLoadRes(parameters)
        if #curFightRes == 0 then
            if _completeFunc then
                _completeFunc()
            end
        else
            local resObj = table.remove(curFightRes,1)
            if resObj then
                if resObj.type == PreLoadType.Texture then
                    display.addSpriteFrames(resObj.plist,resObj.png)
                    Tools.delayCallFunc(0.01,function()
                        toLoadRes()
                    end)
                elseif resObj.type == PreLoadType.Animation then
                    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(resObj.png,resObj.plist,resObj.json)
                    Tools.delayCallFunc(0.01,function()
                        toLoadRes()
                    end)
                elseif resObj.type == PreLoadType.Sound then
                    AudioManager.preLoadSound(resObj.sound)
                    Tools.delayCallFunc(0.01,function()
                        toLoadRes()
                    end)
                end
            end
        end
    end
    toLoadRes()
end
--卸载战斗场景加载的资源
function LoadResManager.toUnloadFightRes()
    for key, var in pairs(fightRes) do
        if var.type == PreLoadType.Texture then
            display.removeSpriteFramesWithFile(var.plist,var.png)
        elseif var.type == PreLoadType.Animation then
            ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo(var.json)
        elseif var.type == PreLoadType.Sound then
            AudioManager.unLoadSound(var.sound)
        end
    end
end

return LoadResManager