Adminsystem = {
	["Names"] = {
		[0] = "User",
		[1] = "Supporter",
		[2] = "Moderator",
		[3] = "Administrator",
		[4] = "Project Manager",
	},
	["Savezones"] = {
		"San Fierro Railway Station","Chicken Valley",
	},
}

addEvent("Adminsystem.putTeamMembersInATable",true)
addEventHandler("Adminsystem.putTeamMembersInATable",root,function(members)
	if(#members >= 1)then
		Adminsystem.allMembers = {}
		for _,v in pairs(members)do
			table.insert(Adminsystem.allMembers,{v[1],Adminsystem["Names"][v[2]]})
		end
		Adminsystem.openTeamWindow()
	end
end)

function Adminsystem.openTeamWindow()
    ApocalypseUI.window[1] = guiCreateWindow(544, 298, 327, 222, "Team", false)

    ApocalypseUI.gridlist[1] = guiCreateGridList(10, 26, 307, 186, false, ApocalypseUI.window[1])
    usernameGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Username", 0.5)
    adminlevelGridlist = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Adminlevel", 0.5)
	setWindowDatas("set")
	
	if(#Adminsystem.allMembers >= 1)then
		for _,v in pairs(Adminsystem.allMembers)do
			local row = guiGridListAddRow(ApocalypseUI.gridlist[1])
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,usernameGridlist,v[1],false,false)
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,adminlevelGridlist,v[2],false,false)
		end
	end
end