Weaponskills = {state = false, weapon = nil}

function Weaponskills.dxDraw()
	if(isWindowOpen())then
		dxDrawRectangle(1160*(x/1440), 242*(y/900), 270*(x/1440), 42*(y/900), tocolor(17, 17, 17, 200), false)
        dxDrawText(getWeaponNameFromID(getPedWeapon(localPlayer)).." Skill: "..math.floor(getElementData(localPlayer,Weaponskills.weapon)).."/1000", 1160*(x/1440), 242*(y/900), 1430*(x/1440), 284*(y/900), tocolor(255, 255, 255, 255), 1.00, NewFont, "center", "center", false, false, false, false, false)
	end
end

addEvent("Weaponskills.dxDraw",true)
addEventHandler("Weaponskills.dxDraw",root,function(weapon)
	Weaponskills.weapon = weapon
	if(isTimer(Weaponskills.timer))then killTimer(Weaponskills.timer)end
	if(Weaponskills.state == false)then
		addEventHandler("onClientRender",root,Weaponskills.dxDraw)
		Weaponskills.state = true
		addEventHandler("onClientPlayerWeaponSwitch",root,Weaponskills.destroy)
	end
	Weaponskills.timer = setTimer(function()
		removeEventHandler("onClientRender",root,Weaponskills.dxDraw)
		Weaponskills.state = false
		removeEventHandler("onClientPlayerWeaponSwitch",root,Weaponskills.destroy)
	end,5000,1)
end)

function Weaponskills.destroy()
	if(Weaponskills.state == true)then
		if(isTimer(Weaponskills.timer))then killTimer(Weaponskills.timer)end
		removeEventHandler("onClientRender",root,Weaponskills.dxDraw)
		Weaponskills.state = false
		removeEventHandler("onClientPlayerWeaponSwitch",root,Weaponskills.destroy)
	end
end