addEvent("Toplist.getDatas",true)
addEventHandler("Toplist.getDatas",root,function(category)
	local datas = {}
	local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata ORDER BY "..category.." DESC"),-1)
	if(#result >= 1)then
		for i,v in pairs(result)do
			table.insert(datas,{v["Username"],v[category]})
			if(i >= 15)then break end
		end
	end
	triggerClientEvent(client,"Toplist.setDatas",client,datas)
end)