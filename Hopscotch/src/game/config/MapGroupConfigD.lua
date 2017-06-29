
--======================以下为房间列表配置(每十层房间配置)=============================
MapGroupConfigD={}

--此为关卡配置说明，最好不要删除
--{
--    _id = 1,   
--    --房间背景、地板与墙体数组,此id对应RoomsBgConfig配置文件,填0则视为对应楼层不出现(若为奔跑类型则取RoomFloorConfig中配置文件)
--    roomBgs = {1,2,1,2,1,2,3},
--   
--    --房间装饰物,此id对应OrnamentsConfig配置文件,填0则视为对应楼层不出现
--    ornaments = {1,1,1,1,1,1,1},
--   
--    --房间金币,此id对应CoinsConfig配置文件,填0则视为对应楼层不出现
--    coins = {0,0,0,1,1,0,0},
--   
--    --房间物品,此id对应RoomGoodsConfig配置文件,填0则视为对应楼层不出现
--    roomGoods = {0,0,0,0,0,1,0},
--}
MapGroupConfigD[1]= 
    { 
        _id=1, 
        roomBgs={1,2,2,2,2,2,2,2,2,3}, --房间背景地面
        ornaments={2,1,1,1,1,1,1,1,1,1}, ---小挂件
        coins={0,0,0,0,1,0,0,0,0,0}, ---钻石
        roomGoods={0,0,0,0,0,1,0,0,0,0}, ---道具
        roomType = MAPROOM_TYPE.Common,
        direction = false,       --当类型为奔跑类型时的方向，非奔跑类型可不加此参数
        distance = 0,        --房间x轴倾斜距离(单位：像素)
        probability = 60,     --权重
    } 
    
MapGroupConfigD[2]= 
    { 
        _id=2, 
        roomBgs={1,2,2,2,2,2,2,2,2,3}, --房间背景地面
        ornaments={2,1,1,1,1,1,1,1,1,1}, ---小挂件
        coins={0,0,0,0,1,0,0,0,0,0}, ---钻石
        roomGoods={0,0,0,0,0,1,0,0,0,0}, ---道具
        roomType = MAPROOM_TYPE.Lean,
        direction = false,       --当类型为奔跑类型时的方向，非奔跑类型可不加此参数
        distance = 40,        --房间x轴倾斜距离(单位：像素)
        probability = 60,     --权重
    } 
    
MapGroupConfigD[3]= 
    { 
        _id=3, 
        roomBgs={2001,2001,2001,2001,2001,2001,2001,2001,2001,2010}, --房间背景地面
        ornaments={0,1,1,1,1,1,1,1,1,1}, ---小挂件
        coins={0,0,0,0,1,0,0,0,0,0}, ---钻石
        roomGoods={0,0,0,0,0,0,0,0,0,0}, ---道具
        roomType = MAPROOM_TYPE.Special,
        left = {1,5,9},     --左边默认停留的楼层位置
        right = {3,7,9},    --右边默认停留的楼层位置
        lineX = 0,    --钢架线离边距的距离
        direction = false,       --当类型为奔跑类型时的方向，非奔跑类型可不加此参数
        distance = 0,        --房间x轴倾斜距离(单位：像素)
        probability = 60,     --权重
    } 
    