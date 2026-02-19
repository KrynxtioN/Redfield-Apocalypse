Payday = {state = false}

function Payday.dxDraw()
	if(isWindowOpen() and not(isPlayerMapVisible(localPlayer)))then
		dxDrawRectangle(10*(x/1440), 314*(y/900), 212*(x/1440), 272*(y/900), tocolor(0, 0, 0, 175), false)
		dxDrawLine(10*(x/1440), 336*(y/900), 222*(x/1440), 336*(y/900), tocolor(255, 255, 255, 255), 1, false)
		dxDrawText("Payday", 10*(x/1440), 314*(y/900), 222*(x/1440), 336*(y/900), tocolor(0, 255, 0, 175), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("+ "..Payday.money.."$\n\n+ "..Payday.experiencePoints.." Experience Points\n\n+ "..Payday.coins.." eXo-Coins", 10*(x/1440), 346*(y/900), 222*(x/1440), 518*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "center", "top", false, false, false, false, false)
		dxDrawText("- Space to close -", 10*(x/1440), 564*(y/900), 222*(x/1440), 586*(y/900), tocolor(0, 255, 0, 175), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawLine(10*(x/1440), 557*(y/900), 222*(x/1440), 557*(y/900), tocolor(255, 255, 255, 255), 1, false)
	end
end

addEvent("Payday.dxDraw",true)
addEventHandler("Payday.dxDraw",root,function(money,experiencePoints,coins)
	Payday.money = money
	Payday.experiencePoints = experiencePoints
	Payday.coins = coins
	
	if(isWindowOpen())then
		if(Payday.state == false)then
			addEventHandler("onClientRender",root,Payday.dxDraw)
			Payday.state = true
			bindKey("space","down",function()
				removeEventHandler("onClientRender",root,Payday.dxDraw)
				unbindKey("space","down")
				Payday.state = false
			end)
		end
	else
		outputChatBox("_____| Payday |_____",125,125,0)
		outputChatBox("+ "..Payday.money.."$",0,125,0)
		outputChatBox("+ "..Payday.experiencePoints.." Experience Points",0,125,0)
		outputChatBox("+ "..Payday.coins.." Coins",0,125,0)
	end
end)