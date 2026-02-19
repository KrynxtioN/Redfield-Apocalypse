Weaponshop = {
	-- Name, Price, Weapon-ID, Ammo, Level, Slot
	["Colt 45"] = {75,22,68,0,2},
	["Silenced"] = {100,23,68,0,2},
	["Desert Eagle"] = {250,24,42,0,2},
	["Shotgun"] = {500,25,30,2,3},
	["Sawed-off"] = {750,26,18,2,3},
	["Combat Shotgun"] = {1250,27,35,3,3},
	["Uzi"] = {1500,28,200,5,4},
	["Mp5"] = {1800,29,120,5,4},
	["Tec-9"] = {2000,32,200,6,4},
	["AK-47"] = {2200,30,250,9,5},
	["M4"] = {2500,31,300,11,5},
	["Rifle"] = {3000,33,50,12,6},
	["Sniper"] = {6000,34,25,18,6},
	["Rocket Launcher"] = {10000,35,5,25,7},
	["Rocket Launcher HS"] = {12500,36,5,25,7},
	["Flamethrower"] = {20000,37,250,30,7},
	["Minigun"] = {35000,38,1000,45,7},
	["Grenade"] = {40000,16,25,50,8},
	["Molotov"] = {40000,18,25,50,8},
	["Satchel"] = {50000,39,30,75,8},
	["AvailableWeapons"] = {
		"Colt 45","Silenced","Desert Eagle","Shotgun","Sawed-off","Combat Shotgun","Uzi","Mp5","Tec-9","AK-47","M4","Rifle","Sniper","Rocket Launcher","Rocket Launcher HS","Flamethrower","Minigun","Grenade","Molotov","Satchel"
	},
}

addEvent("Weaponshop.buy",true)
addEventHandler("Weaponshop.buy",root,function(weapon)
	if(getElementData(client,"Level") >= Weaponshop[weapon][4])then
		if(getElementData(client,"Money") >= Weaponshop[weapon][1])then
			local handWeapon = getPedWeapon(client,Weaponshop[weapon][5])
			if(handWeapon and handWeapon ~= Weaponshop[weapon][2])then
				takeWeapon(client,handWeapon)
			end
			setElementData(client,"Money",getElementData(client,"Money")-Weaponshop[weapon][1])
			giveWeapon(client,Weaponshop[weapon][2],Weaponshop[weapon][3],true)
			setPlayerAchievement(client,3)
			infobox(client,"You bought the weapon.",0,255,0)
		else infobox(client,"You don't have enough money!",255,0,0)end
	else infobox(client,"You have to be at least level "..Weaponshop[weapon][4].." to buy this weapon!",255,0,0)end
end)

function Weaponshop.giveRandomWeapon(player)
	local rnd = math.random(1,#Weaponshop["AvailableWeapons"])
	local weapon = Weaponshop["AvailableWeapons"][rnd]
	local handWeapon = getPedWeapon(player,Weaponshop[weapon][5])
	if(handWeapon and handWeapon ~= Weaponshop[weapon][2])then
		takeWeapon(player,handWeapon)
	end
	giveWeapon(player,Weaponshop[weapon][2],Weaponshop[weapon][3],true)
	infobox(player,"You got a weapon.",0,255,0)
end