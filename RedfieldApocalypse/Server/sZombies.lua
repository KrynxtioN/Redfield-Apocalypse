zombies = {speed = 2, limit = 50, moancount = 0, moanlimit = 10, everyZombie = {}, --// Speed: 0 = slow, 1 = normal, 2 = fast
	["Speed"] = {
		[1] = {"WALK_drunk",2000},
		[2] = {"run_old",1000},
		[3] = {"Run_Wuzi",680},},
	["Skins"] = {13,22,56,67,68,69,70,92,97,105,107,108,126,127,128,152,162,167,188,195,206,209,212,229,230,258,264,277,280,287},}
		
zombies.chaseanim = zombies["Speed"][zombies.speed][1]
zombies.checkspeed = zombies["Speed"][zombies.speed][2]

function zombies.clear(ped)
	if(isElement(ped))then
		if(getElementData(ped,"zombie") == true)then
			for theKey,thePed in ipairs(zombies.everyZombie)do
				if(ped == thePed)then
					table.remove(zombies.everyZombie,theKey)
				end
			end
			destroyElement(ped)
		end
	end
end

addEvent("zombies.headshot",true)
addEventHandler("zombies.headshot",root,function(ped,attacker,weapon,bodypart)
	if(getElementData(ped,"zombie") == true)then
		killPed(ped,attacker,weapon,bodybart)
		setPedHeadless(ped,true)
	end
end)

addEvent("zombies.lostPlayer",true)
addEventHandler("zombies.lostPlayer",root,function(x,y,z)
	setElementData(source,"Tx",x,false)
	setElementData(source,"Ty",y,false)
	setElementData(source,"Tz",z,false)
end)

function zombies.setangle()
	for theKey,ped in ipairs(zombies.everyZombie)do
		if(isElement(ped))then
			if(getElementData(ped,"status") == "chasing")then
				if(getElementData(ped,"target") ~= nil)then
					if(isElement(getElementData(ped,"target")))then
						x,y,z = getElementPosition(getElementData(ped,"target"))
						px,py,pz = getElementPosition(ped)
					else
						setElementData(ped,"status","idle")
						x,y,z = getElementPosition(ped)
						px,py,pz = getElementPosition(ped)
					end
					zombangle = (360-math.deg(math.atan2((x-px),(y-py))))%360
					setPedRotation(ped,zombangle)
				elseif(getElementData(ped,"target") == nil and getElementData(ped,"Tx") ~= false)then
					x = getElementData(ped,"Tx")
					y = getElementData(ped,"Ty")
					z = getElementData(ped,"Tz")
					px,py,pz = getElementPosition(ped)
					zombangle = (360-math.deg(math.atan2((x-px),(y-py))))%36
					setPedRotation(ped,zombangle)
				end
			end
		end
	end
end

function zombies.isZombie(ped)
	if(isElement(ped))then
		if(getElementData(ped,"zombie") == true)then
			return true
		else
			return false
		end
	end
end

function zombies.clearFarZombies()
	if(newZombieLimit ~= false)then
		local toofarzombies = {}
		local allplayers = getElementsByType("player")
		for zombKey,theZomb in ipairs(zombies.everyZombie)do
			if(isElement(theZomb))then
				if(getElementData(theZomb,"zombie") == true)then
					far = 1
					local Zx,Zy,Zz = getElementPosition(theZomb)
					for theKEy,thePlayer in ipairs(allplayers)do
						local Px,Py,Pz = getElementPosition(thePlayer)
						local distance = getDistanceBetweenPoints3D(Px,Py,Pz,Zx,Zy,Zz)
						if(distance < 75)then
							far = 0
						end
					end
					if(far == 1)then
						table.insert(toofarzombies,theZomb)
					end
				end
			else
				table.remove(zombies.everyZombie,zombKey)
			end
		end
		if(table.getn(toofarzombies) > 1)then
			for ZombKey,theZomb in ipairs(toofarzombies)do
				if(getElementData(theZomb,"zombie") == true and getElementData(theZomb,"forcedtoexist") ~= true)then
					zombies.clear(theZomb)
				end
			end
		end
	end
end

function zombies.idle(ped)
	if(isElement(ped))then
		if(getElementData(ped,"status") == "idle" and isPedDead(ped) == false and getElementData(ped,"zombie") == true)then
			local action = math.random(1,5)
			if(action < 4)then
				setPedRotation(ped,math.random(1,359))
				setPedAnimation(ped,"PED","Player_Sneak",-1,true,true,true)
				setTimer(zombies.idle,7000,1,ped)
			elseif(action == 4)then
				setPedAnimation(ped,"MEDIC","cpr",-1,false,true,true)
				setTimer(zombies.idle,4000,1,ped)
			elseif(action == 5)then
				setPedAnimation(ped)
				setTimer(zombies.idle,4000,1,ped)
			end
		end
	end
end

