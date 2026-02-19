addEvent("Weather.set",true)
addEventHandler("Weather.set",root,function(id)
	setWeather(tonumber(id))
end)