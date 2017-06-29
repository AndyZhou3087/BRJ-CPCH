--[[
背景移动
]]
local BackGroundMove = class("BackGroundMove", function()
    return display.newNode()
end)

--parm@1:传入场景id
function BackGroundMove:ctor(_sceneId)
    self.sceneId = _sceneId
    
    self.sceneBg = cc.uiloader:load("json/SceneBg_".._sceneId..".json")
    self:addChild(self.sceneBg)
    
    self.Panel_1 = cc.uiloader:seekNodeByName(self.sceneBg,"Panel_1")
    self.Panel_1:setPositionY(display.bottom)
    self.Panel_1_0 = cc.uiloader:seekNodeByName(self.sceneBg,"Panel_1_0")
    self.Panel_1_0:setPositionY(display.bottom)
    self.Panel_1_0:setCameraMask(2)
    self.Panel_2 = cc.uiloader:seekNodeByName(self.sceneBg,"Panel_2")
    self.Panel_2:setPositionY(display.bottom+413)
    self.Panel_3 = cc.uiloader:seekNodeByName(self.sceneBg,"Panel_3")
    self.Panel_3:setPositionY(display.bottom+1989)
    self.Panel_2_0 = cc.uiloader:seekNodeByName(self.sceneBg,"Panel_2_0")
    self.Panel_2_0:setPositionY(display.bottom+413)
    self.Panel_3_0 = cc.uiloader:seekNodeByName(self.sceneBg,"Panel_3_0")
    self.Panel_3_0:setPositionY(display.bottom+1989)
    
    self.panel2Size = self.Panel_2:getCascadeBoundingBox().size
    self.panel3Size = self.Panel_3:getCascadeBoundingBox().size
    
    if GameDataManager.getFightScene() == 1 then
    	self.offset = {32,50}
    end
    
end

--背景分层横向移动
--parm@1:下层图背景不随之移动
--parm@2:moveX移动的距离
--parm@3:_ma摄像机位置
--parm@4:_scaleX移动方向
function BackGroundMove:bgLandscapeMove(_posX,moveX,_mx,_scaleX)
    self.Panel_1:setPositionX(_posX)
    local bgx,bgy = self.Panel_2:getPosition()
    self.Panel_2:setPositionX(bgx+moveX)
    local bgx2,bgy2 = self.Panel_3:getPosition()
    self.Panel_3:setPositionX(bgx2+moveX*0.95)
    local px2,py2 = self.Panel_2_0:getPosition()
    self.Panel_2_0:setPositionX(px2+moveX)
    local px3,py3 = self.Panel_3_0:getPosition()
    self.Panel_3_0:setPositionX(px3+moveX*0.95)
    if _scaleX == 1 then
        if bgx + 31 > _mx + display.width then
            self.Panel_2:setPositionX(px2-self.panel2Size.width+self.offset[1])
            self.Panel_2_0:setLocalZOrder(2)
            self.Panel_2:setLocalZOrder(1)
        end
        if px2 + 31 > _mx + display.width then
            self.Panel_2_0:setPositionX(bgx-self.panel2Size.width+self.offset[1])
            self.Panel_2:setLocalZOrder(2)
            self.Panel_2_0:setLocalZOrder(1)
        end
        if bgx2 > _mx + display.width then
            self.Panel_3:setPositionX(px3-self.panel3Size.width-self.offset[2])
        end
        if px3 > _mx + display.width then
            self.Panel_3_0:setPositionX(bgx2-self.panel3Size.width-self.offset[2])
        end
    else
        if bgx + 31 < _mx - display.width then
            self.Panel_2:setPositionX(px2+self.panel2Size.width-self.offset[1])
            self.Panel_2_0:setLocalZOrder(1)
            self.Panel_2:setLocalZOrder(2)
        end
        if px2 + 31 < _mx - display.width then
            self.Panel_2_0:setPositionX(bgx+self.panel2Size.width-self.offset[1])
            self.Panel_2:setLocalZOrder(1)
            self.Panel_2_0:setLocalZOrder(2)
        end
        if bgx2 < _mx - self.panel3Size.width then
            self.Panel_3:setPositionX(px3+self.panel3Size.width+self.offset[2])
        end
        if px3 < _mx - self.panel3Size.width then
            self.Panel_3_0:setPositionX(bgx2+self.panel2Size.width+self.offset[2])
        end
    end
