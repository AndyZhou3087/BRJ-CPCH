--[[
音效管理类
]]
local AudioManager = {}

AudioManager.Music_Path = "music/"
--AudioManager.Music_Suffix = ".ogg"

--背景音乐类型
AudioManager.Ground_Music_Type=
    {
        --logo背景音乐
        Logo_Bg = "logo.mp3",
        --片头动画背景音乐
        PreScene_Bg = "pre_scene.mp3",
        --主城背景音乐
        Music_Bg = "login.mp3",
        --战斗场景音乐
        Fight_Bg = "level.mp3",
        --怪物来袭背景音乐
        Mon_Raid = "mon_raid.mp3",
        --游戏胜利背景音乐
        Game_Win_Bg = "game_win.mp3",
        --游戏失败背景音乐
        Game_Lose_Bg = "game_lose.mp3",
        --关卡结算前功能解锁背景音乐
        Func_Unlock_Bg = "func_unlock.mp3"
    }
--音效类型
AudioManager.Sound_Effect_Type=
    {
        Button_Click_Sound = "button.ogg",--按钮点击
        UI_Open_Sound = "switch.ogg",   --界面打开时
        UI_Close_Sound = "back.ogg",    --点击界面关闭
        Player_Up_Lv = "intensify.ogg",  --角色升级
        Scene_Bomb = "boom.ogg",   --场景中爆炸
        Player_Scale = "small.ogg",  --角色缩小
        Player_Normal_Step = "step.ogg",  --角色正常跑步
        Bullet_Sound = "biu.ogg",  --子弹发射
--        Monster_Dead_Sound = "die.ogg",  --怪物死亡
        Missile_Warning_Sound="warning.ogg",   --导弹出现提示音
        Missile_Sound="missile.ogg",        --导弹飞行
        Slider_Sound="banana.ogg",  --滑行
        Portal_Sound="portal.ogg",   --传送
        Dip_Sound="dip.ogg",    --冲刺
        Laser_Sound="laser.ogg",   --激光
        Back_Sound="back.ogg", -- 返回
        Unlock_Sound="unlock.ogg",   --关卡解锁
        Boxopen_Sound="boxopen.ogg",  --打开宝箱
        Score_Sound = "score.ogg",    --分数结算
        Pause_Sound = "pause.ogg",    --读秒
        Netime_Sound = "netime.ogg",  --时间关卡（时间不足）
        Buy_Sound = "buy.ogg",          --购买道具成功的声音
        Star_Sound = "star.ogg",        --闯关星星的声音
        Goods_Get_Sound="goods_get.ogg",      --场景获得道具
        Gold_Get_Sound="gold_get.ogg",  --获得金币
        Diamond_Get_Sound="diamond_get.ogg", --获得钻石
        Player_Big_Sound="big_step.ogg",    --重脚步声
        Floor_Sound1="floor1.ogg",    --地板碎块儿音效,程序随机一种
        Floor_Sound2="floor2.ogg",
        Floor_Sound3="floor3.ogg",
        Drop_Sound="drop.ogg",  --物体落地
        Role_Sound1="role_01.ogg",  --角色1声音
        Role_Sound2="role_02.ogg" , --角色2声音
        Role_Sound3="role_03.ogg" , --角色3声音
        Role_Sound4="role_04.ogg",  --角色4声音
        Rocket_Sound = "rocket.ogg",  --火箭声音
        Rocket_Pre_Sound = "rocket_pre.ogg", --火箭启动声音
        Shout_Sound1="lvjr1.ogg",     --绿巨人吼叫
        Shout_Sound2="lvjr2.ogg",       --绿巨人吼叫
        Die_Sound="death.ogg",   --死亡
        Task_Over_Sound = "rwwancheng.ogg" , --任务完成
        --普通楼层提示音效
        Task_Title_Sound = "tishi.ogg",    --任务提示
        Pet_PreSkill_Sound = "cw.ogg",   --宠物释放技能前声音
        Blot_Skill_Sound = "blot.ogg",  --雷电技能声音
        Star_Sound1="star_1.ogg"     ,      --星星1的声音
        Star_Sound2="star_2.ogg"      ,      --星星2的声音
        Star_Sound3="star_3.ogg"      ,      --星星3的声音
        Star_Fight_Sound="star_fight.ogg",   --战斗中的星星音效 
 
        Jump_High_Sound="jump.ogg",     --角色跳到至高点时的音效
        --以下为怪物受击时几种音效，程序会随机一个播放
        Mon_Hit_Sound1 = "mon_hit1.ogg",
        Mon_Hit_Sound2 = "mon_hit2.ogg",
        Mon_Hit_Sound3 = "mon_hit3.ogg",
        Mon_Hit_Sound4 = "mon_hit4.ogg",
        --成功使用主动道具音效
        Use_Act_Goods = "act_goods.ogg",
        --宠物进阶音效
        Pet_Up_Step = "up_step.ogg",
        --代步机音效
--        Dai_Bu = "baibu.ogg",
        --代步机起跳音效
 --       Dai_Bu_Up = "daibu_up.ogg",
--        --关卡结算解锁图标动画音效
--        Level_Ulock_Icon = "level_unlock_icon.ogg",
        --场景获得生命音效
        Life_Get = "life_get.ogg",
        --楼板破损音效
        Floor_Damage = "floor_damage.ogg",
        --楼层强制提示音效
        Force_Tips = "force_tip.ogg",
    }

