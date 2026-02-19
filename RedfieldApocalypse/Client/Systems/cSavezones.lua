addEvent("Savezones.createWindow",true)
addEventHandler("Savezones.createWindow",root,function()
	if(isWindowOpen())then
		if(getElementData(localPlayer,"Premium") == 1 or getElementData(localPlayer,"LifetimePremium") == 1)then
			ApocalypseUI.window[1] = guiCreateWindow(10, 293, 275, 314, "Savezones", false)

			ApocalypseUI.gridlist[1] = guiCreateGridList(10, 26, 255, 239, false, ApocalypseUI.window[1])
			savezoneGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Savezone", 0.9)
			ApocalypseUI.button[1] = guiCreateButton(62, 275, 150, 29, "Teleport", false, ApocalypseUI.window[1])
			guiSetProperty(ApocalypseUI.button[1], "NormalTextColour", "FFAAAAAA")
			setWindowDatas("set")

			for _,v in pairs(Adminsystem["Savezones"])do
				local row = guiGridListAddRow(ApocalypseUI.gridlist[1])
				guiGridListSetItemText(ApocalypseUI.gridlist[1],row,savezoneGridlist,v,false,false)
			end
			
			addEventHandler("onClientGUIClick",ApocalypseUI.button[1],function()
				local savezone = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
				if(savezone ~= "")then
					triggerServerEvent("Adminsystem.teleportToZone",localPlayer,savezone)
				end
			end,false)
		else infobox("Only for premium members!",255,0,0)end
	end
end)