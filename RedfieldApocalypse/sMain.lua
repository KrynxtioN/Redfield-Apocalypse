createBlip(-1968.5,114.30000305176,27.700000762939,6,0,0,0,0,0,0,100,root) 				-- Weaponshop SF
createBlip(-221.46185302734,2739.3796386719,62.6875,6,0,0,0,0,0,0,100,root)	 			-- Weaponshop Chicken Valley
createBlip(-1957.8000488281,307.89999389648,35.5,55,0,0,0,0,0,0,100,root) 				-- Wang Cars
createBlip(-2532.0510253906,-624.38592529297,132.74740600586,25,0,0,0,0,0,0,100,root) 	-- Safes
	
Main = {}

handler = dbConnect("mysql","dbname=dre4mysapocalypse;host=localhost","root","")
Serverinfos = {name = "Redfield Apocalypse", version = "v.1.1.0"}

setFPSLimit(65)
setGameType(Serverinfos.name.." "..Serverinfos.version)

local realtime = getRealTime()
setTime(realtime.hour,realtime.minute)
setMinuteDuration(60000)

function getPlayerData(from,where,name,data)
	local sql = dbQuery(handler,"SELECT * FROM "..from.." WHERE "..where.." = '"..name.."'")
	if(sql)then
		local rows = dbPoll(sql,-1)
		for _,v in pairs(rows)do
			return v[data]
		end
	end
end

function isLoggedIn(player)
	if(getElementData(player,"loggedin") == 1)then
		return true
	else
		return false
	end
end

function getSecTime(duration)
	local time = getRealTime()
	local year = time.year
	local day = time.yearday
	local hour = time.hour
	local minute = time.minute
	
	return year * 365 * 24 * 60 + day * 24 * 60 + (hour + duration) * 60 + minute
end

function infobox(player,text,r,g,b)
	triggerClientEvent(player,"infobox",player,text,r,g,b)
end

function existPlayer(player,target)
	if(isElement(target))then
		return true
	else
		infobox(player,"Can't find the player!",255,0,0)
		return false
	end
end

addEventHandler("onPlayerWasted",root,function()
	triggerClientEvent(source,"setWindowDatas",source,"reset")
	setElementData(source,"Deaths",getElementData(source,"Deaths")+1)
	dbExec(handler,"UPDATE userdata SET Posx = '-1963.5256347656', Posy = '127.15285491943', Posz = '27.6875' WHERE Username = '"..getPlayerName(source).."'")
	
	setTimer(function(source)
		if(source)then
			fadeCamera(source,true)
			RegisterLogin.spawnPlayer(source)
		end
	end,3000,1,source)
end)

