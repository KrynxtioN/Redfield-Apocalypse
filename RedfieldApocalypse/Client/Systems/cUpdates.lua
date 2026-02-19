addEvent("Updates.createWindow",true)
addEventHandler("Updates.createWindow",root,function()
	if(isWindowOpen())then
        ApocalypseUI.window[1] = guiCreateWindow(655, 317, 334, 337, "Updates", false)

        ApocalypseUI.memo[1] = guiCreateMemo(10, 29, 314, 298, "///", false, ApocalypseUI.window[1])
        guiMemoSetReadOnly(ApocalypseUI.memo[1], true)
		setWindowDatas("set")
	end
end)