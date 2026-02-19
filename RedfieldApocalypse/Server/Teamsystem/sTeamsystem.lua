Teamsystem = {costs = 50000}

function Teamsystem.getMember(team)
	local members = {}
	local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata"),-1)
	
	for _,v in pairs(result)do
		if(v["Team"] == tonumber(team))then
			local target = getPlayerFromName(v["Username"])
			if(isElement(target))then state = "Online" else state = "Offline" end
			table.insert(members,{v["Username"],v["Teamrang"],state})
		end
	end
	return members
end

addEvent("Teamsystem.createTeam",true)
addEventHandler("Teamsystem.createTeam",root,function(name)
	if(getElementData(client,"Money") >= Teamsystem.costs)then
		if(getElementData(client,"Team") == 0)then
			local result = dbPoll(dbQuery(handler,"SELECT * FROM teams WHERE Name = '"..name.."'"),-1)
			if(#result == 0)then
				infobox(client,"You have created a team and can now manage it under F2.",0,255,0)
				setElementData(client,"Money",getElementData(client,"Money")-Teamsystem.costs)
				dbExec(handler,"INSERT INTO teams (Name,Owner) VALUES ('"..name.."','"..getPlayerName(client).."')")
				setElementData(client,"Team",getPlayerData("teams","Name",name,"ID"))
				setElementData(client,"Teamrang",5)
				dbExec(handler,"UPDATE userdata SET Team = '"..getElementData(client,"Team").."', Teamrang = '5' WHERE Username = '"..getPlayerName(client).."'")
			else infobox(client,"The name is already taken!",255,0,0)end
		else infobox(client,"You are already in a team!",255,0,0)end
	else infobox(client,"You don't have enough money!",255,0,0)end
end)

addEvent("Teamsystem.inviteUninvite",true)
addEventHandler("Teamsystem.inviteUninvite",root,function(target,type)
	local target = getPlayerFromName(target)
	local team = getElementData(client,"Team")
	
	if(existPlayer(client,target))then
		if(getElementData(client,"Teamrang") >= 5 and client ~= target)then
			if(type == "Invite")then
				if(getElementData(target,"Team") == 0)then
					setElementData(target,"Team",team)
					setElementData(target,"Teamrang",0)
					infobox(client,"You invitet "..getPlayerName(target).." in your team.",0,255,0)
					infobox(target,getPlayerName(client).." invitet you in his team.",0,255,0)
					dbExec(handler,"UPDATE userdata SET Team = '"..team.."', Teamrang = '0' WHERE Username = '"..getPlayerName(target).."'")
					setElementData(target,"Teamname",getElementData(client,"Teamname"))
				else infobox(client,"The player is already in a team!",255,0,0)end
			else
				if(getElementData(target,"Team") == team)then
					setElementData(target,"Team",0)
					setElementData(target,"Teamrang",0)
					infobox(client,"You uninvite "..getPlayerName(target).." from your team.",0,255,0)
					infobox(client,getPlayerName(target).." uninvite you from his team!",255,0,0)
					dbExec(handler,"UPDATE userdata SET Team = '0', Teamrang = '0' WHERE Username = '"..getPlayerName(target).."'")
					setElementData(target,"Teamname","-")
				else infobox(client,"The player is not in your team!",255,0,0)end
			end
		else infobox(client,"You are not authorized to use this function!",255,0,0)end
		Teamsystem.updateTeampanel(client)
	end
end)

addEvent("Teamsystem.changeRang",true)
addEventHandler("Teamsystem.changeRang",root,function(target,type)
	local target = getPlayerFromName(target)
	local team = getElementData(client,"Team")
	
	if(existPlayer(client,target))then
		if(getElementData(target,"Team") == team)then
			if(getElementData(client,"Teamrang") >= 5 and client ~= target)then
				if(type == "Rang-Up")then
					if(getElementData(target,"Teamrang") < 5)then
						setElementData(target,"Teamrang",getElementData(target,"Teamrang")+1)
						infobox(client,"You give "..getPlayerName(target).." a Rang-Up!",0,255,0)
						infobox(target,"You got a Rang-Up!",0,255,0)
						dbExec(handler,"UPDATE userdata SET Teamrang = '"..getElementData(target,"Teamrang").."' WHERE Username = '"..getPlayerName(target).."'")
					else infobox(client,"The player has already the highest rang!",255,0,0)end
				else
					if(getElementData(target,"Teamrang") > 0)then
						setElementData(target,"Teamrang",getElementData(target,"Teamrang")-1)
						infobox(client,"You give "..getPlayerName(target).." a Rang-Down!",0,255,0)
						infobox(target,"You got a Rang-Down!",255,0,0)
						dbExec(handler,"UPDATE userdata SET Teamrang = '"..getElementData(target,"Teamrang").."' WHERE Username = '"..getPlayerName(target).."'")
					else infobox(client,"The player has already the smallest rang!",255,0,0)end
				end
			else infobox(client,"You are not authorized to do this!",255,0,0)end
		end
		Teamsystem.updateTeampanel(client)
	end
end)

addEvent("Teamsystem.cashRegister",true)
addEventHandler("Teamsystem.cashRegister",root,function(amount,type)
	local amount = tonumber(amount)
	local team   = getElementData(client,"Team")
	local cash   = getPlayerData("teams","ID",team,"Cash")
	
	if(type == "Pay off")then
		if(getElementData(client,"Teamrang") >= 4)then
			if(cash >= amount)then
				setElementData(client,"Money",getElementData(client,"Money")+amount)
				infobox(client,"You pay off $"..amount..".",0,255,0)
				dbExec(handler,"UPDATE teams SET Cash = '"..cash - amount.."' WHERE ID = '"..team.."'")
			else infobox(client,"There's not enough money in the cash register!",255,0,0)end
		else infobox(client,"You are not authorized to use this function!",255,0,0)end
	else
		if(getElementData(client,"Money") >= amount)then
			setElementData(client,"Money",getElementData(client,"Money")-amount)
			infobox(client,"You deposit $"..amount..".",0,255,0)
			dbExec(handler,"UPDATE teams SET Cash = '"..cash + amount.."' WHERE ID = '"..team.."'")
		else infobxo(client,"You have not enough money!",255,0,0)end
	end
	Teamsystem.updateTeampanel(client)
end)

addEvent("Teamsystem.deleteTeam",true)
addEventHandler("Teamsystem.deleteTeam",root,function()
	local team = getElementData(client,"Team")
	if(getPlayerData("teams","ID",team,"Owner") == getPlayerName(client))then
		dbExec(handler,"DELETE FROM teams WHERE ID = '"..team.."'")
		local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata"),-1)
		for _,v in pairs(result)do
			if(v["Team"] == team)then
				local target = getPlayerFromName(v["Username"])
				if(isElement(target) and getElementData(target,"loggedin") == 1)then
					setElementData(target,"Team",0)
					setElementData(target,"Teamrang",0)
				end
				dbExec(handler,"UPDATE userdata SET Team = '0', Teamrang = '0' WHERE Username = '"..v["Username"].."'")
			end
		end
		Teamsystem.updateBlips()
		infobox(client,"You deleted your team!",255,0,0)
		triggerClientEvent(client,"setWindowDatas",client)
	else infobox(client,"You are not the owner of this team!",255,0,0)end
end)

function Teamsystem.openTeampanel(player)
	if(tonumber(getElementData(player,"Team")) >= 1)then
		local name = getPlayerData("teams","ID",getElementData(player,"Team"),"Name")
		local cash = getPlayerData("teams","ID",getElementData(player,"Team"),"Cash")
		triggerClientEvent(player,"Teamsystem.openTeampanel",player,name,cash)
		Teamsystem.updateTeampanel(player)
	end
end

function Teamsystem.updateTeampanel(player)
	Teamsystem.updateBlips()
	local team = getElementData(player,"Team")
	local cash = getPlayerData("teams","ID",team,"Cash")
	triggerClientEvent(player,"Teamsystem.updateTeampanel",player,Teamsystem.getMember(team),cash)
end

function Teamsystem.updateBlips()
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedIn(v))then
			triggerClientEvent(v,"Teamsystem.createBlips",v)
		end
	end
end