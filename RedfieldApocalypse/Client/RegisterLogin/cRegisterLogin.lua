RegisterLogin = {}

function RegisterLogin.load()
	setWeather(9)
	fadeCamera(true)
	setElementData(localPlayer,"loggedin",0)
	setElementData(localPlayer,"savezone",1)
	setElementDimension(localPlayer,0)
	
	setCameraMatrix (-2005.4229736328,193.98599243164,46.244598388672,-2004.8247070313,193.29585266113,45.837471008301)
	smoothMoveCamera(-2005.4229736328,193.98599243164,46.244598388672,-2004.8247070313,193.29585266113,45.837471008301,-1992.9862060547,137.99920654297,33.469501495361,-1992.0090332031,137.99261474609,33.257274627686,7500)
	
	RegisterLogin.sound = playSound("Files/RegisterLogin.mp3")
	
	triggerServerEvent("RegisterLogin.checkAccount",localPlayer)
end
RegisterLogin.load()

addEvent("RegisterLogin.createWindow",true)
addEventHandler("RegisterLogin.createWindow",root,function(type)
	--// GUI-Elements
    ApocalypseUI.window[1] = guiCreateWindow(544, 298, 327, 150, "Redfield Apocalypse", false,"nocross")

    ApocalypseUI.label[1] = guiCreateLabel(10, 28, 307, 33, "Your name: "..getPlayerName(localPlayer), false, ApocalypseUI.window[1])
    guiSetFont(ApocalypseUI.label[1], "default-bold-small")
    guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "center", false)
    guiLabelSetVerticalAlign(ApocalypseUI.label[1], "center")
    ApocalypseUI.label[2] = guiCreateLabel(10, 71, 107, 27, "Password:", false, ApocalypseUI.window[1])
    guiSetFont(ApocalypseUI.label[2], "default-bold-small")
    guiLabelSetHorizontalAlign(ApocalypseUI.label[2], "center", false)
    guiLabelSetVerticalAlign(ApocalypseUI.label[2], "center")
    ApocalypseUI.button[1] = guiCreateButton(10, 108, 307, 32, type, false, ApocalypseUI.window[1])
    guiSetProperty(ApocalypseUI.button[1], "NormalTextColour", "FFAAAAAA")
    ApocalypseUI.edit[1] = guiCreateEdit(127, 71, 190, 27, "", false, ApocalypseUI.window[1])
	guiEditSetMasked(ApocalypseUI.edit[1],true)
	setWindowDatas("set")

	addEventHandler("onClientGUIClick",ApocalypseUI.button[1],function()
		local password = guiGetText(ApocalypseUI.edit[1])
		if(#password >= 1)then
			triggerServerEvent("RegisterLogin.server",localPlayer,guiGetText(ApocalypseUI.button[1]),password)
		end
	end,false)
end)

addEvent("RegisterLogin.destroySound",true)
addEventHandler("RegisterLogin.destroySound",root,function()
	if(isElement(RegisterLogin.sound))then
		destroyElement(RegisterLogin.sound)
	end
end)