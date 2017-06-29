--[[
资源加载管理类
]]
local LoadResManager = {}
local PreLoadType = 
    {
        Animation=1,--动画类型
        Sound=2,--声音类型
        Texture=3,--图片类型
        Animate = 4, --帧动画
    }
--战斗中预加载资源
local fightRes = {
    {type = PreLoadType.Texture,plist="map/Room.plist",png="map/Room.png"},
    {type = PreLoadType.Texture,plist="role/RoleJump1.plist",png="role/RoleJump1.png"},
    {type = PreLoadType.Animate,plist = "role/RoleJump.plist"},
--    {type = PreLoadType.Animation,plist="role/nv_pao0.plist",png="role/nv_pao0.png",json="role/nv_pao.ExportJson"},
--    {type = PreLoadType.Animation,plist="role/chongci0.plist",png="role/chongci0.png",json="role/chongci.ExportJson"},
--    {type = PreLoadType.Animation,plist="role/nan30.plist",png="role/nan30.png",json="role/nan3.ExportJson"},
--    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Button_Click_Sound},
--    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Dart_Sound},
--    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Diamond_Cost},
--    {type = PreLoadType.Sound,sound=AudioManager.Sound_Effect_Type.Get_Prop_Sound},
}

local playerRes = {
    {type = PreLoadType.Texture,plist="role/Role1.plist",png="role/Role1.png"},
    {type = PreLoadType.Texture,plist="role/Role2.plist",png="role/Role2.png"},
    {type = PreLoadType.Texture,plist="role/Role3.plist",png="role/Role3.png"},
    {type = PreLoadType.Texture,plist="role/Role4.plist",png="role/Role4.png"},
    {type = PreLoadType.Texture,plist="role/Role5.plist",png="role/Role5.png"},
    {type = PreLoadType.Texture,plist="role/Role6.plist",png="role/Role6.png"},
    {type = PreLoadType.Texture,plist="role/Role7.plist",png="role/Role7.png"},
    {type = PreLoadType.Texture,plist="role/Role8.plist",png="role/Role8.png"},
    {type = PreLoadType.Texture,plist="role/Role9.plist",png="role/Role9.png"},
    {type = PreLoadType.Texture,plist="role/Role10.plist",png="role/Role10.png"},
    {type = PreLoadType.Animate,plist = "role/RoleAni.plist"},
}

--加载角色动画
function LoadResManager.toLoadPlayerRes(_completeFunc)
    local curPlayerRes = clone(playerRes)
    local function toLoadRes(parameters)
        if #curPlayerRes == 0 then
            if _completeFunc then
                _completeFunc()
            end
        else
            local resObj = table.remove(curPlayerRes,1)
            if resObj then
                if resObj.type == PreLoadType.Texture then
                    display.addSpriteFrames(resObj.plist,resObj.png)
                    Tools.delayCallFunc(0.01,function()
                        toLoadRes()
                    end)
                elseif resObj.type == PreLoadType.Animate then
                    cc.AnimationCache:getInstance():addAnimations(resObj.plist)
                    Tools.delayCallFunc(0.01,function()
                        toLoadRes()
                    end)
                end
            end
        end
    end
    toLoadRes()
end

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
                elseif resObj.type == PreLoadType.Animate then
                    cc.AnimationCache:getInstance():addAnimations(resObj.plist)
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