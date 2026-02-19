Coinshop = {
	["Article"] = {
		{"Weapon Depot",10},
		{"Premium (14 days)",5},
		{"Lifetime Premium",50},
		{"Zombie Skin",25},
	},
	["Infos"] = {
		["Weapon Depot"] = "The Weapon Depot allows you to store up to 15 weapons, which you can then access from anywhere.",
		["Premium (14 days)"] = "A active premium-status give you some advantages. You can find out exactly what these are from the helpmenu under F1.",
		["Lifetime Premium"] = "A active premium-status give you some advantages. You can find out exactly what these are from the helpmenu under F1.",
		["Zombie Skin"] = "If you wear the Zombie-Skin, the zombies will not attack you anymore.",
	},
}

addEvent("Coinshop.createWindow",true)
addEventHandler("Coinshop.createWindow",root,function()
	if(isWindowOpen())then
        ApocalypseUI.window[1] = guiCreateWindow(406, 283, 430, 253, "Coinshop", false)

        ApocalypseUI.label[1] = guiCreateLabel(10, 27, 410, 74, "Click on a item to get infos of it.", false, ApocalypseUI.window[1])
        guiSetFont(ApocalypseUI.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "center", true)
        guiLabelSetVerticalAlign(ApocalypseUI.label[1], "center")
        ApocalypseUI.gridlist[1] = guiCreateGridList(10, 111, 268, 132, false, ApocalypseUI.window[1])
        itemGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Item", 0.5)
        priceGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Price", 0.5)
        ApocalypseUI.button[1] = guiCreateButton(288, 215, 132, 28, "Buy", false, ApocalypseUI.window[1])
        guiSetProperty(ApocalypseUI.button[1], "NormalTextColour", "FFAAAAAA")
        ApocalypseUI.button[2] = guiCreateButton(288, 177, 132, 28, "Exchange Bonuspoints", false, ApocalypseUI.window[1])
        guiSetProperty(ApocalypseUI.button[2], "NormalTextColour", "FFAAAAAA")
		setWindowDatas("set")

		for _,v in pairs(Coinshop["Article"])do
			local row = guiGridListAddRow(ApocalypseUI.gridlist[1])
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,itemGridlist,v[1],false,false)
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,priceGridlist,v[2],false,false)
		end
		
		addEventHandler("onClientGUIClick",ApocalypseUI.gridlist[1],function()
			local item = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
			if(item ~= "")then
				guiSetText(ApocalypseUI.label[1],Coinshop["Infos"][item])
			end
		end,false)
		
		addEventHandler("onClientGUIClick",ApocalypseUI.button[1],function()
			local item = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
			if(item ~= "")then
				triggerServerEvent("Coinshop.buy",localPlayer,item)
			end
		end,false)
		
		addEventHandler("onClientGUIClick",ApocalypseUI.button[2],function()
			destroyElement(ApocalypseUI.window[1])

			ApocalypseUI.window[1] = guiCreateWindow(406, 283, 317, 143, "Coinshop", false)

			ApocalypseUI.button[1] = guiCreateButton(93, 105, 132, 28, "Exchange Bonuspoints", false, ApocalypseUI.window[1])
			guiSetProperty(ApocalypseUI.button[1], "NormalTextColour", "FFAAAAAA")
			ApocalypseUI.label[1] = guiCreateLabel(10, 26, 297, 34, "1 Coin costs 500 bonuspoints.", false, ApocalypseUI.window[1])
			guiSetFont(ApocalypseUI.label[1], "default-bold-small")
			guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "center", false)
			guiLabelSetVerticalAlign(ApocalypseUI.label[1], "center")
			ApocalypseUI.label[2] = guiCreateLabel(10, 70, 118, 25, "Amount:", false, ApocalypseUI.window[1])
			guiSetFont(ApocalypseUI.label[2], "default-bold-small")
			guiLabelSetHorizontalAlign(ApocalypseUI.label[2], "center", false)
			guiLabelSetVerticalAlign(ApocalypseUI.label[2], "center")
			ApocalypseUI.edit[1] = guiCreateEdit(138, 70, 169, 25, "", false, ApocalypseUI.window[1])    
			centerWindow(ApocalypseUI.window[1])
			
			addEventHandler("onClientGUIClick",ApocalypseUI.button[1],function()
				local amount = guiGetText(ApocalypseUI.edit[1])
				if(#amount >= 1 and tonumber(amount))then
					triggerServerEvent("Coinshop.exchange",localPlayer,amount)
				end
			end,false)
		end,false)
	end
end)