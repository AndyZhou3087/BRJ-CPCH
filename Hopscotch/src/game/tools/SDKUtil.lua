--[[
SDK工具类
]]
local SDKUtil = {}

SDKUtil.PayResult=
{
        Success = "success",
        Fail = "fail",
}

SDKUtil.EventId = 
{
    Sign = "Sign",
    GiftPop = "GiftPop",
    GiftBuy = "GiftBuy",
    DiamondBuy = "DiamondBuy",
    PowerBuy = "PowerBuy",
    Endless = "Endless",  --无尽模式
    GuideStart = "GuideStart",
        GuideFinish = "GuideFinish",
        RoleMax = "RoleMaxLevel",
        RoleUpgrade = "RoleUpgrade",
}

local UMPaySource = 21 --友盟付费来源，友盟后台定义21代表爱贝支付

local luaj,luaoc

if device.platform == "android" then
    luaj = require("framework.luaj")
elseif device.platform == "ios" then
    luaoc = require("framework.luaoc")
end

local className = "com/kxx/util/Util"
--pay方法(int goodsId,String orderId,int callFunc)
local methodName = "pay"

--调用平台支付方法
--_data:{goodsId=xx,orderId=xx,callback=xx}
function SDKUtil.toPay(_data)
    local params = {_data.goodsId,_data.orderId,_data.callback}
    local sigs = "(Ljava/lang/String;Ljava/lang/String;I)V"
	if luaj then
        luaj.callStaticMethod(className,methodName,params,sigs)
		return
	end
    if luaoc then
        luaoc.callStaticMethod(className,methodName,params,sigs)
        return
	end
    _data.callback(SDKUtil.PayResult.Success)
end

--获取唯一订单id
function SDKUtil.getOrderId(_goodsId)
    _goodsId = _goodsId or math.random(1,10000)
    return "20170310"..tostring(_goodsId)..TimeUtil.getTimeStamp()..os.clock()..math.random(1,10000)
end

--调用友盟付费计录
function SDKUtil.umentPay(_cost,_diamonds)
    local params = {_cost,_diamonds,UMPaySource}
    local sigs = "(III)V"
    if luaj then
        luaj.callStaticMethod(className,"umengPay",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"umengPay",params,sigs)
        return
    end
end
--_cost花费金额
--_item物品名称或id
--_num物品数量
--单个物品钻石价值
function SDKUtil.umentPayEx(_cost,_item,_num,_diamonds)
    local params = {_cost,_item,_num,_diamonds,UMPaySource}
    local sigs = "(ILjava/lang/String;III)V"
    if luaj then
        luaj.callStaticMethod(className,"umengPay",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"umengPay",params,sigs)
        return
    end
end

--虚拟消费统计
--item 购买物品的ID 
--number 购买物品数量 
--price 购买物品的单价(虚拟币)
function SDKUtil.umentBuy(item,number,price)
    local params = {item,number,price}
    local sigs = "(Ljava/lang/String;II)V"
    if luaj then
        luaj.callStaticMethod(className,"umentBuy",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"umentBuy",params,sigs)
        return
    end
end

--item 购买物品的ID 
--number 购买物品数量 
--price 购买物品的单价(虚拟币)
function SDKUtil.umentUse(item,number,price)
    local params = {item,number,price}
    local sigs = "(Ljava/lang/String;II)V"
    if luaj then
        luaj.callStaticMethod(className,"umentUse",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"umentUse",params,sigs)
        return
    end
end

--item 奖励物品ID 
--num 奖励物品数量 
--price 物品的虚拟币单价 
--trigger 触发奖励的事件, 取值在 1~10 之间，“1”已经被预先定义为“系统奖励”， 2~10 需要在网站设置含义。
function SDKUtil.umentBonus(item,number,price,trigger)
    local params = {item,number,price,trigger}
    local sigs = "(Ljava/lang/String;III)V"
    if luaj then
        luaj.callStaticMethod(className,"umentBonus",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"umentBonus",params,sigs)
        return
    end
end

--eventId 自定义事件ID 
function SDKUtil.umentOnEvent(eventId)
    local params = {eventId}
    local sigs = "(Ljava/lang/String;)V"
    if luaj then
        luaj.callStaticMethod(className,"umentOnEvent",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"umentOnEvent",params,sigs)
        return
    end
end

--友盟开启新关卡统计
function SDKUtil.umentStartLevel(_level)
    local params = {_level}
    local sigs = "(I)V"
    if luaj then
        luaj.callStaticMethod(className,"umentStartLevel",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"umentStartLevel",params,sigs)
        return
    end
end

--友盟新关卡成功
function SDKUtil.umentFinishLevel(_level)
    local params = {_level}
    local sigs = "(I)V"
    if luaj then
        luaj.callStaticMethod(className,"umentFinishLevel",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"umentFinishLevel",params,sigs)
        return
    end
end

--友盟新关卡失败
function SDKUtil.umentFailLevel(_level)
    local params = {_level}
    local sigs = "(I)V"
    if luaj then
        luaj.callStaticMethod(className,"umentFailLevel",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"umentFailLevel",params,sigs)
        return
    end
end

--获取最优档位礼包以及vip包月信息
function SDKUtil.giftPop(_data)
    local params = {_data.callback}
    local sigs = "(I)V"
    if luaj then
        luaj.callStaticMethod(className,"getGift",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"getGift",params,sigs)
        return
    end
    _data.callback("rzjxkp.lb.15|rzjxkp.lb.10.1|rzjxkp.tc.20#0|rzjxkp.by.30")
end

--获取领取/购买按钮
function SDKUtil.getGameGiftTaggleParam(_data)
    local params = {_data.callback}
    local sigs = "(I)V"
    if luaj then
        luaj.callStaticMethod(className,"getGameGiftTaggleParam",params,sigs)
        return
    end
    if luaoc then
        luaoc.callStaticMethod(className,"getGameGiftTaggleParam",params,sigs)
        return
    end
    _data.callback("1")
end

--退出游戏
function SDKUtil.exitGame()
    GameDataManager.SaveData()
    
    local params = {}
    local sigs = "()V"
    if luaj then
        luaj.callStaticMethod(className,"exitGame",params,sigs)
        return
    end
    os.exit(0)
end

return SDKUtil