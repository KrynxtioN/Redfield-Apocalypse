Weapondepot = {
	["IDs"] = {
		["Colt 45"] = 22,
		["Silenced"] = 23,
		["Desert Eagle"] = 24,
		["Shotgun"] = 25,
		["Sawed-off"] = 26,
		["Combat Shotgun"] = 27,
		["Uzi"] = 28,
		["Mp5"] = 29,
		["Tec-9"] = 32,
		["AK-47"] = 30,
		["M4"] = 31,
		["Country Rifle"] = 33,
		["Sniper"] = 34,
		["Rocket Launcher"] = 35,
		["Rocket Launcher HS"] = 36,
		["Flamethrower"] = 37,
		["Minigun"] = 38,
		["Grenade"] = 16,
		["Molotov"] = 18,
		["Satchel"] = 39
	},
}

bindKey("f6","down",function()
	if(getElementData(localPlayer,"loggedin") == 1)then
		if(getElementData(localPlayer,"Weapondepot") == 1)then
			if(isWindowOpen())then
				ApocalypseUI.window[1] = guiCreateWindow(468, 252, 471, 433, "Weapon Depot", false)

				ApocalypseUI.gridlist[1] = guiCreateGridList(10, 61, 451, 141, false, ApocalypseUI.window[1])
				depotID = guiGridListAddColumn(ApocalypseUI.gridlist[1], "ID", 0.3)
				depotWeapon = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Weapon", 0.3)
				depotAmmo = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Ammo", 0.3)
				ApocalypseUI.label[1] = guiCreateLabel(10, 27, 451, 24, "Weapons in your depot:", false, ApocalypseUI.window[1])
				guiSetFont(ApocalypseUI.label[1], "default-bold-small")
				guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "center", false)
				guiLabelSetVerticalAlign(ApocalypseUI.label[1], "center")
				ApocalypseUI.label[2] = guiCreateLabel(10, 212, 451, 24, "Weapons on your hand:", false, ApocalypseUI.window[1])
				guiSetFont(ApocalypseUI.label[2], "default-bold-small")
				guiLabelSetHorizontalAlign(ApocalypseUI.label[2], "center", false)
				guiLabelSetVerticalAlign(ApocalypseUI.label[2], "center")
				ApocalypseUI.gridlist[2] = guiCreateGridList(10, 246, 451, 141, false, ApocalypseUI.window[1])
				handWeapon = guiGridListAddColumn(ApocalypseUI.gridlist[2], "Weapon", 0.5)
				handAmmo = guiGridListAddColumn(ApocalypseUI.gridlist[2], "Ammo", 0.5)
				ApocalypseUI.button[1] = guiCreateButton(10, 397, 219, 26, "Store", false, ApocalypseUI.window[1])
				guiSetProperty(ApocalypseUI.button[1], "NormalTextColour", "FFAAAAAA")
				ApocalypseUI.button[2] = guiCreateButton(242, 397, 219, 26, "Outsource", false, ApocalypseUI.window[1])
				guiSetProperty(ApocalypseUI.button[2], "NormalTextColour", "FFAAAAAA")
				setWindowDatas("set")
				
				triggerServerEvent("Weapondepot.getWeapons",localPlayer)
				
				addEventHandler("onClientGUIClick",ApocalypseUI.button[1],function()
					local weapon = getItemFromGridlist(ApocalypseUI.gridlist[2],1)
					if(not(weapon == ""))then
						local weaponID = Weapondepot["IDs"][weapon]
						triggerServerEvent("Weapondepot.store",localPlayer,weaponID)
						triggerServerEvent("Weapondepot.getWeapons",localPlayer)
					end
				end,false)
				
				addEventHandler("onClientGUIClick",ApocalypseUI.button[2],function()
					local weapon = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
					if(not(weapon == ""))then
						triggerServerEvent("Weapondepot.outsource",localPlayer,weapon)
						triggerServerEvent("Weapondepot.getWeapons",localPlayer)
					end
				end,false)
			end
		end
	end
end)

addEvent("Weapondepot.refresh",true)
addEventHandler("Weapondepot.refresh",root,function(handweapons,depotweapons)
	guiGridListClear(ApocalypseUI.gridlist[1])
	guiGridListClear(ApocalypseUI.gridlist[2])
	
	if(#depotweapons >= 1)then
		for _,v in pairs(depotweapons)do
			local row = guiGridListAddRow(ApocalypseUI.gridlist[1])
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,depotID,v[1],false,false)
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,depotWeapon,v[2],false,false)
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,depotAmmo,v[3],false,false)
		end
	end
	
	if(#handweapons >= 1)then
		for _,v in pairs(handweapons)do
			local row = guiGridListAddRow(ApocalypseUI.gridlist[2])
			guiGridListSetItemText(ApocalypseUI.gridlist[2],row,handWeapon,v[1],false,false)
			guiGridListSetItemText(ApocalypseUI.gridlist[2],row,handAmmo,v[2],false,false)
		end
	end
end)