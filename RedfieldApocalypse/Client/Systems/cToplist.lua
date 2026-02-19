Toplist = {"Level","Zombiekills","Bonuspoints","Coins","Trophys","Money"}

addEvent("Toplist.createWindow",true)
addEventHandler("Toplist.createWindow",root,function()
	if(isWindowOpen())then
		ApocalypseUI.window[1] = guiCreateWindow(490, 241, 395, 297, "Toplist", false)

		ApocalypseUI.gridlist[1] = guiCreateGridList(10, 27, 180, 260, false, ApocalypseUI.window[1])
		category = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Category", 0.9)
		ApocalypseUI.label[1] = guiCreateLabel(200, 27, 185, 260, "Choose a category.", false, ApocalypseUI.window[1])
		guiSetFont(ApocalypseUI.label[1], "default-bold-small")
		setWindowDatas("set")
		
		for _,v in pairs(Toplist)do
			local row = guiGridListAddRow(ApocalypseUI.gridlist[1])
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,category,v,false,false)
		end
		
		addEventHandler("onClientGUIClick",ApocalypseUI.gridlist[1],function()
			local category = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
			if(not(category == ""))then
				triggerServerEvent("Toplist.getDatas",localPlayer,category)
			end
		end,false)
	end
end)

addEvent("Toplist.setDatas",true)
addEventHandler("Toplist.setDatas",root,function(datas)
	if(#datas >= 1)then
		local text = ""
		for i = 1,#datas do
			text = text..i..". "..datas[i][1].." ("..datas[i][2]..")\n"
		end
		guiSetText(ApocalypseUI.label[1],text)
	end
end)