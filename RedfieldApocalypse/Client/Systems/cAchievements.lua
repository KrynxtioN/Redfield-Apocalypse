Color = {
	[1] = {0,255,0},
	[0] = {255,0,0},
}

Achievements = {
	["Achievements"] = {
		{"Hello!","Create an account."},
		{"Let the show begin","Kill your first zombie."},
		{"Let's go!","Buy your first weapon."},
		{"It works","Use a vehicle."},
		{"At least something","Kill 1.000 zombies."},
		{"Not enough!","Kill 10.000 zombies"},
		{"Fuck this fucking zombies","Kill 100.000 zombies"},
		{"The Walking Dead","Kill 1.000.000 zombies"},
	},
}

addEvent("Achievements.createWindow",true)
addEventHandler("Achievements.createWindow",root,function(tbl)
	if(isWindowOpen())then
		ApocalypseUI.window[1] = guiCreateWindow(415, 252, 556, 323, "Achievements", false)

		ApocalypseUI.gridlist[1] = guiCreateGridList(11, 27, 259, 286, false, ApocalypseUI.window[1])
		id = guiGridListAddColumn(ApocalypseUI.gridlist[1], "ID", 0.2)
		achievement = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Achievement", 0.8)
		ApocalypseUI.label[1] = guiCreateLabel(280, 27, 266, 41, "Choose an achievement.", false, ApocalypseUI.window[1])
		guiSetFont(ApocalypseUI.label[1], "default-bold-small")
		guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "center", false)
		guiLabelSetVerticalAlign(ApocalypseUI.label[1], "center")
		ApocalypseUI.label[2] = guiCreateLabel(280, 78, 266, 17, "_______________________________________", false, ApocalypseUI.window[1])
		guiSetFont(ApocalypseUI.label[2], "default-bold-small")
		guiLabelSetHorizontalAlign(ApocalypseUI.label[2], "center", false)
		guiLabelSetVerticalAlign(ApocalypseUI.label[2], "center")
		ApocalypseUI.label[3] = guiCreateLabel(280, 105, 266, 41, "No achievement choosed.", false, ApocalypseUI.window[1])
		guiSetFont(ApocalypseUI.label[3], "default-bold-small")
		guiLabelSetHorizontalAlign(ApocalypseUI.label[3], "center", false)
		guiLabelSetVerticalAlign(ApocalypseUI.label[3], "center")
		ApocalypseUI.staticimage[1] = guiCreateStaticImage(360, 183, 107, 103, "Files/Images/Achievement_locked.png", false, ApocalypseUI.window[1])
		ApocalypseUI.label[4] = guiCreateLabel(280, 296, 266, 17, "_______________________________________", false, ApocalypseUI.window[1])
		guiSetFont(ApocalypseUI.label[4], "default-bold-small")
		guiLabelSetHorizontalAlign(ApocalypseUI.label[4], "center", false)
		guiLabelSetVerticalAlign(ApocalypseUI.label[4], "center")
		ApocalypseUI.label[5] = guiCreateLabel(280, 156, 266, 17, "_______________________________________", false, ApocalypseUI.window[1])
		guiSetFont(ApocalypseUI.label[5], "default-bold-small")
		guiLabelSetHorizontalAlign(ApocalypseUI.label[5], "center", false)
		guiLabelSetVerticalAlign(ApocalypseUI.label[5], "center")
		setWindowDatas("set")
		
		if(#tbl >= 1)then
			for i,v in pairs(tbl)do
				local row = guiGridListAddRow(ApocalypseUI.gridlist[1])
				guiGridListSetItemText(ApocalypseUI.gridlist[1],row,id,i,false,false)
				guiGridListSetItemText(ApocalypseUI.gridlist[1],row,achievement,v[1],false,false)
				guiGridListSetItemColor(ApocalypseUI.gridlist[1],row,achievement,Color[v[2]][1],Color[v[2]][2],Color[v[2]][3])
			end
		end
		
		addEventHandler("onClientGUIClick",ApocalypseUI.gridlist[1],function()
			local clicked = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
			if(clicked ~= "")then
				triggerServerEvent("Achievements.getDatas",localPlayer,clicked)
				guiSetText(ApocalypseUI.label[3],Achievements["Achievements"][tonumber(clicked)][2])
			end
		end,false)
	end
end)

addEvent("Achievements.setDatas",true)
addEventHandler("Achievements.setDatas",root,function(reached)
	if(reached == 0)then reached = {"locked","You not reached this achievement."} else reached = {"reached","You reached this achievement."} end
	guiStaticImageLoadImage(ApocalypseUI.staticimage[1],"Files/Images/Achievement_"..reached[1]..".png")
	guiSetText(ApocalypseUI.label[1],reached[2])
end)

function Achievements.dxDraw()
	if(isWindowOpen() and not(isPlayerMapVisible(localPlayer)))then
        dxDrawRectangle(0*(x/1440), 396*(y/900), 1440*(x/1440), 108*(y/900), tocolor(0, 0, 0, 175), false)
        dxDrawText("You reached the achievement '"..Achievements.text.."' and got a trophy.", 0*(x/1440), 396*(y/900), 1440*(x/1440), 504*(y/900), tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, true, false, false, false)
	end
end

addEvent("Achievements.showInfo",true)
addEventHandler("Achievements.showInfo",root,function(id)
	Achievements.text = Achievements["Achievements"][id][1]
	if(getElementData(localPlayer,"elementClicked") ~= true)then
		addEventHandler("onClientRender",root,Achievements.dxDraw)
		setTimer(function()
			removeEventHandler("onClientRender",root,Achievements.dxDraw)
		end,10000,1)
	else
		outputChatBox("#fa6400[INFO] #FFFFFFYou reached the achievement #fa6400'"..Achievements.text.."' #FFFFFFand got a trophy.",255,255,255,true)
	end
end)