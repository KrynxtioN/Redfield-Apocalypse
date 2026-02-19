Weaponshop = {
	--// Name, Price, Level, Ammo
	{"Colt 45",75,0,68},
	{"Silenced",100,0,68},
	{"Desert Eagle",250,0,42},
	{"Shotgun",500,2,30},
	{"Sawed-off",750,2,18},
	{"Combat Shotgun",1250,3,35},
	{"Uzi",1500,5,200},
	{"Mp5",1800,5,120},
	{"Tec-9",2000,6,200},
	{"AK-47",2200,9,250},
	{"M4",2500,11,300},
	{"Rifle",3000,12,50},
	{"Sniper",6000,18,25},
	{"Rocket Launcher",10000,25,5},
	{"Rocket Launcher HS",12500,25,5},
	{"Flamethrower",20000,30,250},
	{"Minigun",35000,45,1000},
	{"Grenade",40000,50,25},
	{"Molotov",40000,50,25},
	{"Satchel",50000,75,30},
}

addEvent("Weaponshop.createWindow",true)
addEventHandler("Weaponshop.createWindow",root,function()
	if(isWindowOpen())then
        ApocalypseUI.window[1] = guiCreateWindow(496, 288, 411, 255, "Weapon Shop", false)

        ApocalypseUI.gridlist[1] = guiCreateGridList(9, 25, 392, 179, false, ApocalypseUI.window[1])
        weaponGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Weapon", 0.4)
        priceGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Price", 0.2)
        levelGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Level", 0.2)
        ammoGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Ammo", 0.2)
        ApocalypseUI.button[1] = guiCreateButton(126, 215, 158, 30, "Buy", false, ApocalypseUI.window[1])
        guiSetProperty(ApocalypseUI.button[1], "NormalTextColour", "FFAAAAAA")
		setWindowDatas("set")

		for _,v in pairs(Weaponshop)do
			local row = guiGridListAddRow(ApocalypseUI.gridlist[1])
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,weaponGridlist,v[1],false,false)
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,priceGridlist,"$"..v[2],false,false)
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,levelGridlist,v[3],false,false)
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,ammoGridlist,v[4],false,false)
		end
		
		addEventHandler("onClientGUIClick",ApocalypseUI.button[1],function()
			local weapon = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
			if(not(weapon == ""))then
				triggerServerEvent("Weaponshop.buy",localPlayer,weapon)
			end
		end,false)
	end
end)