Savezones = {zone = {}, radarArea = {},
	["AreaCoordinates"] = {
		--// x, y, width, height, name
		[1] = {-2003.8505859375,76.118301391602,60,135,"San Fierro Railway Station"},
		[2] = {-250.89590454102,2706.7004394531,60,40,"Chicken Valley"},
		[3] = {-2538.1003417969,-624.95239257813,50,30,"Missionary Hill"},
	},
}

for i,v in ipairs(Savezones["AreaCoordinates"])do
	Savezones.zone[i] = createColRectangle(v[1],v[2],v[3],v[4])
	Savezones.radarArea[i] = createRadarArea(v[1],v[2],v[3],v[4],0,255,0,100,root)
	setElementData(Savezones.zone[i],"generatorActive",true)
	
	addEventHandler("onColShapeHit",Savezones.zone[i],function(hitElement)
		if(getElementDimension(hitElement) == 0)then
			setElementData(hitElement,"savezone",1)
			setElementData(hitElement,"SavezoneID",i)
			if(getElementData(hitElement,"zombie") and getElementData(hitElement,"zombie") == true)then
				if(getElementData(source,"generatorActive") == true)then
					killPed(hitElement)
				end
			end
		end
	end)
	
	addEventHandler("onColShapeLeave",Savezones.zone[i],function(hitElement)
		setElementData(hitElement,"savezone",0)
	end)
end