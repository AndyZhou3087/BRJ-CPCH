package.loaded["launcher.init"] = nil
require("launcher.init")

local function enter_game()
    Launcher.performWithDelayGlobal(function()
        if GAME_RELEASE then
            cc.LuaLoadChunksFromZIP("lib/game.zip")
        end
        require("game.GameApp").new():run()
    end, 0.1)
end

local LauncherScene = lcher_class("LauncherScene", function()
    local scene = cc.Scene:create()
    scene.name = "LauncherScene"
    return scene
end)

function LauncherScene:ctor()

    self._needRestart = false;

    self._path = Launcher.writablePath .. "upd/"
    if Launcher.needUpdate then
        Launcher.performWithDelayGlobal(function()
            self:_update()
        end, 0.1)
    else
        Launcher.performWithDelayGlobal(function()
            enter_game()
        end, 0.1)
    end
end

--创建更新ui
function LauncherScene:_initUpdateUI(parameters)
    local _bg = cc.Sprite:create("ui/uiImg/denglu_bg.jpg")--display.newSprite("ui/uiImg/denglu_bg.jpg")
    self:addChild(_bg)
    _bg:setPosition(Launcher.cx,Launcher.cy)
    --    local _logo = cc.Sprite:create("ui/uiImg/logo.png")--display.newSprite("ui/uiImg/logo.png")
    --    self:addChild(_logo)
    --    _logo:setPosition(Launcher.cx,Launcher.cy+330)

    local _barBg = cc.Sprite:create("loading/loading_barBg.png")--display.newSprite("loading/loading_barBg.png")
    local _barBgSize = _barBg:getContentSize()
    _barBg:setAnchorPoint(0,0.5)
    _barBg:setPosition((Launcher.width-_barBgSize.width)*0.5,Launcher.cy-430)
    self:addChild(_barBg)

    self._bar = cc.Sprite:create("loading/loading_bar.png")--display.newSprite("loading/loading_bar.png")
    local _barSize = self._bar:getContentSize()
    self._bar:setAnchorPoint(0,0.5)
    self._bar:setPosition(_barBg:getPositionX()+(_barBgSize.width-_barSize.width)*0.5,_barBg:getPositionY())
    self:addChild(self._bar)
    self._bar:setScaleX(0)

    self._progressLabel = cc.Label:createWithSystemFont(PROGRESS_TEXT.."0%", nil, 20)
    self._progressLabel:setColor({r=255,g=255,b=255})
    self._progressLabel:setPosition(Launcher.cx, _barBg:getPositionY()+_barBgSize.height)
    self:addChild(self._progressLabel)
end
function LauncherScene:_update()
    self:_initUpdateUI()

    -- 获取flist，更新
    -- 创建更新目录
    Launcher.mkDir(self._path)

    -- 读取更新目录下flist
    self._curListFile =  self._path .. Launcher.fListName
    if Launcher.fileExists(self._curListFile) then
        self._fileList = Launcher.doFile(self._curListFile)
    else
        -- 更新目录下没有flist读取apk包内flist
        self._fileList = Launcher.doFile(Launcher.fListName)
    end

    --    if self._fileList ~= nil then
    --        local appVersionCode = Launcher.getAppVersionCode()
    --        if appVersionCode ~= self._fileList.appVersion then
    --            --新的app已经更新需要删除upd/目录下的所有文件 整包更新
    --            Launcher.removePath(self._path)
    --            require("main")
    --            return
    --        end
    --    else
    --        -- 更新目录下没有flist读取apk包内flist
    --        self._fileList = Launcher.doFile(Launcher.fListName)
    --    end

    -- 读取更种途径的flist失败，跳过更新
    if self._fileList == nil then
        self._updateRetType = Launcher.UpdateRetType.OTHER_ERROR
        self:_endUpdate()
    end

    -- 下载flist
    self:_requestFromServer(Launcher.fListName, Launcher.RequestType.FLIST)
end

