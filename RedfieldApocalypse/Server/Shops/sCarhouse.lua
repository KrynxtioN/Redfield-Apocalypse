Carhouse = {veh = {},
	["Vehicles"] = {
		--// Model-ID, x, y, z, rx, ry, rz, x, y, z, price
		
		--// Wang Cars
		{518,-1944.900390625,273.7998046875,35.299999237061,0,0,109.9951171875,120000}, -- Buccaneer
		{527,-1944.2998046875,265.5,35.299999237061,0,0,90,115000}, 					-- Cadrona
		{602,-1946.900390625,256.2001953125,35.400001525879,0,0,0,140000}, 				-- Alpha
		{496,-1952.7001953125,255.900390625,35.299999237061,0,0,0,95000}, 				-- Blista Compact
		{401,-1958.2998046875,256,35.299999237061,0,0,0,200000}, 						-- Bravura
		{589,-1962.7001953125,273.2001953125,35.200000762939,0,0,316,70000}, 			-- Club
		{419,-1962.5,282.599609375,35.400001525879,0,0,330,130000}, 					-- Esperanto
		{533,-1962.400390625,301.099609375,35.299999237061,0,0,200,225000}, 			-- Feltzer
		{526,-1952.099609375,296.7001953125,35.299999237061,0,0,158,150000}, 			-- Fortune
		{507,-1947,273.599609375,41,0,0,126,80000}, 									-- Elegant
		{517,-1944.099609375,258.2998046875,41,0,0,26,100000}, 							-- Majestic
		{474,-1957.20019531259,258.2001953125,40.900001525879,0,0,340,60000}, 			-- Hermes
	},
}
local ID = 0

for _,v in pairs(Carhouse["Vehicles"])do
	local veh = createVehicle(v[1],v[2],v[3],v[4],v[5],v[6],v[7],"Redfield Apocalypse")
	setVehicleColor(veh,198,29,29)
	setVehicleDamageProof(veh,true)
	setElementData(veh,"CarhouseCosts",v[8])
	setElementFrozen(veh,true)
	
	addEventHandler("onVehicleEnter",veh,function(player)
		if(getPedOccupiedVehicleSeat(player) == 0)then
			if(not(getElementData(source,"VehicleID")))then
				local price = getElementData(source,"CarhouseCosts")
				triggerClientEvent(player,"Carhouse.openWindow",player,price)
			end
		end
	end)
end

