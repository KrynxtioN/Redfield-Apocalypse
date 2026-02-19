addEvent("Houses.openWindow",true)
addEventHandler("Houses.openWindow",root,function(owner,price)
	if(isWindowOpen())then
		if(owner == "Niemand")then text = "Buy" else text = "Sell" end
        ApocalypseUI.window[1] = guiCreateWindow(373, 336, 219, 126, "House", false)

        ApocalypseUI.label[1] = guiCreateLabel(10, 29, 199, 52, "Owner: "..owner.."\nPrice: "..price.."$", false, ApocalypseUI.window[1])
		guiSetFont(ApocalypseUI.label[1], "default-bold-small")
		guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "center", false)
		guiLabelSetVerticalAlign(ApocalypseUI.label[1], "center")
        ApocalypseUI.button[1] = guiCreateButton(10, 91, 199, 25, text, false, ApocalypseUI.window[1])
		setWindowDatas("set")
		
		addEventHandler("onClientGUIClick",ApocalypseUI.button[1],function()
			triggerServerEvent("Houses.buyOrSellHouse",localPlayer,guiGetText(source))
		end,false)
    end
end)