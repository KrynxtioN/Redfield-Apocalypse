Helpmenue = {
	["Categorys"] = {"Clicksystem","Bonuspoints","Protection Zones","Weapon Stores","Zombies","Levelsystem","Team","Premium","Achievements","Vehicles","Commands","Houses"},
	["Texts"] = {
		["Clicksystem"] = "Press 'M' to toggle your cursor on or off. You can use the cursor to interact with NPCs and other clickable elements.",
		["Bonuspoints"] = "When you kill a zombie, there is a 1 in 10 chance that it will drop a bonus point. Bonus points can be collected and spent on skins and coins. You can check your current bonus points in your inventory by pressing 'I'.",
		["Protection Zones"] = "The green zones shown on the map and radar are protected areas where you are safe from zombies. Each protection zone provides access to vehicles and a weapon shop. The main protection zone at the station also contains several NPCs that provide information and access to additional shops.",
		["Weapon Stores"] = "Each protection zone has a weapon shop offering a variety of weapons. Not all weapons are available from the beginning. Additional weapons are unlocked as you reach higher levels.",
		["Zombies"] = "Up to 100 zombies can spawn near a player. Killing a zombie rewards you with $25 and 5 experience points. Be careful not to get overwhelmed by large groups of zombies.",
		["Levelsystem"] = "Killing a zombie rewards you with 5 experience points. Once you have earned enough experience, you will level up. Your current experience and the amount required for your next level are displayed in the top-right corner of your HUD. The experience required for a level up is calculated as (your current level + 1) × 250.",
		["Team"] = "You can create your own team for $50,000 in the main protection zone at the station. Being part of a team provides several benefits, including the ability to purchase a team base and team vehicles. You also receive 2 experience points whenever a nearby teammate kills a zombie.",
		["Premium"] = "Premium can be purchased from the Coin Shop. While Premium is active, you receive the following benefits:\n\n- 10 experience points instead of 5 for killing a zombie.\n- $50 instead of $25 for killing a zombie.\n- A payday every full hour, rewarding you with money and experience points, with a small chance of receiving a coin.\n- Weapons you collect contain twice as much ammunition.\n- Your weapons are saved when you leave the server.\n- Your weapon skills increase faster.\n- You can teleport to other protection zones.",
		["Achievements"] = "Press 'F3' to open the Achievement Panel, where you can view all available achievements and their requirements. Each completed achievement rewards you with a trophy. Every trophy grants you an additional 25 experience points during your payday.",
		["Vehicles"] = "You can purchase vehicles from dealerships located throughout the map. Dealerships are marked with a vehicle icon on the map. Once you have purchased a vehicle, you can manage it through the vehicle menu by pressing 'F5'.\n\n/lock - Lock or unlock your vehicle\n/park - Save your vehicle's current parking position\nF5 - Open your vehicle list",
		["Commands"] = "/pay - Give money to another player\n/news - View the latest available news\n/admins - View all admins currently online\n/admincommands - View the commands available for your admin rank (admins only)\n/createhouse - Create a house pickup (admins only)",
		["Houses"] = "Green house icons on the map indicate properties that can be purchased. If your team owns a house, you can spawn there. When selling a house, you receive 75% of its original purchase price.",
		["Safes"] = "Safes are marked with a dice icon on the map and can be opened if you have a key. Every zombie you kill has a 1 in 100 chance of dropping a safe key.",
	},
}

local pickupPosition = Vector3(-1979.94140625, 137.90785217285, 27.6875)
local helpPickup = createPickup(pickupPosition.x, pickupPosition.y, pickupPosition.z, 3, 1239)
local maxDistance = 20
local helpText = "For help open the F1 menu."

addEventHandler("onClientRender", root, function()
	if(isWindowOpen())then
		if not isElement(helpPickup) then return end

		local playerPosition = Vector3(getElementPosition(localPlayer))
		local distance = getDistanceBetweenPoints3D(
			playerPosition.x, playerPosition.y, playerPosition.z,
			pickupPosition.x, pickupPosition.y, pickupPosition.z
		)

		if distance > maxDistance then return end

		local screenX, screenY = getScreenFromWorldPosition(
			pickupPosition.x,
			pickupPosition.y,
			pickupPosition.z + 1
		)

		if not screenX or not screenY then return end

		local alpha = 255 * (1 - distance / maxDistance)

		dxDrawText(
			helpText,
			screenX - 250, screenY - 20,
			screenX + 250, screenY + 20,
			tocolor(255, 255, 255, alpha),
			1.2,
			"default-bold",
			"center", "center",
			false, false, false, true
		)
	end
end)

bindKey("f1","down",function()
	if(isWindowOpen())then
        ApocalypseUI.window[1] = guiCreateWindow(459, 212, 508, 350, "Helpmenue", false)

        ApocalypseUI.gridlist[1] = guiCreateGridList(10, 27, 193, 313, false, ApocalypseUI.window[1])
        category = guiGridListAddColumn(ApocalypseUI.gridlist[1], "Category", 0.9)
        ApocalypseUI.label[1] = guiCreateLabel(213, 27, 285, 313, "", false, ApocalypseUI.window[1])
        guiSetFont(ApocalypseUI.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(ApocalypseUI.label[1], "left", true)
		setWindowDatas("set")
		
		for _,v in pairs(Helpmenue["Categorys"])do
			local row = guiGridListAddRow(ApocalypseUI.gridlist[1])
			guiGridListSetItemText(ApocalypseUI.gridlist[1],row,category,v,false,false)
		end
		
		addEventHandler("onClientGUIClick",ApocalypseUI.gridlist[1],function()
			local text = getItemFromGridlist(ApocalypseUI.gridlist[1],1)
			if(text ~= "")then
				guiSetText(ApocalypseUI.label[1],Helpmenue["Texts"][text])
			end
		end,false)
	end
end)
