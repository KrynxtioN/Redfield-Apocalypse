zombies = {
	["Skins"] = {13,22,56,67,68,69,70,92,97,105,107,108,126,127,128,152,162,167,188,195,206,209,212,229,230,258,264,277,280,287},
	["Helme"] = {27,51,52,99,27,137,153,167,205,260,277,278,279,284,285},}

myZombies = {}

function zombies.zombRelease()
	for k,v in pairs(myZombies)do
		if(isElement(v))then
			if(getElementData(v,"zombie") == true)then
				setElementData(v,"target",nil)
				setElementData(v,"status","idle")
				table.remove(myZombies,k)
			end
		end
	end
end

function zombies.resetalertspacer()
	zombies.alertspacer = nil
end

function zombies.checkplayermoved(zomb,px,py,pz)
	if(isElement(zomb))then
		local nx,ny,nz = getElementPosition(localPlayer)
		local distance = getDistanceBetweenPoints3D(px,py,pz,nx,ny,nz)
		if(distance < 0.7 and isPlayerDead(localPlayer) == false)then
			setElementData(zomb,"status","throatslashing")
		end
	end
end

addEvent("zombies.spawnPlacement",true)
addEventHandler("zombies.spawnPlacement",root,function(xcoord,ycoord)
	local x,y,z = getElementPosition(localPlayer)
	local posx = x+xcoord
	local posy = y+ycoord
	local gz = getGroundPosition(posx,posy,z+500)
	triggerServerEvent("zombies.onZombieSpawn",localPlayer,posx,posy,gz+1)
end)

addEvent("zombies.zombPunch",true)
addEventHandler("zombies.zombPunch",root,function(ped)
	if(isElement(ped))then
		if(getElementData(localPlayer,"zombieskinuse") ~= true)then
			setPedControlState(ped,"fire",true)
			setTimer(function(ped)
				if(isElement(ped))then
					setPedControlState(ped,"fire",false)
				end
			end,800,1,ped)
		end
	end
end)

function zombiesRadiusalert(theElement)
	local Px,Py,Pz = getElementPosition(theElement)
	local zombies = getElementsByType("ped")
	for theKey,theZomb in ipairs(zombies)do
		if(isElement(theZomb))then
			if(getElementData(theZomb,"zombie") == true)then
				if(getElementData(theZomb,"status") == "idle")then
					local Zx,Zy,Zz = getElementPosition(theZomb)
					local distance = getDistanceBetweenPoints3D(Px,Py,Pz,Zx,Zy,Zz)
					if(distance < 10 and isPlayerDead(localPlayer) == false)then
						isthere = "no"
						for k,ped in pairs(myZombies)do
							if(ped == theZomb)then
								isthere = "yes"
							end
						end
						if(isthere == "no" and getElementData(localPlayer,"zombie") ~= true)then
							if(getElementType(theElement) == "ped")then
								local isclear = isLineOfSightClear(Px,Py,Pz,Zx,Zy,Zz,true,false,false,true,false,false,false) 
								if(isclear == true)then
									setElementData(theZomb,"status","chasing")
									setElementData(theZomb,"target",localPlayer)
									table.insert(myZombies,theZomb)
								end
							else
								setElementData(theZomb,"status","chasing")
								setElementData(theZomb,"target",localPlayer)
								table.insert(myZombies,theZomb)
							end
						end
					end
				end
			end
		end
	end
end

addEventHandler("onClientPlayerWeaponFire",localPlayer,function(weapon,ammo,ammoInClip,hitX,hitY,hitZ,hitElement)
	if(zombies.alertspacer ~= 1)then
		if(weapon == 9)then
			zombies.alertspacer = 1
			setTimer(zombies.resetalertspacer,5000,1)
			zombiesRadiusalert(localPlayer)
		elseif(weapon > 21 and weapon ~= 23)then
			zombies.alertspacer = 1
			setTimer(zombies.resetalertspacer,5000,1)
			zombiesRadiusalert(localPlayer)
		end
	end
	if(hitElement)then
		if(getElementType(hitElement) == "ped")then
			if(getElementData(hitElement,"zombie") == true)then
				isthere = "no"
				for k,ped in pairs(myZombies)do
					if(ped == hitElement)then
						isthere = "yes"
					end
				end
				if(isthere == "no" and getElementData(localPlayer,"zombie") ~= true)then
					setElementData(hitElement,"status","chasing")
					setElementData(hitElement,"target",localPlayer)
					table.insert(myZombies,hitElement)
					zombiesRadiusalert(hitElement)
				end
			end
		end
	end
end)