function LauncherScene:_requestFromServer(filename, requestType, waittime)
    local url = Launcher.server .. filename
    print("aktest download file:"..filename);
    --    self._textLabel:setString("download file:"..filename)
    if Launcher.needUpdate then
        local request = cc.HTTPRequest:createWithUrl(function(event)
            self:_onResponse(event, requestType)
        end, url, cc.kCCHTTPRequestMethodGET)

        if request then
            request:setTimeout(waittime or 30)
            request:start()
        else
            --初始化网络错误
            self._updateRetType = Launcher.UpdateRetType.NETWORK_ERROR
            self:_endUpdate()
        end
    else
        --不更新
        enter_game()
    end
end

function LauncherScene:_onResponse(event, requestType)
    local request = event.request

    if event.name == "completed" then
        if request:getResponseStatusCode() ~= 200 then
            print("aktest download error:"..request:getResponseStatusCode());
            --            self._progressLabel:setString("download error:"..request:getResponseStatusCode())
            --            self._textLabel:setString("download error:"..request:getResponseStatusCode())
            self._updateRetType = Launcher.UpdateRetType.NETWORK_ERROR
            self:_endUpdate()
        else
            print("aktest download ok.");
            local dataRecv = request:getResponseData()
            if requestType == Launcher.RequestType.FLIST then
                self:_onFileListDownloaded(dataRecv)
            else
                self:_onResFileDownloaded(dataRecv)
            end
        end
    elseif event.name == "progress" then
        if requestType == Launcher.RequestType.RES then
            self:_onResProgress(event.dltotal)
        end
    else
        self._updateRetType = Launcher.UpdateRetType.NETWORK_ERROR
        self:_endUpdate()
    end
end

function LauncherScene:_onFileListDownloaded(dataRecv)
    self._newListFile = self._curListFile .. Launcher.updateFilePostfix
    Launcher.writefile(self._newListFile, dataRecv)
    self._fileListNew = Launcher.doFile(self._newListFile)
    if self._fileListNew == nil then
        self._updateRetType = Launcher.UpdateRetType.OTHER_ERROR
        self:_endUpdate()
        return
    end

    -- 不需要更新
    if self._fileListNew.version == self._fileList.version then
        Launcher.removePath(self._newListFile)
        self._updateRetType = Launcher.UpdateRetType.SUCCESSED
        self:_endUpdate()
        return
    end

    --创建资源目录
    local dirPaths = self._fileListNew.dirPaths
    for i=1,#(dirPaths) do
        Launcher.mkDir(self._path..(dirPaths[i].name))
    end

    -- 获取需要下载的文件
    self:_updateNeedDownloadFiles()

    self._numFileCheck = 0
    -- 下载文件
    self:_reqNextResFile()
end

function LauncherScene:_onResProgress(dltotal)
    self._hasCurFileDownloadSize = dltotal
    self:_updateProgressUI()
end

function LauncherScene:_updateNeedDownloadFiles()
    self._needDownloadFiles = {}
    self._needRemoveFiles = {}
    self._downList = {}
    self._needDownloadSize = 0
    self._hasDownloadSize = 0
    self._hasCurFileDownloadSize = 0

    local newFileInfoList = self._fileListNew.fileInfoList
    local oldFileInfoList = self._fileList.fileInfoList

    local hasChanged = false
    for i=1, #(newFileInfoList) do
        hasChanged = false
        for k=1, #(oldFileInfoList) do
            if newFileInfoList[i].name == oldFileInfoList[k].name then
                hasChanged = true
                if newFileInfoList[i].code ~= oldFileInfoList[k].code then
                    local fn = newFileInfoList[i].name .. Launcher.updateFilePostfix
                    if Launcher.checkFileWithMd5(self._path .. fn, newFileInfoList[i].code) then
                        table.insert(self._downList, fn)
                    else
                        self._needDownloadSize = self._needDownloadSize + newFileInfoList[i].size
                        table.insert(self._needDownloadFiles, newFileInfoList[i])
                    end
                end
                table.remove(oldFileInfoList, k)
                break
            end
        end
        if hasChanged == false then
            self._needDownloadSize = self._needDownloadSize + newFileInfoList[i].size
            table.insert(self._needDownloadFiles, newFileInfoList[i])
        end
    end
    self._needRemoveFiles = oldFileInfoList

    --    self._progressLabel = cc.Label:createWithTTF("0%", LCHER_FONT, 20)
    --    self._progressLabel:setColor({r = 255, g = 255, b = 255})
    --    self._progressLabel:setPosition(Launcher.cx, Launcher.cy - 20)
    --    self:addChild(self._progressLabel)

    --    self._textLabel:setString(STR_LCHER_UPDATING_TEXT)

    -- 更新到launcher.zip，重启使用新的更新逻辑
    local launcherPath = Launcher.libDir..Launcher.lcherZipName;
    for i=1, #(self._needDownloadFiles) do
        if self._needDownloadFiles[i].name==launcherPath then
            self._needRestart = true;
        end
    end
