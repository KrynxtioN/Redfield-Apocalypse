HUD = {pointsPerLevel = 250,
	["Components"] = {
		"ammo","armour","breath","clock","health","money","weapon","wanted",
	},
}

NewFont = dxCreateFont("Files/Fonts/Font.ttf",10)
for _,v in pairs(HUD["Components"])do setPlayerHudComponentVisible(v,false)end

function dxDrawHUD()
	if(isWindowOpen() and not(isPlayerMapVisible(localPlayer)))then
		local x1,y1,x2 = interpolateBetween(0,0-500,0,0,11,0,(getTickCount()-lastTick)/(lastTick+3000-lastTick),"OutBounce")
		local Money = getElementData(localPlayer,"Money")
		local Health = getElementHealth(localPlayer)
		local Armor = getPedArmor(localPlayer)
		local level = getElementData(localPlayer,"Level")+1
		local experiencePoints = getElementData(localPlayer,"ExperiencePoints")

		local time = getRealTime()
		local day,monat,year = time.monthday,time.month+1,time.year+1900
		local hour,minute = time.hour,time.minute
		if(day < 10)then day = "0"..day end
		if(monat < 10)then monat = "0"..monat end
		if(hour < 10)then hour = "0"..hour end
		if(minute < 10)then minute = "0"..minute end
		
		dxDrawRectangle(1086*(x/1440), y1*(y/900), 344*(x/1440), 41*(y/900), tocolor(17, 17, 17, 200), false)
		dxDrawRectangle(1086*(x/1440), y1*(y/900), 344*(x/1440), 10*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawText(day.."."..monat.."."..year, 1096*(x/1440), y1+10*(y/900), 1268*(x/1440), 52*(y/900), tocolor(255, 255, 255, 255), 1.00, NewFont, "left", "center", false, false, false, false, false)
		dxDrawText(hour.. ":" ..minute.." Uhr", 1319*(x/1440), y1+10*(y/900), 1420*(x/1440), 52*(y/900), tocolor(255, 255, 255, 255), 1.00, NewFont, "right", "center", false, false, false, false, false)
		dxDrawRectangle(1086*(x/1440), y1+179*(y/900), 344*(x/1440), 10*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawRectangle(1086*(x/1440), y1+51*(y/900), 344*(x/1440), 10*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawRectangle(1086*(x/1440), y1+74*(y/900), 296*(x/1440), 11*(y/900), tocolor(179, 0, 0, 200), false)
		dxDrawRectangle(1086*(x/1440), y1+92*(y/900), 344*(x/1440), 10*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawRectangle(1086*(x/1440), y1+61*(y/900), 296*(x/1440), 13*(y/900), tocolor(200, 0, 0, 200), false)
		dxDrawRectangle(1086*(x/1440), y1+133*(y/900), 344*(x/1440), 10*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawRectangle(1086*(x/1440), y1+145*(y/900), 296*(x/1440), 12*(y/900), tocolor(0, 200, 0, 200), false)
		dxDrawRectangle(1086*(x/1440), y1+157*(y/900), 296*(x/1440), 12*(y/900), tocolor(0, 179, 0, 200), false)
		dxDrawRectangle(1086*(x/1440), y1+179*(y/900), 344*(x/1440), 41*(y/900), tocolor(17, 17, 17, 200), false)
		dxDrawRectangle(1086*(x/1440), y1+135*(y/900), 344*(x/1440), 10*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawText(math.floor(Money).."$", 1096*(x/1440), y1+189*(y/900), 1268*(x/1440), 231*(y/900), tocolor(255, 255, 255, 255), 1.00, NewFont, "left", "center", false, false, false, false, false)
		dxDrawRectangle(1382*(x/1440), y1+189*(y/900), 48*(x/1440), 31*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawRectangle(1382*(x/1440), y1+61*(y/900), 48*(x/1440), 24*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawRectangle(1382*(x/1440), y1+61*(y/900), 48*(x/1440), 24*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawRectangle(1382*(x/1440), y1+102*(y/900), 48*(x/1440), 24*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawRectangle(1382*(x/1440), y1+145*(y/900), 48*(x/1440), 24*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawRectangle(965*(x/1440), y1*(y/900), 111*(x/1440), 85*(y/900), tocolor(17, 17, 17, 200), false)
		dxDrawRectangle(965*(x/1440), y1*(y/900), 111*(x/1440), 10*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawRectangle(965*(x/1440), y1+85*(y/900), 111*(x/1440), 17*(y/900), tocolor(17, 17, 17, 255), false)
		dxDrawText(getPedAmmoInClip(localPlayer).." - "..getPedTotalAmmo(localPlayer) - getPedAmmoInClip(localPlayer), 965*(x/1440), y1+85*(y/900), 1076*(x/1440), 113*(y/900), tocolor(255, 255, 255, 255), 1.00, NewFont, "center", "center", false, false, false, false, false)
		dxDrawText(math.floor(Health).."%", 1086*(x/1440), y1+61*(y/900), 1382*(x/1440), 95*(y/900), tocolor(255, 255, 255, 255), 1.00, NewFont, "center", "center", false, false, false, false, false)
			
		if(isElementInWater(localPlayer))then
			dxDrawRectangle(1086*(x/1440), y1+102*(y/900), 296*(x/1440), 12*(y/900), tocolor(0, 50, 255, 200), false)
			dxDrawRectangle(1086*(x/1440), y1+114*(y/900), 296*(x/1440), 12*(y/900), tocolor(0, 50, 234, 200), false)
			dxDrawText(math.floor(getPedOxygenLevel(localPlayer)/10).."%", 1086*(x/1440), y1+102*(y/900), 1382*(x/1440), 136*(y/900), tocolor(255, 255, 255, 255), 1.00, NewFont, "center", "center", false, false, false, false, false)
			dxDrawImage(1388*(x/1440), y1+102*(y/900), 32*(x/1440), 23*(y/900), "Files/Images/HUD/Oxygen.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawRectangle(1086*(x/1440), y1+102*(y/900), 296*(x/1440), 12*(y/900), tocolor(0, 0, 200, 200), false)
			dxDrawRectangle(1086*(x/1440), y1+114*(y/900), 296*(x/1440), 12*(y/900), tocolor(0, 0, 179, 200), false)
			dxDrawText(math.floor(Armor).."%", 1086*(x/1440), y1+102*(y/900), 1382*(x/1440), 136*(y/900), tocolor(255, 255, 255, 255), 1.00, NewFont, "center", "center", false, false, false, false, false)
			dxDrawImage(1388*(x/1440), y1+102*(y/900), 32*(x/1440), 23*(y/900), "Files/Images/HUD/Armor.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
			
		dxDrawText(experiencePoints.."/"..level*HUD.pointsPerLevel, 1086*(x/1440), y1+145*(y/900), 1382*(x/1440), 179*(y/900), tocolor(255, 255, 255, 255), 1.00, NewFont, "center", "center", false, false, false, false, false)
		dxDrawImage(987*(x/1440), y1+14*(y/900), 65*(x/1440), 61*(y/900), "Files/Images/HUD/Weapons/"..tostring(getPedWeapon(localPlayer))..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(1387*(x/1440), y1+188*(y/900), 37*(x/1440), 32*(y/900), "Files/Images/HUD/Money.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(1388*(x/1440), y1+145*(y/900), 32*(x/1440), 23*(y/900), "Files/Images/HUD/XP.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(1388*(x/1440), y1+61*(y/900), 32*(x/1440), 23*(y/900), "Files/Images/HUD/Health.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		
		for _,v in pairs(HUD["Components"])do setPlayerHudComponentVisible(v,false)end
	end
end

addEvent("dxDrawHUD",true)
addEventHandler("dxDrawHUD",root,function()
	setTimer(function()
		lastTick = getTickCount()
		addEventHandler("onClientRender",root,dxDrawHUD)
	end,1000,1)
end)