end

--背景纵向移动(第一层横跑)
--parm@1:当前楼层位置
--parm@2:位置差(当前背景与楼层相差的距离)
--parm@3:摄像机当年位置
function BackGroundMove:bgPortraitRunningMove(_curPosY,_dis,_mx)
    local p1x,p1y = self.Panel_1:getPosition()
    self.Panel_1:stopAllActions()
    local move1 = cc.MoveTo:create(0.3,cc.p(_mx,_curPosY-_dis))
    self.Panel_1:runAction(move1)
    
    local p2x,p2y = self.Panel_2:getPosition()
    self.Panel_2:stopAllActions()
    local move2 = cc.MoveTo:create(0.3,cc.p(p2x,_curPosY*0.9-_dis+413))
    self.Panel_2:runAction(move2)
    local p2x2,p2y2 = self.Panel_2_0:getPosition()
    self.Panel_2_0:stopAllActions()
    local move2_2 = cc.MoveTo:create(0.3,cc.p(p2x2,_curPosY*0.9-_dis+413))
    self.Panel_2_0:runAction(move2_2)
    
    local p3x,p3y = self.Panel_3:getPosition()
    self.Panel_3:stopAllActions()
    local move3 = cc.MoveTo:create(0.3,cc.p(p3x,_curPosY*0.95-_dis+1989))
    self.Panel_3:runAction(move3)
    local p3x2,p3y2 = self.Panel_3_0:getPosition()
    self.Panel_3_0:stopAllActions()
    local move3_2 = cc.MoveTo:create(0.3,cc.p(p3x2,_curPosY*0.95-_dis+1989))
    self.Panel_3_0:runAction(move3_2)
end

