Peds = {
	--// Model, x, y, z, Rotation, Name, Event
	
	--// San Fierro Railway Station
	{100,-1968.5,114.30000305176,27.700000762939,0,"Weapon Shop","Weaponshop.createWindow"},
	{248,-1974.9,162.60000610352,27.700000762939,180,"Team","Teamsystem.createTeam"},
	{114,-1973.5,162.60000610352,27.700000762939,180,"Updates","Updates.createWindow"},
	{299,-1972.1,162.60000610352,27.700000762939,180,"Skinshop","Skinshop.createWindow"},
	{141,-1962.1999511719,156.69999694824,27.700000762939,90,"Coinshop","Coinshop.createWindow"},
	{26,-1962.1999511719,155.29999694824,27.700000762939,90,"Toplist","Toplist.createWindow"},
	{181,-1970.7,162.60000610352,27.700000762939,180,"Savezones","Savezones.createWindow"},
	
	--// Chicken Valley
	{299,-244.86470031738,2722.8127441406,62.6875,0,"Savezones","Savezones.createWindow"},
	{181,-221.46185302734,2739.3796386719,62.6875,180,"Weapon Shop","Weaponshop.createWindow"},
	
	--// Carhouses
	{59,-1957.8000488281,307.89999389648,35.5,180,"Wang Cars","Carhouse.showInfobox"},
	
	--// Missionary Hill
	{312,-2532.0510253906,-624.38592529297,132.74740600586,318.001373,"Safes","Safes.openWindow"},
}

for _,v in pairs(Peds)do
	local ped = createPed(v[1],v[2],v[3],v[4],v[5])
	setElementFrozen(ped,true)
	setElementData(ped,"PedName",v[6])
	setElementData(ped,"PedEvent",v[7])
	
	addEventHandler("onClientPedDamage",ped,function()
		cancelEvent()
	end)
end

addEventHandler("onClientRender",root,function()
	for _,v in pairs(getElementsByType("ped"))do
		if(getElementDimension(localPlayer) == getElementDimension(v) and getElementInterior(localPlayer) == getElementInterior(v))then
			local px,py,pz = getPedBonePosition(v,8)
			local lx,ly,lz = getPedBonePosition(localPlayer,8)
				
			if(getDistanceBetweenPoints3D(px,py,pz,lx,ly,lz) <= 15 and isLineOfSightClear(px,py,pz,lx,ly,lz,true,false,false,true,false))then
				if(getElementData(v,"PedName"))then
					if(not(isPedDead(v)))then
						local worldx,worldy = getScreenFromWorldPosition(px,py,pz+0.5,1000,true)
						
						if(getDistanceBetweenPoints3D(px,py,pz,lx,ly,lz) > 1)then
							scale = 0.6 - (getDistanceBetweenPoints3D(px,py,pz,lx,ly,lz)/70)
						else
							scale = 0.6
						end
						
						if(worldx and worldy)then
							if(getElementData(localPlayer,"elementClicked") ~= true)then
								dxDrawText(getElementData(v,"PedName"),worldx,worldy,worldx,worldy,tocolor(0,255,0),scale,"bankgothic","center","center")
								dxDrawText("Click to interact.",worldx-2,worldy+25,worldx,worldy,tocolor(0,255,0),scale - 0.2,"bankgothic","center","center")
							end
						end
					end
				end
			end
		end
	end
end)

addEventHandler("onClientClick",root,function(button,state,absx,absy,wx,wy,wz,element)
	if(element and getElementType(element) == "ped" and state == "down")then
		local x,y,z = getElementPosition(localPlayer)
		if(getDistanceBetweenPoints3D(x,y,z,wx,wy,wz) <= 3)then
			if(getElementData(element,"PedEvent"))then
				triggerEvent(getElementData(element,"PedEvent"),localPlayer)
			end
		end
	end
end)