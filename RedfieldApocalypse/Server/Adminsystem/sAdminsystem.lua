local Admincommands = {
	[1] = {
		"/o - Public Teamchat",
		"/a - Intern Teamchat",
	},
}

function sendAdminMessage(text)
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1)then
			if(getElementData(v,"Adminlevel") >= 1)then
				outputChatBox("[Admin-MSG]: "..text,v,255,255,0)
			end
		end
	end
end

addCommandHandler("o",function(player,cmd,...)
	if(getElementData(player,"Adminlevel") >= 1)then
		local tbl = {...}
		local text = table.concat(tbl," ")
		if(#text >= 1)then
			outputChatBox("(("..Adminsystem["Names"][getElementData(player,"Adminlevel")].." "..getPlayerName(player)..": "..text.."))",root,255,255,255)
		end
	end
end)

addCommandHandler("a",function(player,cmd,...)
	if(getElementData(player,"Adminlevel") >= 1)then
		local tbl = {...}
		local text = table.concat(tbl," ")
		if(#text >= 1)then
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"loggedin") == 1)then
					if(getElementData(v,"Adminlevel") >= 1)then
						outputChatBox("(("..Adminsystem["Names"][getElementData(player,"Adminlevel")].." "..getPlayerName(player)..": "..text.."))",root,0,200,200)
					end
				end
			end
		end
	end
end)

addCommandHandler("admincommands",function(player)
	if(getElementData(player,"Adminlevel") >= 1)then
		for i = 1,#Admincommands do
			if(getElementData(player,"Adminlevel") >= i)then
				outputChatBox("Usable as "..Adminsystem["Names"][i]..":",player,0,200,200)
				for _,v in pairs(Admincommands[i])do
					outputChatBox(v,player,125,125,125)
				end
			else
				break
			end
		end
	end
end)

