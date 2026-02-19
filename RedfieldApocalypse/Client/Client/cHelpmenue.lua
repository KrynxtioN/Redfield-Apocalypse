Helpmenue = {
	["Categorys"] = {"Clicksystem","Bonuspoints","Protection Zones","Weapon Stores","Zombies","Levelsystem","Team","Premium","Achievements","Vehicles","Commands","Houses"},
	["Texts"] = {
		["Clicksystem"] = "With the key 'M' you can switch the cursor on and off again. You can use the cursor to click on Peds.",
		["Bonuspoints"] = "If you eliminate a zombie, there is the possibility (1:10) that he drop a bonuspoint. You can collect them and spent them on skins an Coins. How many bonuspoints you already have, you can see in your inventory under 'I'.",
		["Protection Zones"] = "The green zones visible on the map and radar are protected areas where you are safe from the onslaught of zombies. In addition, there are vehicles and a weapons shop in all protected areas. In the main protection zone at the station are still several Peds, where one finds information and shops.",
		["Weapon Stores"] = "In each protection zone there is a weapon shop with a large selection of weapons. However, one does not have direct access to all weapons. When certain levels are reached, more weapons are unlocked.",
		["Zombies"] = "Near a player can spawn up to 100 zombies, which should be killed if you do not want to die. By killing a zombie you get 25$ and five experience points.",
		["Levelsystem"] = "By Killing a zombie you get five experience points. As soon as you have gained enough experience points, you get a higher level. How many experience points you currently have and how many you still need to the next level, you can see in the top right of your HUD. You need your own level + 1 (*250) experience points for a level up.",
		["Team"] = "In the main protection zone at the station, you have the opportunity to create your own team for 50.000$, which gives you some advantages. With a team you have the opportunity to buy his a small base as well as team vehicles. In addition, you get two experience points when a teammate shoots a zombie nearby.",
		["Premium"] = "Premium can be purchased in our Coinshop. With an active premium-status you will get the following benefits:\n\n- You get 10 instead 5 experience points for killing a zombie.\n- You get 50$ instead 25$ for killing a zombie.\n-Every full hour you get a payday, where you get money and experience points. There's also a little chance that you getting a coin.\n- Each weapon you collect has twice that amount of ammo.\n- Your weapons will be saved, when you leave the server.\n- You skill your weapons faster.\n- Teleport to other savezones.",
		["Achievements"] = "Under F3 you can open the Achievement-Panel, where you find all available achievements and there tasks. For each achievement you get a trophy, which gives you 25 experience points on your payday.",
		["Vehicles"] = "/lock - Lock / unlock your vehicle\n/park - Park your vehicle\nF5 - All your vehicles",
		["Commands"] = "/pay - Give money to another player\n/news - News (if there are available news)",
		["Houses"] = "The red houses on the map are buyable houses. If your team owns a house, you spawn at it. With a sale you get back 75% of the purchase price.",
		["Safes"] = "At the dice on the map you can open safes if you have a key. There's a 1 in 100 chance that a key will drop when you kill a zombie.",
	},
}

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