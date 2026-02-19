local Team = createTeam("ApocalypseUI")

Payday = {}
RegisterLogin = {}
local Datas = {"Level","ExperiencePoints","Zombiekills","Team","Teamrang","Deaths","Playingtime","Bonuspoints","Adminlevel","Chests","Hearts","Weeklychest","Weapondepot","Coins","EasterEggs","Trophys","LifetimePremium","Zombieskin","Money","Posx","Posy","Posz","Presents","TresorKeys"}

addEvent("RegisterLogin.checkAccount",true)
addEventHandler("RegisterLogin.checkAccount",root,function()
	local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata WHERE Username = '"..getPlayerName(client).."'"),-1)
	if(#result >= 1)then var = "Login" else var = "Register" end
	triggerClientEvent(client,"RegisterLogin.createWindow",client,var)
end)

addEvent("RegisterLogin.server",true)
addEventHandler("RegisterLogin.server",root,function(type,password)
	local hashedPassword = passwordHash(password,"bcrypt",{})
	if(type == "Login")then
		local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata WHERE Username = '"..getPlayerName(client).."'"),-1)
		if(#result >= 1)then
			if(passwordVerify(password,hashedPassword))then
				RegisterLogin.setDatasAfterLogin(client)
			else infobox(client,"The password is not correct! If you do not have an account with us, your name is already taken.",255,0,0)end
		else infobox(client,"There's no account with this name in our database!",255,0,0)end
	else
		local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata WHERE Serial = '"..getPlayerSerial(client).."'"),-1)
		if(#result == 0)then
			dbExec(handler,"INSERT INTO userdata (Username,Password,Serial) VALUES ('"..getPlayerName(client).."','"..hashedPassword.."','"..getPlayerSerial(client).."')")
			dbExec(handler,"INSERT INTO achievements (Username) VALUES ('"..getPlayerName(client).."')")
			dbExec(handler,"INSERT INTO weaponskills (Username) VALUES ('"..getPlayerName(client).."')")
			RegisterLogin.setDatasAfterLogin(client)
		else infobox(client,"You already have a account with the name "..getPlayerData("userdata","Serial",getPlayerSerial(client),"Username").." on this server!",255,0,0)end
	end
end)

function RegisterLogin.setDatasAfterLogin(player)
	for _,v in pairs(Datas)do
		setElementData(player,v,getPlayerData("userdata","Username",getPlayerName(player),v))
	end
	setElementData(player,"loggedin",1)
	setElementData(player,"dangercount",0)
	setElementData(player,"alreadyspawned",true)
	triggerClientEvent(player,"setWindowDatas",player,"reset")
	triggerClientEvent(player,"RegisterLogin.destroySound",player)
	setPlayerAchievement(player,1)
	if(getElementData(player,"Team") >= 1)then
		setElementData(player,"Teamname",getPlayerData("teams","ID",getElementData(player,"Team"),"Name"))
	else
		setElementData(player,"Teamname","-")
	end
	
	setCameraTarget(player)
	triggerClientEvent(player,"removeCamHandler",player)
	RegisterLogin.spawnPlayer(player)
	Premium.check(player)
	Weather.set(player)
	checkOfflineMessages(player)
	Weaponskills.setPedStat(player)
	Teamsystem.updateBlips()
	bindKey(player,"f2","down",Teamsystem.openTeampanel)
	bindKey(player,"f3","down",Achievements.openWindow)
	triggerClientEvent(player,"dxDrawHUD",player)
	News.check(player)
	setPlayerTeam(player,Team)
	loadPlayerVehicles(player)
	
	Payday[player] = setTimer(function(player)
		if(player and getElementData(player,"loggedin") == 1)then
			Premium.check(player)
			setElementData(player,"Playingtime",getElementData(player,"Playingtime")+1)
			if(isPremium(player))then
				if(math.floor(getElementData(player,"Playingtime")/60) == (getElementData(player,"Playingtime")/60))then
					local money = getElementData(player,"Level")*75
					local experiencepoints = getElementData(player,"Level")*25 + getElementData(player,"Trophys")*25
					if(math.random(1,200) == 56)then coins = 1 else coins = 0 end
					setElementData(player,"Money",getElementData(player,"Money")+money)
					setElementData(player,"ExperiencePoints",getElementData(player,"ExperiencePoints")+experiencepoints)
					setElementData(player,"Coins",getElementData(player,"Coins")+coins)
					
					triggerClientEvent(player,"Payday.dxDraw",player,money,experiencepoints,coins)
				end
			end
		end
	end,60000,0,player)
	
	--// Give saved weapons
	local result = dbPoll(dbQuery(handler,"SELECT Weapons FROM logout WHERE Username = '"..getPlayerName(player).."'"),-1)
	if(result and result[1])then
		local weapons = result[1]["Weapons"]
		for i = 1,12 do
			local wstring = gettok(weapons,i,string.byte("|"))
			if(wstring and #wstring >= 3)then
				local weapon = tonumber(gettok(wstring,1,string.byte(",")))
				local ammo = tonumber(gettok(wstring,2,string.byte(",")))
				giveWeapon(player,weapon,ammo,true)
			end
		end
		dbExec(handler,"DELETE FROM logout WHERE Username = '"..getPlayerName(player).."'")
	end
end

function RegisterLogin.savePlayerDatas(player)
	if(getElementData(player,"loggedin") == 1)then
		for _,v in pairs(Datas)do
			dbExec(handler,"UPDATE userdata SET "..v.." = '"..getElementData(player,v).."' WHERE Username = '"..getPlayerName(player).."'")
		end
		
		local x,y,z = getElementPosition(player)
		if(getElementData(player,"ZombieSkinUse") == true)then model = Inventory.saveSkin[player] else model = getElementModel(player)end
		dbExec(handler,"UPDATE userdata SET Posx = '"..x.."', Posy = '"..y.."', Posz = '"..z.."', Skin = '"..model.."' WHERE Username = '"..getPlayerName(player).."'")
		
		Weaponskills.save(player)
		
		--// Save player weapons
		if(isPremium(player))then
			local curWeaponsForSave = "|"
			for i = 1,11 do
				if(i ~= 10)then
					local weapon = getPedWeapon(player,i)
					local ammo = getPedTotalAmmo(player,i)
					if(weapon and ammo)then
						if(weapon >= 1 and ammo >= 1)then
							if(#curWeaponsForSave <= 40)then
								curWeaponsForSave = curWeaponsForSave..weapon..","..ammo.."|"
							end
						end
					end
				end
			end
			if(#curWeaponsForSave >= 5)then
				dbExec(handler,"INSERT INTO logout (Username,Weapons) VALUES ('"..getPlayerName(player).."','"..curWeaponsForSave.."')")
			end
		end
	end
end

function RegisterLogin.spawnPlayer(player)
	local x,y,z = getPlayerData("userdata","Username",getPlayerName(player),"Posx"),getPlayerData("userdata","Username",getPlayerName(player),"Posy"),getPlayerData("userdata","Username",getPlayerName(player),"Posz")
	local skin = getPlayerData("userdata","Username",getPlayerName(player),"Skin")
	local result = dbPoll(dbQuery(handler,"SELECT * FROM houses WHERE Owner = '"..getElementData(player,"Team").."'"),-1)
	
	if(result and #result >= 1)then
		local ID = getPlayerData("houses","Owner",getElementData(player,"Team"),"ID")
		local x,y,z = getElementPosition(Houses[ID])
		spawnPlayer(player,x,y,z,_,skin)
	else
		spawnPlayer(player,x,y,z,_,skin)
	end
	
	if(getElementData(player,"Money") <= 500)then
		giveWeapon(player,22,85,true)
	end
end

addEventHandler("onPlayerQuit",root,function()
	if(getElementData(source,"loggedin") == 1)then
		Teamsystem.updateBlips()
		RegisterLogin.savePlayerDatas(source)
		if(isTimer(Payday[source]))then killTimer(Payday[source])end
	end
end)