--游戏战斗中的音效，加此项是为了在游戏中弹出界面时要屏蔽战斗音效
local fightSoundOff = false --战斗音效是否处于关闭中
local fightSound={}
fightSound[AudioManager.Sound_Effect_Type.Scene_Bomb] = 1
fightSound[AudioManager.Sound_Effect_Type.Player_Scale] = 1
fightSound[AudioManager.Sound_Effect_Type.Player_Normal_Step] = 1
fightSound[AudioManager.Sound_Effect_Type.Bullet_Sound         ] = 1
--fightSound[AudioManager.Sound_Effect_Type.Monster_Dead_Sound   ] = 1
fightSound[AudioManager.Sound_Effect_Type.Missile_Warning_Sound] = 1
fightSound[AudioManager.Sound_Effect_Type.Missile_Sound        ] = 1
fightSound[AudioManager.Sound_Effect_Type.Slider_Sound         ] = 1
fightSound[AudioManager.Sound_Effect_Type.Portal_Sound         ] = 1
fightSound[AudioManager.Sound_Effect_Type.Dip_Sound            ] = 1
fightSound[AudioManager.Sound_Effect_Type.Laser_Sound          ] = 1
fightSound[AudioManager.Sound_Effect_Type.Gold_Get_Sound       ] = 1
fightSound[AudioManager.Sound_Effect_Type.Player_Big_Sound     ] = 1
fightSound[AudioManager.Sound_Effect_Type.Floor_Sound1         ] = 1
fightSound[AudioManager.Sound_Effect_Type.Floor_Sound2         ] = 1
fightSound[AudioManager.Sound_Effect_Type.Floor_Sound3         ] = 1
fightSound[AudioManager.Sound_Effect_Type.Drop_Sound           ] = 1
fightSound[AudioManager.Sound_Effect_Type.Rocket_Sound         ] = 1
fightSound[AudioManager.Sound_Effect_Type.Rocket_Pre_Sound     ] = 1
fightSound[AudioManager.Sound_Effect_Type.Shout_Sound1         ] = 1
fightSound[AudioManager.Sound_Effect_Type.Shout_Sound2         ] = 1
fightSound[AudioManager.Sound_Effect_Type.Pet_PreSkill_Sound] = 1
fightSound[AudioManager.Sound_Effect_Type.Blot_Skill_Sound] = 1
--fightSound[AudioManager.Sound_Effect_Type.Dai_Bu] = 1
--fightSound[AudioManager.Sound_Effect_Type.Dai_Bu_Up] = 1

--循环音效记录表
AudioManager.Sound_Mark={}

--预加载音乐文件
function AudioManager.preLoadMusic(_musicType)
    audio.preloadMusic(AudioManager.Music_Path.._musicType)
end

--预加载音效文件
function AudioManager.preLoadSound(_musicType)
    audio.preloadSound(AudioManager.Music_Path.._musicType)
end
function AudioManager.unLoadSound(_musicType)
    audio.unloadSound(AudioManager.Music_Path.._musicType)
end

--播放背景音乐
--_musicType音乐类型
--_isLoop是否循环
--_force强制播放
function AudioManager.playGroundMusic(_musicType,_isLoop,_force)
    _isLoop = _isLoop or false
    audio.playMusic(AudioManager.Music_Path.._musicType,_isLoop)
    if GameDataManager.isMusicOpen()==false and (not _force) then
        audio.pauseMusic()
    end