addEvent("zombies.zombJump",true)
addEventHandler("zombies.zombJump",root,function(ped)
	if(isElement(ped))then
		setPedControlState(ped,"jump",true)
		setTimer(function(ped)
			if(isElement(ped))then
				setPedControlState(ped,"jump",false)
			end
		end,800,1,ped)
	end
end)

function zombies.check()
	if(getElementData(localPlayer,"zombie") ~= true and isPlayerDead(localPlayer) == false)then
		local zombies = getElementsByType("ped",root,true)
		local Px,Py,Pz = getElementPosition(localPlayer)
		if(isPedDucked(localPlayer))then
			local Pz = Pz-1
		end		
		for theKey,theZomb in ipairs(zombies)do
			if(isElement(theZomb))then
				local Zx,Zy,Zz = getElementPosition(theZomb)
				if(getDistanceBetweenPoints3D(Px,Py,Pz,Zx,Zy,Zz) < 45)then
					if(getElementData(theZomb,"zombie") == true)then
						if(getElementData(theZomb,"status") == "idle")then
							local isclear = isLineOfSightClear(Px,Py,Pz+1,Zx,Zy,Zz+1,true,false,false,true,false,false,false)
							if(isclear == true)then
								setElementData(theZomb,"status","chasing")
								setElementData(theZomb,"target",localPlayer)
								table.insert(myZombies,theZomb)
								table.remove(zombies,theKey)
								zombiesRadiusalert(theZomb)
							end
						elseif(getElementData(theZomb,"status") == "chasing" and getElementData(theZomb,"target") == nil)then
							local isclear = isLineOfSightClear(Px,Py,Pz+1,Zx,Zy,Zz+1,true,false,false,true,false,false,false)
							if(isclear == true)then
								setElementData(theZomb,"target",localPlayer)
								isthere = "no"
								for k,ped in pairs(myZombies)do
									if(ped == theZomb)then
										isthere = "yes"
									end
								end
								if(isthere == "no")then
									table.insert(myZombies,theZomb)
									table.remove(zombies,theKey)
								end
							end
						elseif(getElementData(theZomb,"target") == localPlayer)then
							local isclear = isLineOfSightClear(Px,Py,Pz+1,Zx,Zy,Zz+1,true,false,false,true,false,false,false)
							if(isclear == false)then
								setElementData(theZomb,"target",nil)
								triggerServerEvent("zombies.lostPlayer",theZomb,oldPx,oldPy,oldPz)
							end
						end
					end
				end
			end
		end
	
		local nonzombies = getElementsByType("ped",localPlayer,true)
		for theKey,theZomb in ipairs(zombies)do
			if(isElement(theZomb))then
				if(getElementData(theZomb,"zombie") == true)then
					local Zx,Zy,Zz = getElementPosition(theZomb)
					for theKey,theNonZomb in ipairs(nonzombies)do
						if(getElementData(theNonZomb,"zombie") ~= true)then
							local Px,Py,Pz = getElementPosition(theNonZomb)
							if(getDistanceBetweenPoints3D(Px,Py,Pz,Zx,Zy,Zz) < 45)then
								local isclear = isLineOfSightClear(Px,Py,Pz+1,Zx,Zy,Zz+1,true,false,false,true,false,false,false)
								if(isclear == true and getElementHealth(theNonZomb) > 0)then
									if(getElementData(theZomb,"status") == "idle")then
										triggerServerEvent("zombies.lostPlayer",theZomb,Px,Py,Pz)									
										setElementData(theZomb,"status","chasing")
										setElementData(theZomb,"target",theNonZomb)
										zombiesRadiusalert(theZomb)
									elseif(getElementData(theZomb,"status") == "chasing" and getElementData(theZomb,"target") == nil)then
										triggerServerEvent("zombies.lostPlayer",theZomb,Px,Py,Pz)
										setElementData(theZomb,"target",theNonZomb)									
									end
								end					
							end		
							if(getElementData(theZomb,"target") == theNonZomb)then
								local Px,Py,Pz=getElementPosition(theNonZomb)
								if(getDistanceBetweenPoints3D(Px,Py,Pz,Zx,Zy,Zz) < 45)then
									local isclear = isLineOfSightClear(Px,Py,Pz+1,Zx,Zy,Zz+1,true,false,false,true,false,false,false)
									if(isclear == false)then
										triggerServerEvent("zombies.lostPlayer",theZomb,Px,Py,Pz)							
										setElementData(theZomb,"target",nil)
									end
								end
							end
						end
					end
				end
			end
		end
	end
	for k,ped in pairs(myZombies)do
		if(isElement(ped) == false)then
			table.remove(myZombies,k)
		end
	end
	oldPx,oldPy,oldPz = getElementPosition(localPlayer)
