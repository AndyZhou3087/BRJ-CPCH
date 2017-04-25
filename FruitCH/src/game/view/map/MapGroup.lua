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
--        _obstacle = Obstacles[_levelCon.obstacle[_idx]] or {}
--        _coins = Coins[_levelCon.coins[_idx]] or {}
--        _goods = GroupGoods[_levelCon.goods[_idx]] or {}
        if DataPersistence.getAttribute("first_into") and not MapGroupConfig[_levelCon.guideMap[_idx]] then
            return
        end
        if not MapGroupConfig[_levelCon.map[_idx]] then
        	return
        end
        local map
        if DataPersistence.getAttribute("first_into") then
        	map = cc.TMXTiledMap:create(MapGroupConfig[_levelCon.guideMap[_idx]])
        else
            map = cc.TMXTiledMap:create(MapGroupConfig[_levelCon.map[_idx]])
        end
        local gold = map:getObjectGroup("gold")
        local good = map:getObjectGroup("good")
        local obscale = map:getObjectGroup("obstacle")
        if gold then
            _coins = gold:getObjects()
        else
            _coins = {}
        end
        if good then
            _goods = good:getObjects()
        else
            _goods = {}
        end
        if obscale then
            _obstacle = obscale:getObjects()
        else
            _obstacle = {}
        end
    else
--        _obstacle = Obstacles[_levelCon.obstacle] or {}
--        _coins = Coins[_levelCon.coins] or {}
--        _goods = GroupGoods[_levelCon.goods] or {}
        if not MapGroupConfig[_levelCon.map] then
            return
        end
        local map = cc.TMXTiledMap:create(MapGroupConfig[_levelCon.map])
        local gold = map:getObjectGroup("gold")
        local good = map:getObjectGroup("good")
        local obscale = map:getObjectGroup("obstacle")
        if gold then
            _coins = gold:getObjects()
        else
            _coins = {}
        end
        if good then
            _goods = good:getObjects()
        else
            _goods = {}
        end
        if obscale then
            _obstacle = obscale:getObjects()
        else
            _obstacle = {}
        end
    end

    self:initElement(_obstacle)

    self:initCoins(_coins)
    self:initGoods(_goods)
    
end

function MapGroup:onEnterFrame(parameters)
    local x,y = self:getPosition()
    self:setPosition(x-MoveSpeed*0.1,y)
--    if self.m_golds then
--        for key, var in pairs(self.m_golds) do
--            if not tolua.isnull(var) then
--                var:onEnterFrame()
--            end
--        end
--    end
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
        local _type = ObstacleConfig[tonumber(_element.name)].type
        local obstacle = ObstacleElement.new(tonumber(_element.name),tonumber(_element.y))
        obstacle:setPosition(tonumber(_element.x),tonumber(_element.y))
        self:addChild(obstacle)
        if _type == OBSTACLE_TYPE.special then
            if tonumber(_element.y)<=display.cy then
                obstacle:setPosition(tonumber(_element.x),display.cy-240)
            else
                obstacle:setPosition(tonumber(_element.x),display.cy+200)
        	end
        end
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
                local _type = tonumber(_goldObj.type) or Coin_Type.Coin_Gold
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
                    gold = CoinElement.new({res = _goldObj.name,type = _type})
                    gold:setCahceType(chType)
                    gold:retain()
                else
                    gold:setCoinType(_type)
                end
                gold:setPosition(tonumber(_goldObj.x),tonumber(_goldObj.y))
                gold:setGroup(self.m_index)
                gold:startScheduler()
                table.insert(self.m_golds,gold)
                GameController.addGoldBody(gold)
            end
        end
    end
end

function MapGroup:initGoods(_goods)
    for var=1,#_goods do
        local _element = _goods[var]
        local goods = GoodsElement.new(tonumber(_element.name))  --name为id
        goods:setPosition(tonumber(_element.x),tonumber(_element.y))
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
    self.m_timer = Scheduler.scheduleGlobal(handler(self,self.onEnterFrame),FrameTime)
end

--获取组合中的障碍物
function MapGroup:getObstacles(parameters)
    return self.m_obstacle
end

function MapGroup:dispose(_isDestroy)

    if self.m_timer then
        Scheduler.unscheduleGlobal(self.m_timer)
        self.m_timer = nil
    end

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
    self.m_obstacle = {}
    
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
    self.m_golds = {}
    
    if self.m_goods then
        for key, var in pairs(self.m_goods) do
            if not tolua.isnull(var) then
                var:dispose()  
            end
        end
    end
    self.m_goods ={}
    
    self:removeFromParent(true)

end

return MapGroup