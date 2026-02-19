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

function Achievements.openWindow(player)
	local tbl = {}
	for i,v in pairs(Achievements["Achievements"])do
		local reached = getPlayerData("achievements","Username",getPlayerName(player),"Achievement"..i)
		table.insert(tbl,{v[1],reached})
	end
	triggerClientEvent(player,"Achievements.createWindow",player,tbl)
end

addEvent("Achievements.getDatas",true)
addEventHandler("Achievements.getDatas",root,function(clicked)
	local reached = getPlayerData("achievements","Username",getPlayerName(client),"Achievement"..clicked)
	triggerClientEvent(client,"Achievements.setDatas",client,reached)
end)

function setPlayerAchievement(player,id)
	local reached = getPlayerData("achievements","Username",getPlayerName(player),"Achievement"..id)
	if(reached == 0)then
		dbExec(handler,"UPDATE achievements SET Achievement"..id.." = 1 WHERE Username = '"..getPlayerName(player).."'")
		triggerClientEvent(player,"Achievements.showInfo",player,id)
		setElementData(player,"Trophys",getElementData(player,"Trophys")+1)
	end
end