end

addEventHandler("onClientColShapeHit",root,function(theElement,matchingDimension)
	if(getElementType(theElement) == "ped" and isPlayerDead(localPlayer) == false)then
		if(getElementData(theElement,"target") == localPlayer and getElementData(theElement,"zombie") == true)then
			local px,py,pz = getElementPosition(localPlayer)
			setTimer(zombies.checkplayermoved,600,1,theElement,px,py,pz)
		end
	end
end)

addEventHandler("onClientPlayerWasted",localPlayer,function()
	setTimer(zombies.zombRelease,4000,1)
end)

addEventHandler("onClientPedWasted",root,function(killer,weapon,bodypart)
	if(getElementData(source,"zombie") == true and getElementData(source,"status") ~= "dead")then
		setElementData(source,"target",nil)
		setElementData(source,"status","dead")
		setElementCollisionsEnabled(source,false)
	end
end)

addEventHandler("onClientPedDamage",root,function(attacker,weapon,bodypart)
	if(getElementType(source) == "ped")then
		if(getElementData(source,"zombie") == true)then
			if(bodypart == 9)then
				helmeted = "no"
				local zskin = getElementModel(source)
				for k,skin in pairs(zombies["Helme"])do
					if(skin == zskin)then
						helmeted = "yes"
					end
				end
				if(helmeted == "no")then
					triggerServerEvent("zombies.headshot",source,source,attacker,weapon,bodypart)
				end
			end
		end
	end
end)

addEventHandler("onClientPlayerDamage",localPlayer,function(attacker,weapon,bodypart)
	if(attacker)then
		if(getElementType(attacker) == "ped")then
			if(getElementData(attacker,"zombie") == true)then
				local playerHealth = getElementHealth(localPlayer)
				if(playerHealth > 15)then
					setElementHealth(source,playerHealth-15)
				else
					triggerServerEvent("zombies.playereaten",source,source,attacker,weapon,bodypart)
				end
			end
		end
	end
end)

addEventHandler("onClientElementDataChange",root,function(dataName)
	if(getElementType(source) == "ped" and dataName == "status")then
		local thestatus = getElementData(source,"status")
		if(thestatus == "idle" or thestatus == "dead")then
			for k,ped in pairs(myZombies)do
				if(ped == source and getElementData(ped,"zombie") == true)then
					setElementData(ped,"target",nil)
					table.remove(myZombies,k)
					setElementData(localPlayer,"dangercount",tonumber(table.getn(myZombies)))
				end
			end
		end
	end
end)

function zombies.clientsetup()
	oldPx,oldPy,oldPz = getElementPosition(localPlayer)
	throatcol = createColSphere(0,0,0,0.3)
	
	for _,v in pairs(zombies["Skins"])do
		local skin = engineLoadTXD("Files/Zombies/"..v..".txd")
		engineImportTXD(skin,v)
	end
end

function zombies.clientsetupload()
	setTimer(zombies.clientsetup,1500,1)
	MainClientTimer1 = setTimer(zombies.check,1000,0)
end
zombies.clientsetupload()