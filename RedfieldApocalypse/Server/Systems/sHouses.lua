Houses = {blips = {}}

function Houses.load()
	local result = dbPoll(dbQuery(handler,"SELECT * FROM houses"),-1)
	if(#result >= 1)then
		for _,v in pairs(result)do
			if(not(isElement(Houses[v["ID"]])))then
				if(v["Owner"] == "Niemand")then model = 1273 else model = 1272 end
				Houses[v["ID"]] = createPickup(v["Spawnx"],v["Spawny"],v["Spawnz"],3,model,50)
				if(model == 1273)then
					Houses.blips[v["ID"]] = createBlip(v["Spawnx"],v["Spawny"],v["Spawnz"],32,0,0,0,0,0,0,100)
				end
				setElementData(Houses[v["ID"]],"Owner",v["Owner"])
				setElementData(Houses[v["ID"]],"Price",v["Price"])
				setElementData(Houses[v["ID"]],"ID",v["ID"])
				
				addEventHandler("onPickupHit",Houses[v["ID"]],function(player)
					if(not(isPedInVehicle(player)))then
						setElementData(player,"SetHouse",source)
						bindKey(player,"k","down",Houses.openWindow)
						infobox(player,"House 'k' to open the house menu.",0,255,0)
					end
				end)
			end
		end
	end
end
Houses.load()

function Houses.openWindow(player)
	if(getElementData(player,"SetHouse"))then
		local house = getElementData(player,"SetHouse")
		local x,y,z = getElementPosition(house)
		if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player)))then
			local owner,price = getElementData(house,"Owner"),getElementData(house,"Price")
			if(owner ~= "Niemand")then owner = getPlayerData("teams","ID",owner,"Name") end
			triggerClientEvent(player,"Houses.openWindow",player,owner,price)
		end
	end
end

addEvent("Houses.buyOrSellHouse",true)
addEventHandler("Houses.buyOrSellHouse",root,function(type)
	if(getElementData(client,"SetHouse"))then
		if(getElementData(client,"Teamrang") >= 5)then
			local house = getElementData(client,"SetHouse")
			local owner,price = getElementData(house,"Owner"),getElementData(house,"Price")
			local ID = getElementData(house,"ID")
			if(type == "Buy")then
				if(getElementData(client,"Money") >= tonumber(price))then
					if(owner == "Niemand")then
						local result = dbPoll(dbQuery(handler,"SELECT * FROM houses WHERE Team = '"..getElementData(client,"Team").."'"),-1)
						if(#result == 0)then
							dbExec(handler,"UPDATE houses SET Owner = '"..getElementData(client,"Team").."' WHERE ID = '"..ID.."'")
							infobox(client,"You bought the house.",0,255,0)
							setElementData(client,"Money",getElementData(client,"Money")-price)
							triggerClientEvent(client,"setWindowDatas",client,"reset")
						else infobox(client,"Your team already have a house!",255,0,0)end
					else infobox(client,"This house is already selled!",255,0,0)end
				else infobox(client,"You don't have enough money!",255,0,0)end
			elseif(type == "Sell")then
				if(owner == getElementData(client,"Team"))then
					setElementData(client,"Money",getElementData(client,"Money")+price/100*75)
					dbExec(handler,"UPDATE houses SET Owner = 'Niemand' WHERE ID = '"..ID.."'")
					infobox(client,"You selled your house and got back 75% of the buy price",255,0,0)
					triggerClientEvent(client,"setWindowDatas",client,"reset")
				else infobox(client,"This is not your house!",255,0,0)end
			end
			destroyElement(Houses[ID])
			if(isElement(Houses.blips[ID]))then destroyElement(Houses.blips[ID])end
			Houses.load()
		else infobox(client,"You have to be at least rang 5 in your team!",255,0,0)end
	end
end)

addCommandHandler("createhouse",function(player,cmd,price)
	if(getElementData(player,"Adminlevel") >= 3)then
		if(price)then
			if(getElementInterior(player) == 0 and getElementDimension(player) == 0 and isPedOnGround(player) and not(isPedInWater(player)))then
				local x,y,z = getElementPosition(player)
				dbExec(handler,"INSERT INTO houses (Spawnx,Spawny,Spawnz,Owner,Price) VALUES ('"..x.."','"..y.."','"..z.."','Niemand','"..price.."')")
				infobox(player,"House created.",0,255,0)
				Houses.load()
			else infobox(player,"You cant create a house here!",255,0,0)end
		else infobox(player,"Use /createhouse [Price]!",255,0,0)end
	end
end)