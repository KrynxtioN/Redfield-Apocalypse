Safes = {}

addEvent("Safes.openWindow",true)
addEventHandler("Safes.openWindow",root,function()
	if(isWindowOpen())then
        ApocalypseUI.window[1] = guiCreateWindow(835, 233, 331, 109, "Safes", false)

        ApocalypseUI.label[1] = guiCreateLabel(10, 26, 311, 73, "I get 21 safes every day. I don't know what's inside, but as long as there are, feel free to open them. Provided you have a key.", false, ApocalypseUI.window[1])
		guiSetFont(ApocalypseUI.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "center", true)
        guiLabelSetVerticalAlign(ApocalypseUI.label[1], "center")
        setWindowDatas("set")
	end
end)