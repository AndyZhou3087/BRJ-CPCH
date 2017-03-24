--[[
    数据持久化工具
]]
local DataPersistence = {}
local GameState = require(cc.PACKAGE_NAME..".cc.utils.GameState")
local GameData = {}
function DataPersistence.init()
    local openUDID = device.getOpenUDID()
    Tools.printDebug("chjh openudid="..openUDID)
    GameState.init(function(_param)
        local returnValue=nil
        if _param.errorCode then
            Tools.printDebug("chjh gamestate init error")
            if _param.errorCode == GameState.ERROR_STATE_FILE_NOT_FOUND then
            	return true
            end
            return false
        else
            -- crypto
            if _param.name=="save" then
                local str=json.encode(_param.values)
                str=crypto.encryptXXTEA(str, "chjh_tysoul")
                returnValue={data=str}
                Tools.printDebug("chjh gamestate save")
            elseif _param.name=="load" then
                local str=crypto.decryptXXTEA(_param.values.data, "chjh_tysoul")
                returnValue=json.decode(str)
                Tools.printDebug("chjh gamestate load")
                for key, var in pairs(returnValue) do
                	GameData[key] = var
                end
            end
        end
        return returnValue
    end,"stdata.data",openUDID)
    return GameState.load()
end

--解析持久化数据
function DataPersistence._parserData(parameters)
	Tools.printDebug("chjh 解析持久化数据")
end
--插入字段
--@param1:属性名
--@param2:属性默认值
function DataPersistence.insertAttribute(_attrName,_attrValue)
    assert(nil==GameData[_attrName],"chjh DataPersistence:error 持久华数据已经存在所要插入的字段attrName=".._attrName)
    GameData[_attrName] = _attrValue
end
--更新属性值
--@param1:属性名
--@param2:属性值
function DataPersistence.updateAttribute(_attrName,_attrValue)
    assert(nil~=GameData[_attrName],"chjh DataPersistence:error 找不到所要更新的字段attrName=".._attrName)
    GameData[_attrName] = _attrValue
end

--根据属性名获取对应的属性值
function DataPersistence.getAttribute(_attrName)
    assert(nil~=GameData[_attrName],"chjh DataPersistence:error 找不到所要获取的字段attrName=".._attrName)
    return GameData[_attrName]
end

--进行数据持久华（存盘）
--在游戏退出时调用进行数据存盘
function DataPersistence.toSaveData()
    GameState.save(GameData)
end

return DataPersistence