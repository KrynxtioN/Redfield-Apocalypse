Inventory = {state = false, scroll = 0, text = "Inventory",
	["Items"] = {
		"Bonuspoints","Chests","Hearts","Coins","Trophys","Zombieskin","TresorKeys",
	},
	["Slots"] = {
		{508, 403, 52, 49},
		{570, 403, 52, 49},
		{632, 403, 52, 49},
		{694, 403, 52, 49},
		{756, 403, 52, 49},
		{818, 403, 52, 49},
		{880, 403, 52, 49},
	},
}

function Inventory.dxDraw()
    dxDrawRectangle(498*(x/1440), 377*(y/900), 444*(x/1440), 145*(y/900), tocolor(0, 0, 0, 200), false)
    dxDrawImage(498*(x/1440), 377*(y/900), 444*(x/1440), 16*(y/900), "Files/Images/Window2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText(Inventory.text, 498*(x/1440), 377*(y/900), 942*(x/1440), 393*(y/900), tocolor(255, 255, 255, 255), 1.00*(x/1440), "default-bold", "center", "center", false, false, false, false, false)
	
	for i = 0,1 do
		local coord = 403 + (i*60)
		dxDrawRectangle(508*(x/1440), coord*(y/900), 52*(x/1440), 49*(y/900),tocolor(255,255,255,175),false)
		dxDrawRectangle(570*(x/1440), coord*(y/900), 52*(x/1440), 49*(y/900),tocolor(255,255,255,175),false)
		dxDrawRectangle(632*(x/1440), coord*(y/900), 52*(x/1440), 49*(y/900),tocolor(255,255,255,175),false)
		dxDrawRectangle(694*(x/1440), coord*(y/900), 52*(x/1440), 49*(y/900),tocolor(255,255,255,175),false)
		dxDrawRectangle(756*(x/1440), coord*(y/900), 52*(x/1440), 49*(y/900),tocolor(255,255,255,175),false)
		dxDrawRectangle(818*(x/1440), coord*(y/900), 52*(x/1440), 49*(y/900),tocolor(255,255,255,175),false)
		dxDrawRectangle(880*(x/1440), coord*(y/900), 52*(x/1440), 49*(y/900),tocolor(255,255,255,175),false)
	end
	
	local state1 = false
	for i = 1 + Inventory.scroll, 7  + Inventory.scroll do
		if(Inventory.items[i])then
			local tbl = Inventory.items[i]
			dxDrawImage(tbl[3],tbl[4],tbl[5],tbl[6],"Files/Images/Inventory/"..tbl[1]..".png",0,0,0,tocolor(255,255,255,255),true)
			if(isCursorOnElement(tbl[3],tbl[4],tbl[5],tbl[6]))then
				dxDrawRectangle(tbl[3],tbl[4],tbl[5],tbl[6],tocolor(250,250,0,200),false)
				Inventory.text = tbl[1].." ("..math.floor(tbl[2]).."x)"
				state1 = true
			end
		end
	end
	
	local state2 = false
	for i = 8 + Inventory.scroll, 14 + Inventory.scroll do
		if(Inventory.items[i])then
			local tbl = Inventory.items[i]
			dxDrawImage(tbl[3],tbl[4] + 60*(y/900),tbl[5],tbl[6],"Files/Images/Inventory/"..tbl[1]..".png",0,0,0,tocolor(255,255,255,255),true)
			if(isCursorOnElement(tbl[3],tbl[4] + 60*(y/900),tbl[5],tbl[6]))then
				dxDrawRectangle(tbl[3],tbl[4] + 60*(y/900),tbl[5],tbl[6],tocolor(250,250,0,200),false)
				Inventory.text = tbl[1].." ("..math.floor(tbl[2]).."x)"
				state2 = true
			end
		end
	end
	
	if(state1 == false and state2 == false)then
		Inventory.text = "Inventory"
	end
end

function Inventory.scrollDown()
	if(Inventory.scroll + 14 < #Inventory.items)then
		Inventory.scroll = Inventory.scroll + 7
	end
end

function Inventory.scrollUp()
	if(Inventory.scroll > 0)then
		Inventory.scroll = Inventory.scroll - 7
	end
end

function Inventory.refresh()
	local counter   = 0
	local distance  = 0
	Inventory.items = {}
	for i,v in pairs(Inventory["Items"])do
		if(tonumber(getElementData(localPlayer,v)) >= 1)then
			if(counter >= 7)then counter  = 0 end
			counter = counter + 1
			local tbl = Inventory["Slots"][counter]
			table.insert(Inventory.items,{v,getElementData(localPlayer,v),tbl[1]*(x/1440),(tbl[2] + distance * 60)*(y/900),tbl[3]*(x/1440),tbl[4]*(y/900)})
		end
	end
end
addEvent("Inventory.refresh",true)
addEventHandler("Inventory.refresh",root,Inventory.refresh)

function Inventory.click(button)
	if(button == "left")then
		for i = 1 + Inventory.scroll, 7 + Inventory.scroll do
			if(Inventory.items[i])then
				local tbl = Inventory.items[i]
				if(isCursorOnElement(tbl[3],tbl[4],tbl[5],tbl[6]))then
					triggerServerEvent("Inventory.server",localPlayer,tbl[1])
				end
			end
		end
		
		for i = 8 + Inventory.scroll, 14 + Inventory.scroll do
			if(Inventory.items[i])then
				local tbl = Inventory.items[i]
				if(isCursorOnElement(tbl[3],tbl[4] + 60*(y/900),tbl[5],tbl[6]))then
					triggerServerEvent("Inventory.server",localPlayer,tbl[1])
				end
			end
		end
	end
end

function Inventory.open()
	if(Inventory.state == false)then
		if(isWindowOpen())then
			Inventory.scroll = 0
			Inventory.refresh()
			setWindowDatas("set")
			Inventory.state = true
			addEventHandler("onClientRender",root,Inventory.dxDraw)
			bindKey("mouse_wheel_down","down",Inventory.scrollDown)
			bindKey("mouse_wheel_up","down",Inventory.scrollUp)
			addEventHandler("onClientDoubleClick",root,Inventory.click)
		end
	else
		setWindowDatas("reset")
		removeEventHandler("onClientRender",root,Inventory.dxDraw)
		Inventory.state = false
		unbindKey("mouse_wheel_down","down",Inventory.scrollDown)
		unbindKey("mouse_wheel_up","down",Inventory.scrollUp)
		removeEventHandler("onClientDoubleClick",root,Inventory.click)
	end
end
bindKey("i","down",Inventory.open)

addEventHandler("onClientPlayerWasted",root,function(player)
	if(player == localPlayer)then
		if(Inventory.state == true)then
			Inventory.open()
		end
	end
end)