function loadPlayerVehicles(player)
	local result = dbPoll(dbQuery(handler,"SELECT * FROM vehicles WHERE Owner = '"..getPlayerName(player).."'"),-1)

	if(#result >= 1)then
		for _,v in pairs(result)do
			if(not(isElement(Carhouse.veh[v["ID"]])))then
				Carhouse.veh[v["ID"]] = createVehicle(v["Model"],v["Spawnx"],v["Spawny"],v["Spawnz"],v["Spawnrotx"],v["Spawnroty"],v["Spawnrotz"],v["Owner"])
				setElementData(Carhouse.veh[v["ID"]],"Owner",v["Owner"])
				setElementData(Carhouse.veh[v["ID"]],"VehicleID",v["ID"])
				ID = v["ID"]
				setVehicleDamageProof(Carhouse.veh[v["ID"]],true)
				setVehicleColor(Carhouse.veh[v["ID"]],198,29,29)
				setVehicleLocked(Carhouse.veh[v["ID"]],true)
			end
		end
	end
end

addEvent("Carhouse.buy",true)
addEventHandler("Carhouse.buy",root,function()
	local veh = getPedOccupiedVehicle(client)
	local price = getElementData(veh,"CarhouseCosts")
	if(getElementData(client,"Money") >= tonumber(price))then
		local x,y,z = getElementPosition(veh)
		local rx,ry,rz = getElementRotation(veh)
		local model = getElementModel(veh)
		setElementData(client,"Money",getElementData(client,"Money")-price)
		infobox(client,"You bought the vehicle. You'll find more informations about vehicles in our helpmenu under F1.",0,255,0)
		dbExec(handler,"INSERT INTO vehicles (Owner,Model,Spawnx,Spawny,Spawnz,Spawnrotx,Spawnroty,Spawnrotz,Owner) VALUES ('"..getPlayerName(client).."','"..model.."','"..x.."','"..y.."','"..z.."','"..rx.."','"..ry.."','"..rz.."','"..getPlayerName(client).."')")
		setElementData(veh,"Owner",getPlayerName(client))
		setElementData(veh,"VehicleID",ID+1)
		ID = ID + 1
		setElementFrozen(veh,false)
		triggerClientEvent(client,"setWindowDatas",client,"reset")
	else infobox(client,"You don't have enough money!",255,0,0)end
end)

addCommandHandler("park",function(player)
	if(isPedInVehicle(player))then
		if(getPedOccupiedVehicleSeat(player) == 0)then
			local team = 0
			local veh = getPedOccupiedVehicle(player)
			if(getElementData(veh,"Owner"))then team = tonumber(getPlayerData("userdata","Username",getElementData(veh,"Owner"),"Team")) end
			if(getElementData(veh,"VehicleID") and getElementData(veh,"Owner") == getPlayerName(player) or team >= 1 and getElementData(player,"Team") == team)then
				local x,y,z = getElementPosition(veh)
				local rx,ry,rz = getElementRotation(veh)
				dbExec(handler,"UPDATE vehicles SET Spawnx = '"..x.."', Spawny = '"..y.."', Spawnz = '"..z.."', Spawnrotx = '"..rx.."', Spawnroty = '"..ry.."', Spawnrotz = '"..rz.."' WHERE ID = '"..getElementData(veh,"VehicleID").."'")
				infobox(player,"You parked your vehicle.",0,255,0)
			end
		end
	end
end)

addCommandHandler("lock",function(player)
	for _,v in pairs(getElementsByType("vehicle"))do
		local team = 0
		if(getElementData(v,"Owner"))then team = tonumber(getPlayerData("userdata","Username",getElementData(v,"Owner"),"Team")) end
		if(getElementData(v,"VehicleID") and getElementData(v,"Owner") == getPlayerName(player) or team >= 1 and getElementData(player,"Team") == team)then
			local x,y,z = getElementPosition(v)
			if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player)) <= 3)then
				if(isVehicleLocked(v))then
					setVehicleLocked(v,false)
					infobox(player,"Vehicle unlocked.",0,255,0)
				else
					setVehicleLocked(v,true)
					infobox(player,"Vehicle locked.",0,255,0)
				end
				break
			end
		end
	end
end)

function Carhouse.getPlayerVehicles(player)
	local vehs = {}
	local result = dbPoll(dbQuery(handler,"SELECT * FROM vehicles WHERE Owner = '"..getPlayerName(player).."'"),-1)
	if(#result >= 1)then
		for _,v in pairs(result)do
			table.insert(vehs,{v["ID"],getVehicleNameFromModel(v["Model"])})
		end
	end
	triggerClientEvent(player,"Carhouse.setPlayerVehicles",player,vehs)
end
addEvent("Carhouse.getPlayerVehicles",true)
addEventHandler("Carhouse.getPlayerVehicles",root,Carhouse.getPlayerVehicles)

addEvent("Carhouse.sell",true)
addEventHandler("Carhouse.sell",root,function(id)
	local id = tonumber(id)
	dbExec(handler,"DELETE FROM vehicles WHERE ID = '"..id.."'")
	for _,v in pairs(getElementsByType("vehicle"))do
		if(getElementData(v,"VehicleID") == id)then
			destroyElement(v)
			break
		end
	end
	infobox(client,"You sold your vehicle.",255,0,0)
	Carhouse.getPlayerVehicles(client)
end)

addEvent("Carhouse.locate",true)
addEventHandler("Carhouse.locate",root,function(id)
	local id = tonumber(id)
	for _,v in pairs(getElementsByType("vehicle"))do
		if(getElementData(v,"VehicleID") == id)then
			local x,y,z = getElementPosition(v)
			triggerClientEvent(client,"Carhouse.locateBlip",client,x,y,z)
			break
		end
	end
end)