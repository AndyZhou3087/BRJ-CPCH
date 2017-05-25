--[[
对象缓存池类
]]
local PoolManager = {}

local Scheduler = require("framework.scheduler")

--缓存对象数组
local cacheObjs = {}

--增加一个池对象
function PoolManager.addCache(_obj)
    _obj:retain()
    table.insert(cacheObjs,_obj)
end
--获取一个池对象
function PoolManager.getCacheObj()
    if #cacheObjs > 0 then
        return table.remove(cacheObjs)
    end
end
--归还池对象
function PoolManager.giveBack(_obj)
    table.insert(cacheObjs,_obj)
end

--以下为具体游戏缓存不同的对象
local datas={}
function PoolManager.initDatas()
    for key, var in pairs(CACHE_TYPE) do
        datas[var] = {}
	end
end
--缓存游戏元素
--@param1:元素类型
--@param2:元素对象
function PoolManager.putCacheObjByType(_type,_obj)
    local _arr = datas[_type]
    if _arr then
        table.insert(_arr,_obj)
    end
end
--获取缓存游戏元素
--@param1:元素类型
function PoolManager.getCacheObjByType(_type)
    local _arr = datas[_type]
    if _arr then
        local _obj = table.remove(_arr)
        if _obj then
            if _obj.setDisposed then
                _obj:setDisposed(false)
            end
            if _obj.setDestroy then
                _obj:setDestroy(false)
            end
--            if _obj:getParent() then
--                Tools.printDebug("chjh 有父亲")
--                return
--            end
        end
        return _obj
    end
end
----缓存房间怪物元素
----@param1:怪物id
----@param2:怪物对象
--function PoolManager.cacheMonster(_id,_obj)
--    local _monDic = datas[CACHE_TYPE.Monster]
--    if _monDic then
--        local _arr = _monDic[_id]
--        if not _arr then
--            _monDic[_id] = {_obj}
--        else
--            for key, var in pairs(_arr) do
--                if var == _obj then
--                    Tools.printDebug("chjh 插入的有相同的怪物")
--            		return
--            	end
--            end
--            table.insert(_arr,_obj)
--        end
--    end
--end
----获取房间怪物元素
----@param1:怪物id
--function PoolManager.getMonster(_id)
--    local _monDic = datas[CACHE_TYPE.Monster]
--    if _monDic then
--        local _arr = _monDic[_id]
--        if _arr then
--            local _obj = table.remove(_arr)
--            if _obj then
--                _obj:setDisposed(false)
--                return _obj
--            end
--        end
--    end
--end

--清除池对象
function PoolManager.clearCache()
    for key, var in pairs(cacheObjs) do
        var:release()
    end
    cacheObjs = {}
    for key, var in pairs(datas) do
        for key2, var2 in pairs(var) do
            local _body = var2:getPhysicsBody()
            if _body then
                _body:release()
            end
            if var2.moveHandler then
                Scheduler.unscheduleGlobal(var2.moveHandler)
                var2.moveHandler = nil
            end
            var2:release()
        end
        datas[key] = {}
--        if key == CACHE_TYPE.Monster then
--            for key2, var2 in pairs(var) do
--                for key3, var3 in pairs(var2) do
--                    var3:release()
--                end
--                var2 = {}
--            end
--        else
--            for key2, var2 in pairs(var) do
--                local _body = var2:getPhysicsBody()
--                if _body then
--                    _body:release()
--                end
--                var2:release()
--            end
--            datas[key] = {}
--        end
    end
end

PoolManager.initDatas()
return PoolManager