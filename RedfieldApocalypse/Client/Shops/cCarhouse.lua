Carhouse = {}

addEvent("Carhouse.openWindow",true)
addEventHandler("Carhouse.openWindow",root,function(price)
	if(isWindowOpen())then
        ApocalypseUI.window[1] = guiCreateWindow(517, 328, 303, 118, "Carhouse", false)

        ApocalypseUI.label[1] = guiCreateLabel(10, 30, 283, 34, "This vehicle costs $"..price..", do you wanna buy it?", false, ApocalypseUI.window[1])
        guiSetFont(ApocalypseUI.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "center", true)
        guiLabelSetVerticalAlign(ApocalypseUI.label[1], "center")
        ApocalypseUI.button[1] = guiCreateButton(10, 74, 283, 34, "Buy", false, ApocalypseUI.window[1])
		setWindowDatas("set")
		
		addEventHandler("onClientGUIClick",ApocalypseUI.button[1],function()
			triggerServerEvent("Carhouse.buy",localPlayer)
		end,false)
    end
end)

addEvent("Carhouse.showInfobox",true)
addEventHandler("Carhouse.showInfobox",root,function()
	infobox("Get in a vehicle to buy it.",0,255,0)
end)

bindKey("f5","down",function()
	if(isWindowOpen())then
        ApocalypseUI.window[1] = guiCreateWindow(522, 318, 415, 249, "Vehicles", false)

        ApocalypseUI.gridlist[1] = guiCreateGridList(9, 24, 289, 215, false, ApocalypseUI.window[1])
        VehicleID = guiGridListAddColumn(ApocalypseUI.gridlist[1], "ID", 0.5)
        Vehicle = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Vehicle", 0.5)
        ApocalypseUI.button[1] = guiCreateButton(308, 28, 97, 28, "Sell", false, ApocalypseUI.window[1])
        ApocalypseUI.button[2] = guiCreateButton(308, 66, 97, 28, "Locate", false, ApocalypseUI.window[1])
        ApocalypseUI.label[1] = guiCreateLabel(308, 104, 97, 135, "You'll don't get your money back, if you sell a vehicle.", false, ApocalypseUI.window[1])
        guiSetFont(ApocalypseUI.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "center", true)
		triggerServerEvent("Carhouse.getPlayerVehicles",localPlayer,localPlayer)
		setWindowDatas("set")
		
		addEventHandler("onClientGUIClick",ApocalypseUI.button[1],function()
			local clicked = guiGridListGetItemText(ApocalypseUI.gridlist[1],guiGridListGetSelectedItem(ApocalypseUI.gridlist[1]),1)
			if(clicked ~= "")then
				triggerServerEvent("Carhouse.sell",localPlayer,clicked)
			end
		end,false)
		
		addEventHandler("onClientGUIClick",ApocalypseUI.button[2],function()
			local clicked = guiGridListGetItemText(ApocalypseUI.gridlist[1],guiGridListGetSelectedItem(ApocalypseUI.gridlist[1]),1)
			if(clicked ~= "")then
				triggerServerEvent("Carhouse.locate",localPlayer,clicked)
			end
		end,false)
    end
end)

addEvent("Carhouse.setPlayerVehicles",true)
addEventHandler("Carhouse.setPlayerVehicles",root,function(vehicles)
	guiGridListClear(ApocalypseUI.gridlist[1])
	if(#vehicles >= 1)then
		for _,v in pairs(vehicles)do
			local row = guiGridListAddRow(ApocalypseUI.gridlist[1])
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,VehicleID,v[1],false,false)
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,Vehicle,v[2],false,false)
		end
	end
end)

addEvent("Carhouse.locateBlip",true)
addEventHandler("Carhouse.locateBlip",root,function(x,y,z)
	infobox("Your vehicle will be showing as a red blip on the map for five minutes.",0,255,0)
	if(isElement(Carhouse.locateBlip))then destroyElement(Carhouse.locateBlip)end
	if(isTimer(Carhouse.locateBlip))then killTimer(Carhouse.locateBlip)end
	Carhouse.locateBlip = createBlip(x,y,z,0,2,255,0,0)
	Carhouse.locateBlipTimer = setTimer(function()
		destroyElement(Carhouse.locateBlipTimer)
	end,300000,1)
end)