addEvent("Adminsystem.givePlayerAdminlevel",true)
addEventHandler("Adminsystem.givePlayerAdminlevel",root,function(target,adminlevel)
	local adminlevel = tonumber(adminlevel)
	local target = getPlayerFromName(target)
	
	if(getElementData(client,"Adminlevel") >= 4)then
		if(existPlayer(client,target))then
			if(adminlevel >= 0 and adminlevel <= #Adminsystem["Names"])then
				setElementData(target,"Adminlevel",adminlevel)
				infobox(target,getPlayerName(client).." gave you adminlevel "..adminlevel..". ("..Adminsystem["Names"][adminlevel]..")",0,255,0)
				infobox(client,"You gave "..getPlayerName(target).." adminlevel "..adminlevel..". ("..Adminsystem["Names"][adminlevel]..")",0,255,0)
			else infobox(client,"The adminlevel you stated doesn't exist!",255,0,0)end
		end
	else infobox(client,"You are not authorized to use this function!",255,0,0)end
end)

addEvent("Adminsystem.giveCoins",true)
addEventHandler("Adminsystem.giveCoins",root,function(target,amount)
	local target = getPlayerFromName(target)
	local amount = tonumber(amount)
	
	if(getElementData(client,"Adminlevel") >= 4)then
		if(existPlayer(client,target))then
			setElementData(target,"Coins",getElementData(target,"Coins")+amount)
			infobox(target,getPlayerName(client).." gave you "..amount.." Coins.",0,255,0)
			infobox(client,"You gave "..getPlayerName(target).." "..amount.." Coins.",0,255,0)
		end
	else infobox(client,"You are not authorized to use this function!",255,0,0)end
end)

addEvent("Adminsystem.kickPlayer",true)
addEventHandler("Adminsystem.kickPlayer",root,function(target,reason)
	local target = getPlayerFromName(target)
	
	if(getElementData(client,"Adminlevel") >= 1)then
		if(existPlayer(client,target))then
			outputChatBox(getPlayerName(target).." was kicked by "..getPlayerName(client).."! Reason: "..reason,root,125,0,0)
			infobox(client,"You kicked "..getPlayerName(target)..".",0,255,0)
			kickPlayer(target,client,reason)
		end
	else infobox(client,"You are not authorized to use this function!",255,0,0)end
end)

addEvent("Adminsystem.banPlayer",true)
addEventHandler("Adminsystem.banPlayer",root,function(target,reason,banTime)
	if(banTime and banTime ~= 0)then banTime = getSecTime(tonumber(banTime))end
	local target = getPlayerFromName(target)
	
	if(getElementData(client,"Adminlevel") >= 2)then
		if(banTime == 0)then
			dbExec(handler,"INSERT INTO bans (Username,Reason) VALUES ('"..getPlayerName(target).."','"..reason.."')")
			outputChatBox(getPlayerName(target).." was banned permanently by "..getPlayerName(client).."! Reason: "..reason,root,125,0,0)
		else
			dbExec(handler,"INSERT INTO bans (Username,Reason,STime) VALUES ('"..getPlayerName(target).."','"..reason.."','"..time.."')")
			outputChatBox(getPlayerName(target).." was banned for "..time.." hours by "..getPlayerName(client).."! Reason: "..reason,root,125,0,0)
		end
		kickPlayer(target,player,"You was banned from the server. Reason: "..reason)
		infobox(client,"You banished "..getPlayerName(target)..".",0,255,0)
	else infobox(client,"You are not authorized to use this function!",255,0,0)end
end)

addEvent("Adminsystem.givePresents",true)
addEventHandler("Adminsystem.givePresents",root,function(target,amount)
	local target = getPlayerFromName(target)
	local amount = tonumber(amount)
	
	if(getElementData(client,"Adminlevel") >= 4)then
		if(existPlayer(client,target))then
			setElementData(target,"Presents",getElementData(target,"Presents")+amount)
			infobox(target,getPlayerName(client).." gave you "..amount.." presents.",0,255,0)
			infobox(client,"You gave "..getPlayerName(target).." "..amount.." presents.",0,255,0)
		end
	else infobox(client,"You are not authorized to use this function!",255,0,0)end
end)

addEvent("Adminsystem.showPlayerInfos",true)
addEventHandler("Adminsystem.showPlayerInfos",root,function(target)
	local target = getPlayerFromName(target)
	if(getElementData(client,"Adminlevel") >= 4)then
		if(existPlayer(client,target))then
			infobox(client,"You checked "..getPlayerName(target)..".",0,255,0)
			sendAdminMessage(getPlayerName(client).." has checked "..getPlayerName(target)..".")
			outputChatBox("_____| #2abbff"..getPlayerName(target).." #ffffff|_____",client,255,255,255,true)
			outputChatBox("Serial: "..getPlayerSerial(target),client,255,255,255)
			outputChatBox("IP: "..getPlayerIP(target),client,255,255,255)
		end
	else infobox(client,"You are not authorized to use this function!",255,0,0)end
end)

addEvent("Adminsystem.teleportToZone",true)
addEventHandler("Adminsystem.teleportToZone",root,function(zone)
	if(getElementData(client,"Adminlevel") >= 1 or isPremium(client))then
		if(Adminsystem["Savezones"][zone])then
			local x,y,z = Adminsystem["Savezones"][zone][1],Adminsystem["Savezones"][zone][2],Adminsystem["Savezones"][zone][3]
			setElementPosition(client,x,y,z)
			sendAdminMessage(getPlayerName(client).." has teleported to the save zone '"..zone.."'.")
		end
	else infobox(client,"You are not authorized to use this function!",255,0,0)end
end)

addEvent("Adminsystem.teleportToPlayer",true)
addEventHandler("Adminsystem.teleportToPlayer",root,function(target)
	local target = getPlayerFromName(target)
	if(getElementData(client,"Adminlevel") >= 1)then
		if(existPlayer(client,target))then
			if(client ~= target)then
				local x,y,z = getElementPosition(target)
				setElementPosition(client,x + 1,y,z)
				setElementInterior(client,getElementInterior(target))
				setElementDimension(client,getElementDimension(target))
				sendAdminMessage(getPlayerName(client).." has teleported to "..getPlayerName(target)..".")
			end
		end
	else infobox(client,"You are not authorized to use this function!",255,0,0)end
end)

function Adminsystem.checkBan(player)
	local result = dbPoll(dbQuery(handler,"SELECT STime FROM ?? WHERE Username = ?","bans",getPlayerName(player)),-1)
	if(result and result[1])then
		for i = 1,#result do
			if(result[i]["STime"] ~= 0 and result[i]["Stime"] - getSecTime(0) <= 0)then
				dbExec(handler,"DELETE * FROM bans WHERE Username = '"..getPlayerName(player).."'")
				return true
			else
				local var = math.floor(((result[i]["STime"] - getSecTime(0))/60)*100)/100
				if(var >= 0)then
					infobox(player,"You are still banned for "..var.." hours!",255,0,0)
				else
					infobox(player,"You are banned permanently! Reason: "..getPlayerData("bans","Username",getPlayerName(player),"Reason"),255,0,0)
				end
				return false
			end
		end
	else
		return true
	end
end