addEventHandler("onPedWasted",root,function(ammo,attacker,weapon,bodypart)
	if(getElementData(source,"zombie") and getElementData(source,"zombie") == true)then
		if(attacker and getElementData(attacker,"Zombiekills"))then
			local x,y,z = getElementPosition(source)
			setElementData(attacker,"Zombiekills",getElementData(attacker,"Zombiekills")+1)
			
			local time = getRealTime()
			local Experience,Money = 5,25
			if(time.hour >= 20 and time.hour <= 21)then
				Experience = 10
				Money = 50
			end
			if(isPremium(attacker))then
				Levelsystem.giveExperiencePoints(attacker,Experience*2)
				setElementData(attacker,"Money",getElementData(attacker,"Money")+Money*2)
			else
				Levelsystem.giveExperiencePoints(attacker,Experience)
				setElementData(attacker,"Money",getElementData(attacker,"Money")+Money)
			end
			Levelsystem.nearbyTeammates(attacker)
			if(math.random(1,10) == 5)then
				local bonuspoint = createPickup(x,y,z,3,3082,50)
				addEventHandler("onPickupHit",bonuspoint,function(player)
					if(not(isPedInVehicle(player)))then
						local menge = 1
						if(isPremium(player))then if(math.random(1,4) == 2)then menge = 2 end end
						destroyElement(source)
						setElementData(player,"Bonuspoints",getElementData(player,"Bonuspoints")+menge)
					end
				end)
			end
			
			if(bodypart == 9 and math.random(1,100) == 50)then
				if(getElementData(attacker,"TresorKeys") <= 5)then
					setElementData(attacker,"TresorKeys",getElementData(attacker,"TresorKeys")+1)
					infobox(attacker,"You got a key!",0,255,0)
				end
			end
			
			--// Fireman explosion
			if(getPedSkin(source) == 277)then createExplosion(x,y,z,3) end
			
			--// Army
			if(getPedSkin(source) == 287)then
				if(math.random(1,3) == 2)then
					local number = math.random(1,999)
					if(number >= 1 and number <= 750)then
						weaponID = 31
						weaponAmmo = 300
						weaponPickupID = 356
					elseif(number >= 751 and number <= 950)then
						weaponID = 36
						weaponAmmo = 10
						weaponPickupID = 360
					elseif(number >= 951 and number <= 999)then
						weaponID = 38
						weaponAmmo = 250
						weaponPickupID = 362
					end
					local pickup = createPickup(x,y,z,3,weaponPickupID,50)
					setElementData(pickup,"weaponID",weaponID)
					setElementData(pickup,"weaponAmmo",weaponAmmo)
					
					addEventHandler("onPickupHit",pickup,function(player)
						if(not(isPedInVehicle(player)))then
							local weapon,ammo = getElementData(source,"weaponID"),getElementData(source,"weaponAmmo")
							if(isPremium(player))then ammo = ammo*2 end
							giveWeapon(player,weapon,ammo,true)
							destroyElement(source)
						end
					end)
				end
			end
			
			--// Doctor
			if(getPedSkin(source) == 70)then
				if(math.random(1,2) == 2)then
					local pickup = createPickup(x,y,z,3,1240,50)
					addEventHandler("onPickupHit",pickup,function(player)
						if(not(isPedInVehicle(player)))then
							if(getElementData(player,"Hearts") < 2)then
								setElementData(player,"Hearts",getElementData(player,"Hearts")+1)
								destroyElement(source)
							else infobox(player,"You can only have a maximum of two medicines with you!",255,0,0)end
						end
					end)
				end
			end
			
			if(getElementData(attacker,"Zombiekills") >= 1)then setPlayerAchievement(attacker,2)end
			if(getElementData(attacker,"Zombiekills") >= 1000)then setPlayerAchievement(attacker,5)end
			if(getElementData(attacker,"Zombiekills") >= 10000)then setPlayerAchievement(attacker,6)end
			if(getElementData(attacker,"Zombiekills") >= 100000)then setPlayerAchievement(attacker,7)end
			if(getElementData(attacker,"Zombiekills") >= 1000000)then setPlayerAchievement(attacker,8)end
		end
	end
end)

addEventHandler("onPlayerChat",root,function(message,messageType)
	if(messageType == 0)then
		outputChatBox(getPlayerName(source)..": "..message,root,255,255,255)
	elseif(messageType == 2)then
		executeCommandHandler("t",source,message)
	end
	cancelEvent()
end)

addCommandHandler("t",function(player,cmd,...)
	local tbl = {...}
	local text =  table.concat(tbl," ")
	if(getElementData(player,"Team") >= 1)then
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"loggedin") == 1)then
				if(getElementData(v,"Team") == getElementData(player,"Team"))then
					outputChatBox(getPlayerName(player).." (Rang: "..getElementData(player,"Teamrang").."): "..text,v,42, 187, 255)
				end
			end
		end
	end
end)

addCommandHandler("pay",function(player,cmd,target,money)
	if(isLoggedIn(player))then
		if(target and money)then
			if(getElementData(player,"Money") >= tonumber(money))then
				local target = getPlayerFromName(target)
				if(existPlayer(player,target))then
					setElementData(player,"Money",getElementData(player,"Money")-money)
					setElementData(target,"Money",getElementData(target,"Money")+money)
					infobox(player,"You gave "..getPlayerName(target).." "..money.."$.",0,255,0)
					infobox(target,getPlayerName(player).." gave you "..money.."$.",0,255,0)
				end
			else infobox(player,"You don't have enough money!",255,0,0)end
		else infobox(player,"Use /pay [Player], [Money]!",255,0,0)end
	end
end)

addEventHandler("onElementClicked",root,function(button,state,player)
	if(button == "left" and state == "down")then
		local x,y,z = getElementPosition(source)
		if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player)) <= 7.5)then
			if(getElementData(source,"Safe") == true)then
				if(getElementModel(source) == 2332)then
					if(getElementData(player,"TresorKeys") >= 1)then
						setElementData(player,"TresorKeys",getElementData(player,"TresorKeys")-1)
						Weaponshop.giveRandomWeapon(player)
						setElementData(source,"Safe",false)
						setElementModel(source,2003)
					else infobox(player,"You don't have enough keys!",255,0,0)end
				else infobox(player,"This safe was already opened yet!",255,0,0)end
			end
		end
	end
end)