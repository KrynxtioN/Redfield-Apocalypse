Weapondepot = {
	[22] = {"Colt 45",2},
	[23] = {"Silenced",2},
	[24] = {"Desert Eagle",2},
	[25] = {"Shotgun",3},
	[26] = {"Sawed-off",3},
	[27] = {"Combat Shotgun",3},
	[28] = {"Uzi",4},
	[29] = {"Mp5",4},
	[32] = {"Tec-9",4},
	[30] = {"AK-47",5},
	[31] = {"M4",5},
	[33] = {"Country Rifle",6},
	[34] = {"Sniper",6},
	[35] = {"Rocket Launcher",7},
	[36] = {"Rocket Launcher HS",7},
	[37] = {"Flamethrower",7},
	[38] = {"Minigun",7},
	[16] = {"Grenade",8},
	[18] = {"Molotov",8},
	[39] = {"Satchel",8},
}

addEvent("Weapondepot.getWeapons",true)
addEventHandler("Weapondepot.getWeapons",root,function()
	Weapondepot.handWeapons  = {}
	Weapondepot.depotWeapons = {}
	local result = dbPoll(dbQuery(handler,"SELECT * FROM weapondepot WHERE Username = '"..getPlayerName(client).."'"),-1)
	
	for _,v in pairs(result)do
		table.insert(Weapondepot.depotWeapons,{v["ID"],Weapondepot[v["WeaponID"]][1],v["WeaponAmmo"]})
	end
	
	for i = 1,11 do
		if(i ~= 10)then
			local weapon = getPedWeapon(client,i)
			local ammo   = getPedTotalAmmo(client,i)
			if(weapon and ammo)then
				if(weapon >= 1 and ammo >= 1)then
					table.insert(Weapondepot.handWeapons,{Weapondepot[weapon][1],ammo})
				end
			end
		end
	end
	triggerClientEvent(client,"Weapondepot.refresh",client,Weapondepot.handWeapons,Weapondepot.depotWeapons)
end)

addEvent("Weapondepot.store",true)
addEventHandler("Weapondepot.store",root,function(id)
	local result = dbPoll(dbQuery(handler,"SELECT * FROM weapondepot WHERE Username = '"..getPlayerName(client).."'"),-1)
	if(#result <= 15)then
		local weapon = getPedWeapon(client,Weapondepot[id][2])
		local ammo   = getPedTotalAmmo(client,Weapondepot[id][2])
		dbExec(handler,"INSERT INTO weapondepot (Username,WeaponID,WeaponAmmo) VALUES ('"..getPlayerName(client).."','"..id.."','"..ammo.."')")
		takeWeapon(client,weapon)
	end
end)

addEvent("Weapondepot.outsource",true)
addEventHandler("Weapondepot.outsource",root,function(id)
	local weapon = getPlayerData("weapondepot","ID",id,"WeaponID")
	local ammo = getPlayerData("weapondepot","ID",id,"WeaponAmmo")
	giveWeapon(client,weapon,ammo,true)
	dbExec(handler,"DELETE FROM weapondepot WHERE ID = '"..id.."'")
end)