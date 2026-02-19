Adminsystem = {
	["Names"] = {
		[0] = "User",
		[1] = "Supporter",
		[2] = "Moderator",
		[3] = "Administrator",
		[4] = "Project Manager",
	},
	["Savezones"] = {
		["San Fierro Railway Station"] = {-1962.6141357422,141.28392028809,27.694049835205},
		["Chicken Valley"] = {-209.47142028809,2716.384765625,62.6875},
	},
}

addCommandHandler("admins",function(player)
	local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata"),-1)
	if(#result >= 1)then
		local members = {}
		for _,v in pairs(result)do
			if(v["Adminlevel"] >= 1)then
				table.insert(members,{v["Username"],v["Adminlevel"]})
			end
		end
		triggerClientEvent(player,"Adminsystem.putTeamMembersInATable",player,members)
	end
end)