function zombies.bitten(player,attacker)
	local Zx,Zy,Zz = getElementPosition(attacker)
	local Px,Py,Pz = getElementPosition(player)
	local distance = getDistanceBetweenPoints3D(Px,Py,Pz,Zx,Zy,Zz)
	if(distance < 1)then
		killPed(player,attacker,weapon,bodypart)
	else
		setPedAnimation(player)
	end
end

function zombies.outbreak()
	newZombieLimit = zombies.limit
	
	if(zombies.speed == 2)then
		MainTimer1 = setTimer(zombies.setangle,200,0)
	else
		MainTimer1 = setTimer(zombies.setangle,400,0)
	end
	MainTimer3 = setTimer(zombies.clearFarZombies,3000,0)
	MainTimer2 = setTimer(zombies.spawnZombie,2500,0)
end
setTimer(zombies.outbreak,1000,1)

function zombies.spawnZombie()
	local pacecount = 0
	while pacecount < 5 do
		if(table.getn(zombies.everyZombie)+pacecount < newZombieLimit)then
			local xcoord = 0
			local ycoord = 0
			local xdirection = math.random(1,2)
			if(xdirection == 1)then
				xcoord = math.random(15,40)
			else
				xcoord = math.random(-40,-15)
			end
			local ydirection = math.random(1,2)
			if(ydirection == 1)then
				ycoord = math.random(15,40)
			else
				ycoord = math.random(-40,-15)
			end
			
			local liveplayers = getAlivePlayers()
			if(table.getn(liveplayers) > 0)then
				local lowestcount = 99999
				local lowestguy = nil
				for Pkey,thePlayer in ipairs(liveplayers)do
					if(isElement(thePlayer))then
						if(getElementData(thePlayer,"loggedin") and getElementData(thePlayer,"savezone") == 0)then
							if(getElementData(thePlayer,"dangercount") and getElementData(thePlayer,"zombieProof") ~= true and getElementData(thePlayer,"alreadyspawned") == true)then
								if(getElementData(thePlayer,"dangercount") < lowestcount)then
									lowestguy = thePlayer
									lowestcount = getElementData(thePlayer,"dangercount")
								end
							end
						end
					end
				end
				pacecount = pacecount + 1
				if(isElement(lowestguy))then
					triggerClientEvent("zombies.spawnPlacement",lowestguy,ycoord,xcoord)
				else pacecount = pacecount + 1 end
			else pacecount = pacecount + 1 end
		else pacecount = pacecount + 1 end
	end
end

addEvent("zombies.onZombieSpawn",true)
addEventHandler("zombies.onZombieSpawn",root,function(gx,gy,gz,rot)
	if(table.getn(zombies.everyZombie) < newZombieLimit)then
		if(not(rot))then rot = math.random(1,359)end
		randomZskin = math.random(1,table.getn(zombies["Skins"]))
		local zomb = createPed(tonumber(zombies["Skins"][randomZskin]),gx,gy,gz)
		if(zomb ~= false)then
			setElementData(zomb,"zombie",true)
			table.insert(zombies.everyZombie,zomb)
				
			setTimer(function(zomb,rot)
				if(isElement(zomb))then
					setPedRotation(zomb,rot)
				end
			end,500,1,zomb,rot)
				
			setTimer(function(zomb)
				if(isElement(zomb))then
					setPedAnimation(zomb,"ped",zombies.chaseanim,-1,true,true,true)
				end
			end,1000,1,zomb)
				
			setTimer(function(zomb)
				if(isElement(zomb))then
					setElementData(zomb,"status","idle")
				end
			end,2000,1,zomb)
		end
	end
end)

addEvent("zombies.playereaten",true)
addEventHandler("zombies.playereaten",root,function(player,attacker,weapon,bodypart)
	killPed(player,attacker,weapon,bodypart)
end)

function zombies.reduceMoancount() zombies.moancount = zombies.moancount - 1 end

addEventHandler("onElementDataChange",root,function(dataName)
	if(getElementType(source) == "ped" and dataName == "status")then
		if(getElementData(source,"zombie") == true)then
			if(isPedDead(source) == false)then
				if(getElementData(source,"status") == "chasing")then
					local Zx,Zy,Zz = getElementPosition(source)
					setTimer(zombies.Zomb_chase,1000,1,source,Zx,Zy,Zz)
					local newtarget = getElementData(source,"target")

					if(isElement(newtarget))then
						if(getElementType(newtarget) == "player")then
							setElementSyncer(source,newtarget)
						end
					end
				elseif(getElementData(source,"status") == "idle")then
					setTimer(zombies.idle,1000,1,source)
				elseif(getElementData(source,"status") == "throatslashing")then
					local tx,ty,tz = getElementPosition(source)
					local ptarget = getElementData(source,"target")
					if(isElement(ptarget))then
						local vx,vy,vz = getElementPosition(ptarget)
						local zombiedistance = getDistanceBetweenPoints3D(tx,ty,tz,vx,vy,vz)
						if(zombiedistance < 0.8)then
							if(getElementData(ptarget,"ZombieSkinUse") ~= true)then
								setPedAnimation(source,"knife","KILL_Knife_Player",-1,false,false,true)
								setPedAnimation(ptarget,"knife","KILL_Knife_Ped_Damage",-1,false,false,true)
								setTimer(zombies.bitten,2300,1,ptarget,source)
								setTimer(function(source)
									if(isElement(source))then
										setElementData(source,"status","idle")
									end
								end,5000,1,source)
							end
						else
							setElementData(source,"status","idle")
						end
					else
						setElementData(source,"status","idle")
					end
				end
			elseif(getElementData(source,"status") == "dead")then
				setTimer(zombies.clear,10000,1,source)
			end
		end
	end
end)

