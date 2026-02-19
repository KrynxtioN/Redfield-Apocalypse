News = {texte = {}, text = nil, site = 1, open = false}

function News.dxDraw()
    dxDrawRectangle(464*(x/1440), 209*(y/900), 513*(x/1440), 481*(y/900), tocolor(0, 0, 0, 150), false)
    dxDrawRectangle(464*(x/1440), 209*(y/900), 513*(x/1440), 19*(y/900), tocolor(0, 169, 249, 255), false)
    dxDrawText("News", 464*(x/1440), 209*(y/900), 977*(x/1440), 228*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, true, false, false, false)
	dxDrawImage(464*(x/1440), 209*(y/900), 20*(x/1440), 19*(y/900), "Files/Images/Cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText(News.text, 474*(x/1440), 238*(y/900), 967*(x/1440), 651*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, true, false, false, false)
    dxDrawText("Site "..News.site.."/"..#News.texte, 474*(x/1440), 661*(y/900), 598*(x/1440), 680*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(608*(x/1440), 661*(y/900), 174*(x/1440), 19*(y/900), tocolor(255,0,0, 255), false)
    dxDrawRectangle(792*(x/1440), 661*(y/900), 174*(x/1440), 19*(y/900), tocolor(0,255,0, 255), false)
    dxDrawText("Previous site", 608*(x/1440), 661*(y/900), 782*(x/1440), 680*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Next site", 793*(x/1440), 661*(y/900), 967*(x/1440), 680*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function News.createDxDraw(tbl)
	if(News.open == false)then
		if(isWindowOpen())then
			setWindowDatas("set")
			News.site = 1
			News.texte = tbl
			News.open = true
			News.text = News.texte[News.site][2]
			addEventHandler("onClientRender",root,News.dxDraw)
			addEventHandler("onClientClick",root,News.click)
			triggerServerEvent("News.setReaded",localPlayer,News.texte[News.site][1])
		end
	else
		setWindowDatas("reset")
		News.texte = {}
		News.open = false
		removeEventHandler("onClientRender",root,News.dxDraw)
		removeEventHandler("onClientClick",root,News.click)
	end
end
addEvent("News.createDxDraw",true)
addEventHandler("News.createDxDraw",root,News.createDxDraw)

function News.click(button,state)
	if(button == "left" and state == "down")then
		if(isCursorOnElement(792*(x/1440), 661*(y/900), 174*(x/1440), 19*(y/900)))then
			if(News.site < #News.texte)then
				News.site = News.site + 1
				News.text = News.texte[News.site][2]
				triggerServerEvent("News.setReaded",localPlayer,News.texte[News.site][1])
			end
		elseif(isCursorOnElement(608*(x/1440), 661*(y/900), 174*(x/1440), 19*(y/900)))then
			if(News.site > 1)then
				News.site = News.site - 1
				News.text = News.texte[News.site][2]
				triggerServerEvent("News.setReaded",localPlayer,News.texte[News.site][1])
			end
		elseif(isCursorOnElement(464*(x/1440), 209*(y/900), 20*(x/1440), 19*(y/900)))then
			News.createDxDraw()
		end
	end
end