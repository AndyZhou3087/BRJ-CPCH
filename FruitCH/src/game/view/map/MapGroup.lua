--[[
配置组
]]

local ObstacleElement = require("game.view.element.Obstacle")
local CoinElement = require("game.view.element.CoinElement")
local GoodsElement = require("game.view.element.GoodsElement")

local Scheduler = require("framework.scheduler")

local MapGroup = class("MapGroup",function()
    return display.newNode()
end)

--parm@1:组合id
--parm@2:组合配置表
function MapGroup:ctor(_idx,_levelCon)
    if _idx<1 then
    	return
    end

    --物理块儿
    self.m_blocks = {}
    self.m_goods={}
    self.m_obstacle={}
    
    self.m_index = _idx

    self.m_curLevelCon = _levelCon

    local _obstacle
    local _coins
    local _goods
    if GAME_TYPE_CONTROL == GAME_TYPE.LevelMode then
        _obstacle = Obstacles[_levelCon.obstacle[_idx]] or {}
        _coins = Coins[_levelCon.coins[_idx]] or {}
        _goods = GroupGoods[_levelCon.goods[_idx]] or {}
    else
        _obstacle = Obstacles[_levelCon.obstacle] or {}
        _coins = Coins[_levelCon.coins] or {}
        _goods = GroupGoods[_levelCon.goods] or {}
    end

    self:initElement(_obstacle)

    self:initCoins(_coins)
    self:initGoods(_goods)
    
end

function MapGroup:onEnterFrame(parameters)
    local x,y = self:getPosition()
    self:setPosition(x-MoveSpeed*0.1,y)
    if self.m_golds then
        for key, var in pairs(self.m_golds) do
            if not tolua.isnull(var) then
                var:onEnterFrame()
            end
        end
    end
    if self:getPositionX()<=-self:getSize().width then
        if not tolua.isnull(self) then
            if not tolua.isnull(self:getParent()) then
                self:getParent():addNewGroup()
            end
            self:dispose()
        end
    end
end

function MapGroup:initElement(_obstacle)
    for var=1,#_obstacle do
        local _element = _obstacle[var]
        local obstacle = ObstacleElement.new(_element.obsId,_element.y)
        obstacle:setPosition(_element.x,_element.y)
        self:addChild(obstacle)
        table.insert(self.m_obstacle,obstacle)
        table.insert(self.m_blocks,obstacle)
    end
end

function MapGroup:initCoins(goldCon)
    if goldCon and #goldCon>0 then
        self.m_golds = {}
        for var=1,#goldCon do
            local _goldObj = goldCon[var]
            if _goldObj then
                local _num = _goldObj.value or 1
                local _type = _goldObj.type or Coin_Type.Coin_Gold
                local gold,chType
                if _type == Coin_Type.Coin_Gold then
                    gold = PoolManager.getCacheObjByType(CACHE_TYPE.Coin)
                    chType = CACHE_TYPE.Coin
                elseif _type == Coin_Type.Coin_Silver then
                    gold = PoolManager.getCacheObjByType(CACHE_TYPE.Sliver)
                    chType = CACHE_TYPE.Sliver
                else
                    gold = PoolManager.getCacheObjByType(CACHE_TYPE.Copper)
                    chType = CACHE_TYPE.Copper
                end
                if not gold then
                    gold = CoinElement.new({res = _goldObj.res,type = _type})
                    gold:setCahceType(chType)
                    gold:retain()
                else
                    gold:setCoinType(_type)
                end
                gold:setPosition(_goldObj.x,_goldObj.y)
                gold:setGroup(self.m_index)
                table.insert(self.m_golds,gold)
                GameController.addGoldBody(gold)
            end
        end
    end
end

function MapGroup:initGoods(_goods)
    for var=1,#_goods do
        local _element = _goods[var]
        local goods = GoodsElement.new(_element.id)
        goods:setPosition(_element.x,_element.y)
        self:addChild(goods)
        table.insert(self.m_goods,goods)
        table.insert(self.m_blocks,goods)
        GameController.addGoodBody(goods)
    end
end

--获取大小
function MapGroup:getSize()
    return GroupSize
end

function MapGroup:initPosition(_x,_y)
    
    self:setPosition(_x,_y)
    
    --金币添加在层上
    local _parent = self:getParent()
    if self.m_golds then
        for key, var in pairs(self.m_golds) do
            if not tolua.isnull(var) then
                local x,y = var:getPosition()
                var:setPosition(x+_x,y+_y)
                _parent:addChild(var,MAP_ZORDER_MAX)
            end
        end
    end
    
    self:startUpdate()
end

function MapGroup:stopUpdate(parameters)
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
end

function MapGroup:startUpdate(parameters)
    self.m_timer = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),0.01)
end

function MapGroup:dispose(_isDestroy)
    for key, var in pairs(self.m_blocks) do
        if not tolua.isnull(var) then
            var:dispose()
        end
    end
    self.m_blocks = {}
    
    if self.m_obstacle then
        for key, var in pairs(self.m_obstacle) do
            if not tolua.isnull(var) then
                var:dispose()
            end
        end
    end
    
    if self.m_golds then
        for key, var in pairs(self.m_golds) do
            if not tolua.isnull(var) then
                --此处是过滤该数组中已经被其它楼层应用了防止消除
                if var:getGroup() == self.m_index then
                    var:dispose()
                end
            end
        end
    end
    
    if self.m_goods then
        for key, var in pairs(self.m_goods) do
            if not tolua.isnull(var) then
                var:dispose()  
            end
        end
    end
    
    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end
    
    self:removeFromParent(true)

end

return MapGroup