--背景纵向移动(普通楼层类型)
--parm@1:当前楼层位置
--parm@2:位置差(当前背景与楼层相差的距离)
--parm@3:摄像机当年位置
function BackGroundMove:bgPortraitMove(_pos,_dis,_mx)
    self.Panel_1:stopAllActions()
    local move1 = cc.MoveTo:create(0.3,cc.p(_pos.x,_pos.y-_dis))
    self.Panel_1:runAction(move1)

    local p2x,p2y = self.Panel_2:getPosition()
    self.Panel_2:stopAllActions()
    local move2 = cc.MoveTo:create(0.3,cc.p(p2x+(_pos.x-_mx)*0.9,_pos.y*0.9-_dis+413))
    self.Panel_2:runAction(move2)
    local p2x2,p2y2 = self.Panel_2_0:getPosition()
    self.Panel_2_0:stopAllActions()
    local move2_2 = cc.MoveTo:create(0.3,cc.p(p2x2+(_pos.x-_mx)*0.9,_pos.y*0.9-_dis+413))
    self.Panel_2_0:runAction(move2_2)
    if p2x+(_pos.x-_mx)*0.9 > _pos.x + display.width - 31 then
        self.Panel_2:setPositionX(p2x2+(_pos.x-_mx)*0.9-self.panel2Size.width+self.offset[1])
        self.Panel_2_0:setLocalZOrder(2)
        self.Panel_2:setLocalZOrder(1)
    end
    if p2x2+(_pos.x-_mx)*0.9 > _pos.x + display.width - 31  then
        self.Panel_2_0:setPositionX(p2x+(_pos.x-_mx)*0.9-self.panel2Size.width+self.offset[1])
        self.Panel_2_0:setLocalZOrder(1)
        self.Panel_2:setLocalZOrder(2)
    end
    if p2x+(_pos.x-_mx)*0.9 < _pos.x - display.width then
        self.Panel_2:setPositionX(p2x2+(_pos.x-_mx)*0.9+self.panel2Size.width-self.offset[1])
        self.Panel_2_0:setLocalZOrder(2)
        self.Panel_2:setLocalZOrder(1)
    end
    if p2x2+(_pos.x-_mx)*0.9 < _pos.x - display.width then
        self.Panel_2_0:setPositionX(p2x+(_pos.x-_mx)*0.9+self.panel2Size.width-self.offset[1])
        self.Panel_2_0:setLocalZOrder(1)
        self.Panel_2:setLocalZOrder(2)
    end

    local p3x,p3y = self.Panel_3:getPosition()
    self.Panel_3:stopAllActions()
    local move3 = cc.MoveTo:create(0.3,cc.p(p3x+(_pos.x-_mx)*0.95,_pos.y*0.95-_dis+1989))
    self.Panel_3:runAction(move3)
    local p3x2,p3y2 = self.Panel_3_0:getPosition()
    self.Panel_3_0:stopAllActions()
    local move3_2 = cc.MoveTo:create(0.3,cc.p(p3x2+(_pos.x-_mx)*0.95,_pos.y*0.95-_dis+1989))
    self.Panel_3_0:runAction(move3_2)
    if p3x+(_pos.x-_mx)*0.95 > _pos.x + display.width then
        self.Panel_3:setPositionX(p3x2+(_pos.x-_mx)*0.95-self.panel3Size.width-self.offset[2])
    end
    if p3x2+(_pos.x-_mx)*0.95 > _pos.x + display.width then
        self.Panel_3_0:setPositionX(p3x+(_pos.x-_mx)*0.95-self.panel3Size.width-self.offset[2])
    end
    if p3x+(_pos.x-_mx)*0.95 < _pos.x - self.panel3Size.width then
        self.Panel_3:setPositionX(p3x2+(_pos.x-_mx)*0.95+self.panel3Size.width+self.offset[2])
    end
    if p3x2+(_pos.x-_mx)*0.9 < _pos.x - self.panel3Size.width then
        self.Panel_3_0:setPositionX(p3x+(_pos.x-_mx)*0.95+self.panel3Size.width+self.offset[2])
    end
end

--横跑过程中背景纵向移动
--parm@1:_posY要移动的Y轴位置
--parm@2:距离差
function BackGroundMove:toRunCameraMove(_posY,_dis)
    local p1x,p1y = self.Panel_1:getPosition()
    self.Panel_1:stopAllActions()
    local mo = cc.MoveBy:create(0.3,cc.p(0,_posY-_dis-p1y))
    self.Panel_1:runAction(mo)

    local bx,by = self.Panel_2:getPosition()
    self.Panel_2:stopAllActions()
    local move = cc.MoveBy:create(0.3,cc.p(0,_posY*0.9-_dis-by+413))
    self.Panel_2:runAction(move)
    local bx2,by2 = self.Panel_2_0:getPosition()
    self.Panel_2_0:stopAllActions()
    local move2 = cc.MoveBy:create(0.3,cc.p(0,_posY*0.9-_dis-by2+413))
    self.Panel_2_0:runAction(move2)
    
    local p3x,p3y = self.Panel_3:getPosition()
    self.Panel_3:stopAllActions()
    local p_move = cc.MoveBy:create(0.3,cc.p(0,_posY*0.95-_dis-p3y+1989))
    self.Panel_3:runAction(p_move)
    local p3x2,p3y2 = self.Panel_3_0:getPosition()
    self.Panel_3_0:stopAllActions()
    local p_move2 = cc.MoveBy:create(0.3,cc.p(0,_posY*0.95-_dis-p3y2+1989))
    self.Panel_3_0:runAction(p_move2)
end