function zombies.Zomb_chase(ped,Zx,Zy,Zz)
	if(isElement(ped))then
		if(getElementData(ped,"status") == "chasing" and getElementData(ped,"zombie") == true)then
			local x,y,z = getElementPosition(ped)
			if(getElementData(ped,"target") == nil and getElementData(ped,"Tx") ~= false)then
				local Px = getElementData(ped,"Tx")
				local Py = getElementData(ped,"Ty")
				local Pz = getElementData(ped,"Tz")
				local Pdistance = getDistanceBetweenPoints3D(Px,Py,Pz,x,y,z)
				if(Pdistance < 1.5)then
					setTimer(function(ped)
						if(isElement(ped))then
							setElementData(ped,"status","idle")
						end
					end,2000,1,ped)
				end
			end
			local distance = getDistanceBetweenPoints3D(x,y,z,Zx,Zy,Zz)
			if(distance < 1)then
				if(getElementData(ped,"target") == nil)then
					local giveup = math.random(1,15)
					if(giveup == 1)then
						setElementData(ped,"status","idle")
					else
						local action = math.random(1,2)
						if(action == 1)then
							setPedAnimation(ped)
							triggerClientEvent("zombies.zombPunch",root,ped)
							setTimer(function(ped)
								if(isElement(ped))then
									setPedAnimation(ped,"ped",zombies.chaseanim,-1,true,true,true)
								end
							end,800,1,ped)
							setTimer(zombies.Zomb_chase,2000,1,ped,x,y,z)
						elseif(action == 2)then
							setPedAnimation(ped)
							triggerClientEvent("zombies.zombJump",root,ped)
							setTimer(zombies.Zomb_chase,3500,1,ped,x,y,z)
						end
					end
				else
					local Ptarget = getElementData(ped,"target")
					if(isElement(Ptarget))then
						local Px,Py,Pz = getElementPosition(Ptarget)
						local Pdistance = getDistanceBetweenPoints3D(Px,Py,Pz,Zx,Zy,Zz)
						if(Pdistance < 1.2)then
							if(isPedDead(Ptarget))then
								setPedAnimation(ped)
								setPedAnimation(ped,"MEDIC","cpr",-1,false,true,false)
								setTimer(function(ped)
									if(isElement(ped))then
										setElementData(ped,"status","idle")
									end
								end,10000,1,ped)
								setTimer(function(ped)
									if(isElement(ped))then
										setElementData(ped,"status","idle")
									end
								end,10000,1,ped)
							else
								local action = math.random(1,6)
								if(action == 1)then
									setPedAnimation(ped)
									triggerClientEvent("zombies.zombJump",root,ped)
									setTimer(zombies.Zomb_chase,2000,1,ped,x,y,z)
								else
									setPedAnimation(ped)
									triggerClientEvent("zombies.zombPunch",root,ped)
									setTimer(function(ped)
										if(isElement(ped))then
											setPedAnimation(ped,"ped",zombies.chaseanim,-1,true,true,true)
										end 
									end,800,1,ped)
									setTimer(zombies.Zomb_chase,2000,1,ped,x,y,z)
								end
							end
						else
							if(isPedDead(Ptarget))then
								setTimer(function(ped)
									if(isElement(ped))then
										setElementData(ped,"status","idle")
									end
								end,2000,1,ped)
								setTimer(function(ped)
									if(isElement(ped))then
										setPedRotation(ped,getPedRotation(ped)-180)
									end
								end,1800,1,ped)
							else
								local action = math.random(1,2)
								if(action == 1)then
									setPedAnimation(ped)
									triggerClientEvent("zombies.zombPunch",root,ped)
									setTimer(function(ped)
										if(isElement(ped))then
											setPedAnimation(ped,"ped",zombies.chaseanim,-1,true,true,true)
										end
									end,800,1,ped)
									setTimer(zombies.Zomb_chase,2000,1,ped,x,y,z)
								elseif(action == 2)then
									setPedAnimation(ped)
									triggerClientEvent("zombies.zombJump",root,ped)
									setTimer(zombies.Zomb_chase,2000,1,ped,x,y,z)
								end
							end
						end
					else
						setElementData(ped,"status","idle")
					end
				end
			else
				setPedAnimation(ped,"ped",zombies.chaseanim,-1,true,true,true)
				setTimer(zombies.Zomb_chase,zombies.checkspeed,1,ped,x,y,z)
			end
		end
	end
end