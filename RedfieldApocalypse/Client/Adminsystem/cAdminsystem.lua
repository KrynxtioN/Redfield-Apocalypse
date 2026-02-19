bindKey("f4","down",function()
	if(isWindowOpen())then
		if(getElementData(localPlayer,"Adminlevel") >= 1)then
			ApocalypseUI.window[1] = guiCreateWindow(364, 226, 655, 379, "Adminsystem", false)

			ApocalypseUI.label[1] = guiCreateLabel(10, 28, 160, 26, "All players:", false, ApocalypseUI.window[1])
			guiSetFont(ApocalypseUI.label[1], "default-bold-small")
			guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "center", false)
			guiLabelSetVerticalAlign(ApocalypseUI.label[1], "center")
			ApocalypseUI.gridlist[1] = guiCreateGridList(10, 64, 160, 305, false, ApocalypseUI.window[1])
			playerGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Player", 0.9)
			ApocalypseUI.button[1] = guiCreateButton(180, 28, 160, 26, "Give adminlevel", false, ApocalypseUI.window[1])
			guiSetProperty(ApocalypseUI.button[1], "NormalTextColour", "FFAAAAAA")
			ApocalypseUI.button[2] = guiCreateButton(180, 64, 160, 26, "Give Coins", false, ApocalypseUI.window[1])
			guiSetProperty(ApocalypseUI.button[2], "NormalTextColour", "FFAAAAAA")
			ApocalypseUI.button[3] = guiCreateButton(180, 100, 160, 26, "Kick player", false, ApocalypseUI.window[1])
			guiSetProperty(ApocalypseUI.button[3], "NormalTextColour", "FFAAAAAA")
			ApocalypseUI.button[4] = guiCreateButton(180, 209, 160, 26, "Ban player", false, ApocalypseUI.window[1])
			guiSetProperty(ApocalypseUI.button[4], "NormalTextColour", "FFAAAAAA")
			ApocalypseUI.label[2] = guiCreateLabel(180, 136, 160, 63, "If you want that the player get a time-ban, enter the number of hours, otherwise he will get a permanent ban.", false, ApocalypseUI.window[1])
			guiSetFont(ApocalypseUI.label[2], "default-bold-small")
			guiLabelSetHorizontalAlign(ApocalypseUI.label[2], "center", true)
			guiLabelSetVerticalAlign(ApocalypseUI.label[2], "center")
			ApocalypseUI.button[5] = guiCreateButton(180, 245, 160, 26, "Give presents", false, ApocalypseUI.window[1])
			guiSetProperty(ApocalypseUI.button[5], "NormalTextColour", "FFAAAAAA")
			ApocalypseUI.button[6] = guiCreateButton(180, 281, 160, 26, "Show player infos", false, ApocalypseUI.window[1])
			guiSetProperty(ApocalypseUI.button[6], "NormalTextColour", "FFAAAAAA")
			ApocalypseUI.label[3] = guiCreateLabel(350, 28, 160, 26, "Reason / ID / Amount:", false, ApocalypseUI.window[1])
			guiSetFont(ApocalypseUI.label[3], "default-bold-small")
			guiLabelSetHorizontalAlign(ApocalypseUI.label[3], "center", false)
			guiLabelSetVerticalAlign(ApocalypseUI.label[3], "center")
			ApocalypseUI.edit[1] = guiCreateEdit(350, 64, 160, 26, "", false, ApocalypseUI.window[1])
			ApocalypseUI.label[4] = guiCreateLabel(350, 100, 160, 26, "Length of the ban in hours:", false, ApocalypseUI.window[1])
			guiSetFont(ApocalypseUI.label[4], "default-bold-small")
			guiLabelSetHorizontalAlign(ApocalypseUI.label[4], "center", false)
			guiLabelSetVerticalAlign(ApocalypseUI.label[4], "center")
			ApocalypseUI.edit[2] = guiCreateEdit(350, 136, 160, 26, "", false, ApocalypseUI.window[1])
			ApocalypseUI.gridlist[2] = guiCreateGridList(350, 172, 160, 135, false, ApocalypseUI.window[1])
			savezoneGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[2], "Savezone", 0.9)
			ApocalypseUI.button[7] = guiCreateButton(350, 317, 160, 26, "Teleport to zone", false, ApocalypseUI.window[1])
			guiSetProperty(ApocalypseUI.button[7], "NormalTextColour", "FFAAAAAA")
			ApocalypseUI.button[8] = guiCreateButton(180, 317, 160, 26, "Teleport to player", false, ApocalypseUI.window[1])
			guiSetProperty(ApocalypseUI.button[8], "NormalTextColour", "FFAAAAAA")
			ApocalypseUI.label[5] = guiCreateLabel(520, 28, 125, 98, "Adminlevel:\n\n0. User\n1. Supporter\n2. Moderator\n3. Administrator\n4. Project Manager", false, ApocalypseUI.window[1])
			guiSetFont(ApocalypseUI.label[5], "default-bold-small")
			setWindowDatas("set")

			for _,v in pairs(getElementsByType("player"))do
				local row = guiGridListAddRow(ApocalypseUI.gridlist[1])
				guiGridListSetItemText(ApocalypseUI.gridlist[1],row,playerGridlist,getPlayerName(v),false,false)
			end
			
			for _,v in pairs(Adminsystem["Savezones"])do
				local row = guiGridListAddRow(ApocalypseUI.gridlist[2])
				guiGridListSetItemText(ApocalypseUI.gridlist[2],row,savezoneGridlist,v,false,false)
			end

			addEventHandler("onClientGUIClick",ApocalypseUI.button[1],function()
				local player = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
				local adminlevel = guiGetText(ApocalypseUI.edit[1])
				if(player ~= "" and #adminlevel >= 1 and tonumber(adminlevel))then
					triggerServerEvent("Adminsystem.givePlayerAdminlevel",localPlayer,player,adminlevel)
				end
			end,false)

			addEventHandler("onClientGUIClick",ApocalypseUI.button[2],function()
				local player = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
				local Coins = guiGetText(ApocalypseUI.edit[1])
				if(player ~= "" and #Coins >= 1 and tonumber(Coins))then
					triggerServerEvent("Adminsystem.giveCoins",localPlayer,player,Coins)
				end
			end,false)
			
			addEventHandler("onClientGUIClick",ApocalypseUI.button[3],function()
				local player = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
				local reason = guiGetText(ApocalypseUI.edit[1])
				if(player ~= "" and #reason >= 1)then
					triggerServerEvent("Adminsystem.kickPlayer",localPlayer,player,reason)
				end
			end,false)

			addEventHandler("onClientGUIClick",ApocalypseUI.button[4],function()
				local player  = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
				local reason  = guiGetText(ApocalypseUI.edit[1])
				local banTime = guiGetText(ApocalypseUI.edit[2])
				if(player ~= "" and #reason >= 1)then
					if(#banTime >= 1 and tonumber(banTime))then banTime = banTime else banTime = 0 end
					triggerServerEvent("Adminsystem.banPlayer",localPlayer,player,reason,banTime)
				end
			end,false)

			addEventHandler("onClientGUIClick",ApocalypseUI.button[5],function()
				local player = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
				local presents = guiGetText(ApocalypseUI.edit[1])
				if(player ~= "" and #presents >= 1 and tonumber(presents))then
					triggerServerEvent("Adminsystem.givePresents",localPlayer,player,presents)
				end
			end,false)

			addEventHandler("onClientGUIClick",ApocalypseUI.button[6],function()
				local player = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
				if(player ~= "")then
					triggerServerEvent("Adminsystem.showPlayerInfos",localPlayer,player)
				end
			end,false)

			addEventHandler("onClientGUIClick",ApocalypseUI.button[7],function()
				local zone = getItemFromGridlist(ApocalypseUI.gridlist[2],1)
				if(zone ~= "")then
					triggerServerEvent("Adminsystem.teleportToZone",localPlayer,zone)
				end
			end,false)

			addEventHandler("onClientGUIClick",ApocalypseUI.button[8],function()
				local player = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
				if(player ~= "")then
					triggerServerEvent("Adminsystem.teleportToPlayer",localPlayer,player)
				end
			end,false)
		end
	end
end)

function getItemFromGridlist(gridlist,position)
	if(isElement(gridlist))then
		return guiGridListGetItemText(gridlist,guiGridListGetSelectedItem(gridlist),position)
	end
end