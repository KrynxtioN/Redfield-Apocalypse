Levelsystem = {pointsPerLevel = 250}

function Levelsystem.giveExperiencePoints(player,points)
	if(isLoggedIn(player))then
		setElementData(player,"ExperiencePoints",getElementData(player,"ExperiencePoints")+points)
		local level = getElementData(player,"Level")+1
		if(tonumber(getElementData(player,"ExperiencePoints")) >= tonumber(level*Levelsystem.pointsPerLevel))then
			Levelsystem.levelUp(player)
		end
	end
end

function Levelsystem.nearbyTeammates(player)
	for _,v in pairs(getElementsByType("player"))do
		if(getPlayerName(v) ~= getPlayerName(player))then
			if(getElementData(v,"Team") and tonumber(getElementData(v,"Team")) >= 1)then
				if(tonumber(getElementData(v,"Team")) == tonumber(getElementData(player,"Team")))then
					local x,y,z = getElementPosition(v)
					if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player)) <= 15)then
						Levelsystem.giveExperiencePoints(v,2)
					end
				end
			end
		end
	end
end

function Levelsystem.levelUp(player)
	setElementData(player,"ExperiencePoints",0)
	setElementData(player,"Level",getElementData(player,"Level")+1)
end