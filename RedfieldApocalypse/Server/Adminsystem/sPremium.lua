Premium = {info = {}}

function isPremium(player)
	if(getElementData(player,"Premium") == 1 or getElementData(player,"LifetimePremium") == 1)then
		return true
	else
		return false
	end
end

function Premium.buy(player)
	if(not(isPremium(player)))then
		if(getElementData(player,"Coins") >= 5)then
			local seconds = getSecTime(336)
			dbExec(handler,"INSERT INTO premium (Username,STime) VALUES ('"..getPlayerName(player).."','"..seconds.."')")
			setElementData(player,"Premium",1)
			infobox(player,"You bought 'Premium for 14 days'.",0,255,0)
			Premium.check(player)
			setElementData(player,"Coins",getElementData(player,"Coins")-5)
		else infobox(player,"You don't have enough Coins!",255,0,0)end
	else infobox(player,"You already have a active premium-status!",255,0,0)end
end

function Premium.buyLifetime(player)
	if(not(isPremium(player)))then
		if(getElementData(player,"Coins") >= 50)then
			setElementData(player,"LifetimePremium",1)
			infobox(player,"You bought 'Lifetime-Premium'.",0,255,0)
			setElementData(player,"Coins",getElementData(player,"Coins")-50)
		else infobox(player,"You don't have enough Coins!",255,0,0)end
	end
end

function Premium.check(player)
	local result = dbPoll(dbQuery(handler,"SELECT STime FROM ?? WHERE Username = ?","premium",getPlayerName(player)),-1)
	if(result and result[1])then
		for i = 1,#result do
			if(result[i]["STime"] ~= 0 and result[i]["STime"] - getSecTime(0) <= 0)then
				setElementData(player,"Premium",0)
				infobox(player,"Your premium-status has expired.",0,255,0)
				dbExec(handler,"DELETE FROM premium WHERE Username = '"..getPlayerName(player).."'")
			else
				if(Premium.info[player] ~= true)then
					Premium.info[player] = true
					setElementData(player,"Premium",1)
					local var = math.floor(((result[i]["STime"] - getSecTime(0))/60)*100)/100
					if(var >= 0)then
						outputChatBox("Your premium-status is still active for "..var.." hours.",player,0,125,0)
					end
				end
			end
		end
	end
end