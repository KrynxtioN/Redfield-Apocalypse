Inventory = {saveSkin = {}}

addEvent("Inventory.server",true)
addEventHandler("Inventory.server",root,function(item)
	if(item == "Hearts")then
		if(getElementHealth(client) < 100)then
			setElementData(client,item,getElementData(client,item)-1)
			setElementHealth(client,100)
			infobox(client,"You used a Heart.",0,255,0)
		end
	elseif(item == "Zombieskin")then
		if(getElementData(client,"ZombieSkinUse") ~= true)then
			Inventory.saveSkin[client] = getElementModel(client)
			setElementData(client,"ZombieSkinUse",true)
			setElementModel(client,229)
		else
			setElementData(client,"ZombieSkinUse",false)
			setElementModel(client,Inventory.saveSkin[client])
		end
	end
	triggerClientEvent(client,"Inventory.refresh",client)
end)