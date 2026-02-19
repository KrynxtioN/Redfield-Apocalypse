Scoreboard = {scroll = 0, scoreboard = false}

bindKey("tab","down",function()
	if(getElementData(localPlayer,"loggedin") == 1)then
		if(isWindowOpen())then
			Scoreboard.scoreboard = true
			setWindowDatas("set")
			Scoreboard.update()
			addEventHandler("onClientRender",root,Scoreboard.dxDraw)
			Scoreboard.updateTimer = setTimer(Scoreboard.update,10000,0)
			bindKey("mouse_wheel_down","down",Scoreboard.scrollDown)
			bindKey("mouse_wheel_up","down",Scoreboard.scrollUp)
			toggleControl("next_weapon",false)
			toggleControl("previous_weapon",false)
			toggleControl("fire",false)
			showCursor(false)
		end
	end
end)

bindKey("tab","up",function()
	if(Scoreboard.scoreboard == true)then
		Scoreboard.scoreboard = false
		setWindowDatas("reset")
		removeEventHandler("onClientRender",root,Scoreboard.dxDraw)
		bindKey("mouse_wheel_down","down",Scoreboard.scrollDown)
		bindKey("mouse_wheel_up","down",Scoreboard.scrollUp)
		killTimer(Scoreboard.updateTimer)
		toggleControl("next_weapon",true)
		toggleControl("previous_weapon",true)
		toggleControl("fire",true)
	end
end)

function Scoreboard.scrollDown()
	if(Scoreboard.scoreboard == true)then
		if(#getElementsByType("player")-Scoreboard.scroll <= 2)then
			Scoreboard.scroll = #getElementsByType("player")
		else
			Scoreboard.scroll = Scoreboard.scroll + 2
		end
	end
end

function Scoreboard.scrollUp()
	if(Scoreboard.scoreboard == true)then
		if(Scoreboard.scroll <= 2)then
			Scoreboard.scroll = 0
		else
			Scoreboard.scroll = Scoreboard.scroll - 2
		end
	end
end

function Scoreboard.formString(text)
	if(string.len(text) == 1)then
		text = "0"..text
	end
	return text
end

function Scoreboard.update()
	pl = {}
	local i = 1
	
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1)then
			local playingtime = getElementData(v,"Playingtime")
			local hour = math.floor(playingtime/60)
			local minute = playingtime-hour*60
		
			pl[i] = {}
			pl[i].name = getPlayerName(v)
			if(getElementData(v,"Adminlevel") >= 1)then
				pl[i].name = Serverinfos.clantag..getPlayerName(v)
			end
			pl[i].ping = getPlayerPing(v)
			pl[i].playtime = Scoreboard.formString(hour)..":"..Scoreboard.formString(minute) 
			pl[i].zombiekills = getElementData(v,"Zombiekills")
			pl[i].deaths = getElementData(v,"Deaths")
			pl[i].level = getElementData(v,"Level")
			pl[i].information = Adminsystem["Names"][getElementData(v,"Adminlevel")]
			if(getElementData(v,"Premium") == 1 or getElementData(v,"LifetimePremium") == 1)then
				pl[i].colors = {218,165,32}
			else
				pl[i].colors = {255,255,255}
			end
			pl[i].team = getElementData(v,"Teamname")
			
			i = i + 1
		end
	end
end

function Scoreboard.dxDraw()
    dxDrawRectangle(358*(x/1440), 255*(y/900), 724*(x/1440), 389*(y/900), tocolor(17,17,17, 150), false)
	dxDrawImage(358*(x/1440), 255*(y/900), 724*(x/1440), 22*(y/900), "Files/Images/Window2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Scoreboard", 358*(x/1440), 255*(y/900), 1082*(x/1440), 277*(y/900), tocolor(255,255,255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Username", 368*(x/1440), 287*(y/900), 478*(x/1440), 308*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(487*(x/1440), 276*(y/900), 487*(x/1440), 643*(y/900), tocolor(255, 255, 255, 255), 2, false)
    dxDrawText("Playingtime", 497*(x/1440), 287*(y/900), 583*(x/1440), 308*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(593*(x/1440), 277*(y/900), 593*(x/1440), 644*(y/900), tocolor(255, 255, 255, 255), 2, false)
    dxDrawText("Zombie-Kills", 603*(x/1440), 287*(y/900), 684*(x/1440), 308*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(694*(x/1440), 277*(y/900), 694*(x/1440), 644*(y/900), tocolor(255, 255, 255, 255), 2, false)
    dxDrawText("Deaths", 704*(x/1440), 287*(y/900), 814*(x/1440), 308*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(824*(x/1440), 277*(y/900), 824*(x/1440), 644*(y/900), tocolor(255, 255, 255, 255), 2, false)
    dxDrawText("Level", 834*(x/1440), 287*(y/900), 915*(x/1440), 308*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(925*(x/1440), 277*(y/900), 925*(x/1440), 644*(y/900), tocolor(255, 255, 255, 255), 2, false)
    dxDrawText("Team", 935*(x/1440), 287*(y/900), 1017*(x/1440), 308*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(1027*(x/1440), 277*(y/900), 1027*(x/1440), 644*(y/900), tocolor(255, 255, 255, 255), 2, false)
    dxDrawText("Ping", 1037*(x/1440), 287*(y/900), 1072*(x/1440), 308*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(359*(x/1440), 312*(y/900), 1081*(x/1440), 312*(y/900), tocolor(255, 255, 255, 255), 2, false)
	
	local id = 0
	for i = 1 + Scoreboard.scroll,12 + Scoreboard.scroll do
		if(pl[i])then
			dxDrawText(pl[i].name, 368*(x/1440), 322*(y/900)+(17*id)+13, 478*(x/1440), 343*(y/900)+(17*id)+13, tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].playtime, 497*(x/1440), 322*(y/900)+(17*id)+13, 583*(x/1440), 343*(y/900)+(17*id)+13, tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].zombiekills, 603*(x/1440), 322*(y/900)+(17*id)+13, 684*(x/1440), 343*(y/900)+(17*id)+13, tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].deaths, 704*(x/1440), 322*(y/900)+(17*id)+13, 814*(x/1440), 343*(y/900)+(17*id)+13, tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].level, 834*(x/1440), 322*(y/900)+(17*id)+13, 915*(x/1440), 343*(y/900)+(17*id)+13, tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].team, 935*(x/1440), 322*(y/900)+(17*id)+13, 1017*(x/1440), 343*(y/900)+(17*id)+13, tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].ping, 1037*(x/1440), 322*(y/900)+(17*id)+13, 1072*(x/1440), 343*(y/900)+(17*id)+13, tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			
			id = id + 1
		end
	end
end