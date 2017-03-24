--[[
时间操作工具
]]
local TimeUtil = {}

local Scheduler = require("framework.scheduler")

local timeIsOk = false

--服务器消息返回
--服务器时间戳
local timeStamp = 0
--距零点还有多少秒 
local zeroSecs = 0
--日期
local date = {
    year = 2015,
    month = 8,
    day = 26,
    hour = 20,
    min = 4,
    sec = 20,
    week = 3,--周日为0，周一二三...对应1，2，3...
}
local timeHandler

--是否首次init
--@param:成功获取时间回调方法
function TimeUtil.init(_completeHandle)
    if MOBILE_DEBUG then
    	timeIsOk = true
        timeStamp = os.time()
        local _date = TimeUtil.initDate()
        if _date.hour==0 and _date.min==0 and _date.sec==0 then
            TimeUtil._dayChange()
        end
        if not timeHandler then
            timeHandler = Scheduler.scheduleGlobal(TimeUtil._updateTime,1)
        end
        GameDispatcher:dispatch(EventNames.EVENT_NET_TIME_CHANGE)
        if _completeHandle then
            _completeHandle()
        end
        return
    end
    TimeUtil._onResponse()
end

function TimeUtil._onResponse(event,backHandle)
--    local tim = Tools.getSysTime()
--    local request = event.request
    timeIsOk = true
    timeStamp = os.time()
    local _date = TimeUtil.initDate()
    if _date.hour==0 and _date.min==0 and _date.sec==0 then
        TimeUtil._dayChange()
    end
    if not timeHandler then
        timeHandler = Scheduler.scheduleGlobal(TimeUtil._updateTime,1)
    end
    GameDispatcher:dispatch(EventNames.EVENT_NET_TIME_CHANGE)
    if backHandle then
        backHandle()
    end
end

--时间更新
function TimeUtil._updateTime()
    timeStamp = timeStamp + 1
    zeroSecs = zeroSecs - 1
    if zeroSecs <= 0 then
    	Tools.printDebug("chjh 零点触发")
        TimeUtil.initDate()
        TimeUtil._dayChange()
    end
    --printf("zeroSecs=%d",zeroSecs)
end
--跨天变化触发（零点触发）
function TimeUtil._dayChange(parameters)
--    GameDataManager.isDateSign()
    --更新vip礼包
--    GameDataManager.updateVipData()
end

--获取时间戳
function TimeUtil.getTimeStamp()
    return timeStamp
end

--计算距零点秒数
local function countZeroTime()
    local secs = 60-date.sec
    secs = secs + (59 - date.min)*60 
    secs = secs + (23 - date.hour)*3600
    return secs
end
--初始化日期对象
function TimeUtil.initDate()
    local t_table = os.date("*t",timeStamp)
    date.year = t_table.year
    date.month = t_table.month
    date.day = t_table.day
    date.hour = t_table.hour
    date.min = t_table.min
    date.sec = t_table.sec
    date.week = t_table.wday-1
    zeroSecs = countZeroTime()
    return date
end

--[[获取日期
--返回日期对象
date:{
    year = 2015,
    month = 8,
    day = 26,
    hour = 20,
    min = 4,
    sec = 20,
    week = 3,--周日为0，周一二三...对应1，2，3...
}
]]
function TimeUtil.getDate()
    return TimeUtil.initDate()
end

--服务器时间是否获取ok
function TimeUtil.isTimeOk(parameters)
    return timeIsOk
end

return TimeUtil