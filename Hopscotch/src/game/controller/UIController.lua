--local LevelSelectView = require("game.view.levelSelect.LevelSelectView")

local UIController = class("UIController")

function UIController:ctor()
    --监听关卡界面打开
--    GameDispatcher:addListener(EventNames.EVENT_OPEN_LEVELSELECT,handler(self,self.openSelectUI))
end

--打开商店界面
--function UIController:openShop(parameters)
--    print("chshl Open the shop!")
--    local _shopUI = ShopView.new(parameters.data)
--    _shopUI:show(UI_ZORDER.VIEW_ZORDER)
--end

return UIController