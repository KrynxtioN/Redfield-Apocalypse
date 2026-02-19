cInfobox = {state = false}

function infobox(text,r,g,b)
	cInfobox.datas = {text,r,g,b}
	if(isTimer(cInfobox.timer))then killTimer(cInfobox.timer)end
	if(cInfobox.state == false)then
		addEventHandler("onClientRender",root,cInfobox.dxDraw)
		cInfobox.state = true
	end
	cInfobox.timer = setTimer(function()
		removeEventHandler("onClientRender",root,cInfobox.dxDraw)
		cInfobox.state = false
	end,7500,1)
end
addEvent("infobox",true)
addEventHandler("infobox",root,infobox)

function cInfobox.dxDraw()
	if(isWindowOpen())then
        dxDrawRectangle(576*(x/1440), 10*(y/900), 287*(x/1440), 119*(y/900), tocolor(0, 0, 0, 200), true)
        dxDrawImage(576*(x/1440), 10*(y/900), 287*(x/1440), 15*(y/900), "Files/Images/Window2.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText(cInfobox.datas[1], 586*(x/1440), 35*(y/900), 853*(x/1440), 119*(y/900), tocolor(cInfobox.datas[2],cInfobox.datas[3],cInfobox.datas[4], 255), 1.00*(x/1440), "default-bold", "center", "center", false, true, true, false, false)
        dxDrawText("Infobox", 576*(x/1440), 10*(y/900), 863*(x/1440), 25*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, true, true, false, false)
	else
        dxDrawRectangle(576*(x/1440), 45*(y/900), 287*(x/1440), 119*(y/900), tocolor(0, 0, 0, 200), true)
        dxDrawImage(576*(x/1440), 45*(y/900), 287*(x/1440), 15*(y/900), "Files/Images/Window2.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText(cInfobox.datas[1], 586*(x/1440), 70*(y/900), 853*(x/1440), 154*(y/900), tocolor(cInfobox.datas[2],cInfobox.datas[3],cInfobox.datas[4], 255), 1.00*(x/1440), "default-bold", "center", "center", false, true, true, false, false)
        dxDrawText("Infobox", 576*(x/1440), 45*(y/900), 863*(x/1440), 60*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, true, true, false, false)
	end
end