end

function LauncherScene:_updateProgressUI()
    local downloadPro = ((self._hasDownloadSize + self._hasCurFileDownloadSize) * 100) / (self._needDownloadSize)
    self._progressLabel:setString(PROGRESS_TEXT..string.format("%d%%", downloadPro))
    if downloadPro > 100 then
        downloadPro = 100
    end
    print("chjh download=",downloadPro)
    self._bar:setScaleX(downloadPro*0.01)
end


function LauncherScene:_reqNextResFile()
    self:_updateProgressUI()
    self._numFileCheck = self._numFileCheck + 1
    self._curFileInfo = self._needDownloadFiles[self._numFileCheck]
    if self._curFileInfo and self._curFileInfo.name then
        self:_requestFromServer(self._curFileInfo.name, Launcher.RequestType.RES)
    else
        self:_endAllResFileDownloaded()
    end

end

function LauncherScene:_endAllResFileDownloaded()
    local data = Launcher.readFile(self._newListFile)
    Launcher.writefile(self._curListFile, data)
    self._fileList = Launcher.doFile(self._curListFile)
    if self._fileList == nil then
        self._updateRetType = Launcher.UpdateRetType.OTHER_ERROR
        self:_endUpdate()
        return
    end

    Launcher.removePath(self._newListFile)

    local offset = -1 - string.len(Launcher.updateFilePostfix)
    for i,v in ipairs(self._downList) do
        v = self._path .. v
        local data = Launcher.readFile(v)

        local fn = string.sub(v, 1, offset)
        Launcher.writefile(fn, data)
        Launcher.removePath(v)
    end

    for i,v in ipairs(self._needRemoveFiles) do
        Launcher.removePath(self._path .. (v.name))
    end

    self._updateRetType = Launcher.UpdateRetType.SUCCESSED
    self:_endUpdate()
end

function LauncherScene:_onResFileDownloaded(dataRecv)
    local fn = self._curFileInfo.name .. Launcher.updateFilePostfix
    Launcher.writefile(self._path .. fn, dataRecv)
    if Launcher.checkFileWithMd5(self._path .. fn, self._curFileInfo.code) then
        table.insert(self._downList, fn)
        self._hasDownloadSize = self._hasDownloadSize + self._curFileInfo.size
        self._hasCurFileDownloadSize = 0
        self:_reqNextResFile()
    else
        --文件验证失败
        self._updateRetType = Launcher.UpdateRetType.MD5_ERROR
        self:_endUpdate()
    end
end

-- 对应不同错误作出不同的提示
function LauncherScene:_endUpdate()
    if self._updateRetType ~= Launcher.UpdateRetType.SUCCESSED then
        print("update errorCode = "..self._updateRetType)
        --        self._textLabel:setString("update errorCode = "..self._updateRetType)
        Launcher.removePath(self._curListFile)

        if self._updateRetType == Launcher.UpdateRetType.NETWORK_ERROR then
            self._progressLabel:setString("当前网络不稳定，请检查网络重新进入！")
        else
            self._progressLabel:setString("下载资源出错，请重试或联系客服！")
        end
        return
    end

    -- 更新到launcher.zip，重启使用新的更新逻辑
    if self._needRestart then
        require("main")
    else
        --        self._textLabel:setString("enter game")
        enter_game()
    end
end

local lchr = LauncherScene.new()
Launcher.runWithScene(lchr)