end
--暂停背景音乐
function AudioManager.pauseMusic()
    if GameDataManager.isMusicOpen() then
        audio.pauseMusic()
	end
end
--恢复暂停的背景音乐
function AudioManager.resumeMusic()
    if GameDataManager.isMusicOpen() then
        audio.resumeMusic()
    end
end

--播放音效
--_soundType音效类型
--_isLoop是否循环
function AudioManager.playSoundEffect(_soundType,_isLoop)
    if fightSoundOff and fightSound[_soundType] then
        return
    end
    _isLoop = _isLoop or false
    if _isLoop==true then
        local markObj = AudioManager.Sound_Mark[_soundType]
        if markObj==nil or markObj.num==0 then
            if GameDataManager.isSoundOpen() then
                AudioManager.Sound_Mark[_soundType]={num=1,handler=audio.playSound(AudioManager.Music_Path.._soundType,_isLoop)}
            else
                AudioManager.Sound_Mark[_soundType]={num=1}
            end
        else
            markObj.num=markObj.num+1
        end
    else
        if GameDataManager.isSoundOpen() then
            local markObj = AudioManager.Sound_Mark[AudioManager.Sound_Effect_Type.Rocket_Sound]
            if markObj and markObj.num>0 then
                --播放火箭音效时不播放其它音效
                return
            end
            audio.playSound(AudioManager.Music_Path.._soundType,_isLoop)
        end
    end

end

--设置战斗音效是否生效，true生效，flase不生效
function AudioManager.setFightSoundEnable(_enable)
    --    _enable = _enable or true
    fightSoundOff = not _enable
    if GameDataManager.isSoundOpen() then
        if _enable then
            audio.resumeAllSounds()
        else
            audio.pauseAllSounds()
        end
    end
end

function AudioManager.stopSoundEffect(_soundType)
    local markObj = AudioManager.Sound_Mark[_soundType]
    if markObj and markObj.num>0 then
        markObj.num=markObj.num-1
        if markObj.num<=0 then
            markObj.num = 0
            if GameDataManager.isSoundOpen() then
                audio.stopSound(markObj.handler)
            end
        end
    end
end


--[[
停止声音
默认控制音乐和音效
@param   type 1:仅控制音乐           2:仅控制音效
]]
function AudioManager.stop(type)
    --    if GameController.isInPause() then
    --        return
    --    end
    --	audio.stopMusic()
    if type==nil then
        audio.pauseMusic()
        audio.stopAllSounds()

        GameDataManager.setMusic(false)
        GameDataManager.setSound(false)
    elseif type==1 then
        audio.pauseMusic()
        GameDataManager.setMusic(false)
    elseif type==2 then
        audio.stopAllSounds()
        GameDataManager.setSound(false)
    end
end


--[[
打开声音
默认控制音乐和音效
@param   type 1:仅控制音乐           2:仅控制音效
]]
function AudioManager.open(parameters)
    --	for key,value in pairs(AudioManager.Music_Mark) do
    --        value.handler=audio.playMusic(AudioManager.Music_Path..key,true)
    --	end
    if GameController.isInPause() then
        return
    end
    if parameters==nil then
        GameDataManager.setMusic(true)
        audio.rewindMusic()

        GameDataManager.setSound(true)
        for key,value in pairs(AudioManager.Sound_Mark) do
            if value.num>0 then
                value.handler=audio.playSound(AudioManager.Music_Path..key,true)
            end
        end
    elseif parameters==1 then
        GameDataManager.setMusic(true)
        audio.rewindMusic()
    elseif parameters==2 then
        GameDataManager.setSound(true)
        for key,value in pairs(AudioManager.Sound_Mark) do
            if value.num>0 then
                value.handler=audio.playSound(AudioManager.Music_Path..key,true)
            end
        end
    end
end


function AudioManager.clear(_soundType)
    local markObj = AudioManager.Sound_Mark[_soundType]
    if markObj and markObj.num>0 then
        if GameDataManager.isSoundOpen() and markObj.handler then
            audio.stopSound(markObj.handler)
        end
        markObj.num=0

        --        if markObj.num>0 then
        --            if GameDataManager.isSoundOpen() then
        --                audio.stopSound(markObj.handler)
        --            end
        --        end
        --        markObj.num=0
    end
end

function AudioManager.clearAll()
    audio.stopAllSounds()
    AudioManager.Sound_Mark={}
end

return AudioManager