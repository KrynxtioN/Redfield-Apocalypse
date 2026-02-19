function sendOfflineMessage(name,text)
	if(name and text)then
		dbExec(handler,"INSERT INTO offlinemessages (Username,Text) VALUES ('"..name.."','"..text..")")
	end
end

function checkOfflineMessages(player)
	local messages = dbPoll(dbQuery(handler,"SELECT * FROM offlinemessages"),-1)
	if(#messages >= 1)then
		for _,v in pairs(messages)do
			if(v["Username"] == getPlayerName(player))then
				outputChatBox("[Offline-MSG]: "..v["text"],player,150,150,150)
				dbExec(handler,"DELETE FROM offlinemessages WHERE ID = '"..v["ID"].."'")
			end
		end
	end
end