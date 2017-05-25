--[[
工具类
]]
local Tools = {}

local Scheduler = require("framework.scheduler")

-- 秒转时分秒 Tools.secToFromat(91) 返回 "00:01:31"
function Tools.secToFromat(sec)
    local h,lastT = math.modf(sec/60/60);
    local mTemp = math.modf(sec/60);
    local m = mTemp%60;
    local s = sec%60;
    return Tools.numTo0Fromat(h, 2)..":"..Tools.numTo0Fromat(m, 2)..":"..Tools.numTo0Fromat(s, 2)
end

--转换为分秒
function Tools.secToFromat2(sec)
	local mTemp = math.modf(sec/60);
	local m = mTemp%60;
	local s = sec%60;
	return Tools.numTo0Fromat(m,2)..":"..Tools.numTo0Fromat(s, 2)
end

-- 位数不足用0补齐,如：Tools.numTo0Fromat(82, 4) 返回 "0082"
function Tools.numTo0Fromat(value, len)
    local strValue = tostring(value);
    if string.len(strValue)>=len then
        return strValue;
    else
        local last0len = len - string.len(strValue);
        local last0str = string.rep("0", last0len);
        return last0str..strValue
    end
end

--获取程序启动运行的时间以秒为单位
function Tools.getSysTime()
    return os.clock()
end

--延迟调用函数
function Tools.delayCallFunc(_delayTime,_callFunc)
    return Scheduler.performWithDelayGlobal(_callFunc,_delayTime)
end

--创建华康海报体文本
function Tools.newHuaKangLable(_options)
    _options.font = Tools.Font_HuaKangHB_Path
    return display.newTTFLabel(_options)
end

--截取table数组
function Tools.subTables(_arr,_num)
    local _res = {}
    _num = _num>#_arr and #_arr or _num
    for i=1, _num do
        table.insert(_res,i,_arr[1])
        table.remove(_arr,1)
    end
    return _res
end
--检测元素是否在table数组或字典里
--@param1:待检测元素
--@param2:目标数组字典
--@return:有的话返回元素所在索引，没有则返回nil
function Tools.checkInTables(_element,_arr)
    for key, var in pairs(_arr) do
        if _element == var then
    		return key
    	end
    end
    return
end

--获取文件名  
function Tools.stripPath(filename)  
    return string.match(filename, ".+/([^/]*%.%w+)$") -- *nix system  
        --return string.match(filename, “.+\\([^\\]*%.%w+)$”) — *nix system  
end

function Tools.printDebug(...)
	if PrintDebug then
        print(...)
	end
end

function Tools.StringToComma(count)
    local mCount = 0;
    if count >= 1000000 then
        local str1 = math.floor(count / 1000000);
        local str2 = count % 1000000;
        local str3 = math.floor(str2 / 1000);
        local str4 = str2 % 1000;
        if str3 < 10 then
            str3 = "00"..str3;
        elseif str3 < 100 then
            str3 = "0"..str3;
        end
        if str4 < 10 then
            str4 = "00"..str4;
        elseif str4 < 100 then
            str4 = "0"..str4;
        end
        mCount = str1..","..str3..","..str4;
    elseif count >= 1000 then
        local str1 = math.floor(count / 1000);
        local str2 = count % 1000;
        if str2 < 10 then
            str2 = "00"..str2;
        elseif str2 < 100 then
            str2 = "0"..str2;
        end
        mCount = str1..","..str2;
    else
        mCount = count;
    end
    return mCount;
end

--通过sep符号来分离str
--@param1:字符串
--@param2:分隔符，如：“|”
function Tools.Split(str, sep)
    local str = tostring(str)
    local fields = {}
    str:gsub("[^"..sep.."]+", function(c) fields[#fields+1] = c end)
    return fields;
end

return Tools