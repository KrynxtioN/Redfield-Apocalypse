x,y = guiGetScreenSize()
ApocalypseUI = {window = {}, button = {}, label = {}, edit = {}, gridlist = {}, staticimage = {}, memo = {}}
Serverinfos = {name = "Redfield Apocalypse", version = "v.1.1.0", clantag = "[RA]"}

local WindowPoints = 0
local ScreenSource = dxCreateScreenSource(x,y)
BlurShader = dxCreateShader("Files/Shader/Blur.fx")

local OnlyNumbersTable = {"a","b","c","d","e","f","g","h","i","j","k","l","m","o","p","y","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","O","P","Q","R","S","T","U","V","W","X","Y","Z","ä","ü","ö","Ä","Ü","Ö"," ",",","#","'","+","*","~",":","","=","}","?","\\","{","&","/","§","\"","!","°","@","|","`","´","-","+"}

function isOnlyNumbers(text)
	local counter = 0
	for k,v in ipairs(OnlyNumbersTable)do
		if(string.find(text,v))then
			counter = counter + 1
			break
		end
	end
	if(counter > 0)then
		infobox("Only numbers are allowed!",255,0,0)
		return false
	else
		return true
	end
end

function renderBlur()
	if(BlurShader)then
		dxUpdateScreenSource(ScreenSource)
		dxSetShaderValue(BlurShader,"ScreenSource",ScreenSource)
		dxSetShaderValue(BlurShader,"BlurStrength",7)
		dxSetShaderValue(BlurShader,"UVSize",x,y)
		dxDrawImage(0,0,x,y,BlurShader)
	end
end

function centerWindow (center_window)
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (x - windowW) /2,(y - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end

function isCursorOnElement( posX, posY, width, height )
	if isCursorShowing( ) then
		local mouseX, mouseY = getCursorPosition( )
		local clientW, clientH = guiGetScreenSize( )
		local mouseX, mouseY = mouseX * clientW, mouseY * clientH
		if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
			return true
		end
	end
	return false
end

function dxDrawKinobalken()
	if(KinobalkenState == true)then
		if(WindowPoints < 35)then
			WindowPoints = WindowPoints + 1
		end
	elseif(KinobalkenState == false)then
		if(WindowPoints > 0)then
			WindowPoints = WindowPoints - 1
		end
	end
	dxDrawRectangle(0*(x/1440), 0*(y/900), 1440*(x/1440), WindowPoints*(y/900), tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(0*(x/1440), 900*(y/900), 1440*(x/1440), - WindowPoints*(y/900), tocolor(0, 0, 0, 255), false)
end

function setWindowDatas(type,blur,center)
	if(type == "set")then
		if(isElement(ApocalypseUI.window[1]))then
			if(not(center))then
				centerWindow(ApocalypseUI.window[1])
			end
		end
		showChat(false)
		showCursor(true)
		setElementData(localPlayer,"elementClicked",true)
		if(not(blur))then
			addEventHandler("onClientRender",root,renderBlur)
		end
		KinobalkenState = true
		addEventHandler("onClientRender",root,dxDrawKinobalken)
	else
		if(isElement(ApocalypseUI.window[1]))then
			destroyElement(ApocalypseUI.window[1])
		end
		showChat(true)
		showCursor(false)
		removeEventHandler("onClientRender",root,renderBlur)
		KinobalkenState = false
		
		setTimer(function()
			setElementData(localPlayer,"elementClicked",false)
			WindowPoints = 0
			removeEventHandler("onClientRender",root,dxDrawKinobalken)
		end,750,1)
		Skinshop.destroy()
	end
end
addEvent("setWindowDatas",true)
addEventHandler("setWindowDatas",root,setWindowDatas)

function isWindowOpen()
	if(isElement(ApocalypseUI.window[1]) or getElementData(localPlayer,"elementClicked") == true)then
		return false
	else
		return true
	end
end

bindKey("m","down",function()
	if(isWindowOpen())then
		showCursor(not(isCursorShowing()))
	end
end)

addEventHandler("onClientPlayerDamage",root,function()
	cancelEvent()
end)

addEventHandler("onClientPlayerWasted",root,function()
	setWindowDatas("reset")
end)