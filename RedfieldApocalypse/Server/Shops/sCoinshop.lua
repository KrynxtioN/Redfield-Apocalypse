Coinshop = {
	["Weapon Depot"] = 10,
	["Premium (14 days)"] = 5,
	["Lifetime Premium"] = 50,
	["Zombie Skin"] = 25,
}

addEvent("Coinshop.exchange",true)
addEventHandler("Coinshop.exchange",root,function(amount)
	local amount = tonumber(amount)
	if(getElementData(client,"Bonuspoints") >= amount*500)then
		setElementData(client,"Bonuspoints",getElementData(client,"Bonuspoints")-amount*500)
		setElementData(client,"Coins",getElementData(client,"Coins")+amount)
		infobox(client,"You exchanged "..amount*500 .." bonuspoints and received "..amount.." Coin.",0,255,0)
	else infobox(client,"You don't have enough Bonuspoints!",255,0,0)end
end)

addEvent("Coinshop.buy",true)
addEventHandler("Coinshop.buy",root,function(article)
	local preis = tonumber(Coinshop[article])
	if(getElementData(client,"Coins") >= preis)then
		if(article == "Weapon Depot")then
			if(getElementData(client,"Weapondepot") == 0)then
				setElementData(client,"Weapondepot",1)
				setElementData(client,"Coins",getElementData(client,"Coins")-preis)
				infobox(client,"You bought a Weapon-Depot.",0,255,0)
			else infobox(client,"You already have a Weapon-Depot!",255,0,0)end
		elseif(article == "Premium (14 days)")then
			Premium.buy(client)
		elseif(article == "Lifetime Premium")then
			Premium.buyLifetime(client)
		elseif(article == "Zombie Skin")then
			if(getElementData(client,"Zombieskin") == 0)then
				setElementData(client,"Zombieskin",1)
				setElementData(client,"Coins",getElementData(client,"Coins")-preis)
				infobox(client,"You bought a Zombie-Skin.",0,255,0)
			else infobox(client,"You already have a Zombie-Skin!",255,0,0)end
		end
	else infobox(client,"You don't have enough Coins!",255,0,0)end
end)