--横跑类型y-x移动
--parm@1:_posY要移动的Y轴位置
--parm@2:距离差
function BackGroundMove:toRunYtoXMove(_posY,_dis,toX,mx)
    self.Panel_1:stopAllActions()
    local moveY = cc.MoveTo:create(0.2,cc.p(mx,_posY-_dis))
    local moveX = cc.MoveTo:create(1,cc.p(toX,_posY-_dis))
    local seq = cc.Sequence:create(moveY,moveX)
    self.Panel_1:runAction(seq)

    local nx,ny = self.Panel_2:getPosition()
    self:toYtoXMove(self.Panel_2,nx,_posY*0.9-_dis+413)
    local nx2,ny2 = self.Panel_2_0:getPosition()
    self:toYtoXMove(self.Panel_2_0,nx2,_posY*0.9-_dis+413)
    local nx3,ny3 = self.Panel_3:getPosition()
    self:toYtoXMove(self.Panel_3,nx3,_posY*0.95-_dis+1989)
    local nx4,ny4 = self.Panel_3_0:getPosition()
    self:toYtoXMove(self.Panel_3_0,nx4,_posY*0.95-_dis+1989)
end

--y到x的移动
function BackGroundMove:toYtoXMove(obj,x,y)
    obj:stopAllActions()
    local moveY = cc.MoveTo:create(0.2,cc.p(x,y))
    local moveX = cc.MoveTo:create(1,cc.p(x,y))
    local seq = cc.Sequence:create(moveY,moveX)
    obj:runAction(seq)
end

--横跑类型x-y移动
--parm@1:_posY要移动的Y轴位置
--parm@2:距离差
function BackGroundMove:toRunXtoYMove(_pos,_dis,my)
    self.Panel_1:stopAllActions()
    local moveY = cc.MoveTo:create(0.5,cc.p(_pos.x,_pos.y-_dis))
    local moveX = cc.MoveTo:create(0.5,cc.p(_pos.x,my))
    local seq = cc.Sequence:create(moveX,moveY)
    self.Panel_1:runAction(seq)

    local nx,ny = self.Panel_2:getPosition()
    self:toXtoYMove(self.Panel_2,nx,_pos.y*0.9-_dis+413)
    local nx2,ny2 = self.Panel_2_0:getPosition()
    self:toXtoYMove(self.Panel_2_0,nx2,_pos.y*0.9-_dis+413)
    local nx3,ny3 = self.Panel_3:getPosition()
    self:toXtoYMove(self.Panel_3,nx3,_pos.y*0.95-_dis+1989)
    local nx4,ny4 = self.Panel_3_0:getPosition()
    self:toXtoYMove(self.Panel_3_0,nx4,_pos.y*0.95-_dis+1989)
end

--x到y的移动
function BackGroundMove:toXtoYMove(obj,x,y)
    obj:stopAllActions()
    local moveY = cc.MoveTo:create(0.5,cc.p(x,y))
    local moveX = cc.MoveTo:create(0.5,cc.p(x,y))
    local seq = cc.Sequence:create(moveX,moveY)
    obj:runAction(seq)
end

--背景回到原点
function BackGroundMove:toBackOrigin()
    self.Panel_1:stopAllActions()
    local m = cc.MoveTo:create(0.5,cc.p(display.left,display.bottom))
    self.Panel_1:runAction(m)
    
    self.Panel_2:stopAllActions()
    local move = cc.MoveTo:create(0.5,cc.p(display.left-31,display.bottom+413))
    self.Panel_2:runAction(move)
    self.Panel_2_0:stopAllActions()
    local move2 = cc.MoveTo:create(0.5,cc.p(718,display.bottom+413))
    self.Panel_2_0:runAction(move2)
    
    self.Panel_3:stopAllActions()
    local move3 = cc.MoveTo:create(0.5,cc.p(display.left,display.bottom+1989))
    self.Panel_3:runAction(move3)
    self.Panel_3_0:stopAllActions()
    local move4 = cc.MoveTo:create(0.5,cc.p(900,display.bottom+1989))
    self.Panel_3_0:runAction(move4)
end

function BackGroundMove:onEnter()
end

function BackGroundMove:onExit()
end

function BackGroundMove:dispose()

end

return BackGroundMove
