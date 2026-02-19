Skinshop = {price = 500}

addEvent("Skinshop.buy",true)
addEventHandler("Skinshop.buy",root,function(skin)
	if(getElementData(client,"Bonuspoints") >= Skinshop.price)then
		setElementData(client,"Bonuspoints",getElementData(client,"Bonuspoints")-Skinshop.price)
		infobox(client,"You bought the skin.",0,255,0)
		setElementModel(client,tonumber(skin))
	else infobox(client,"You don't have enough Bonuspoints!",255,0,0)end
end)