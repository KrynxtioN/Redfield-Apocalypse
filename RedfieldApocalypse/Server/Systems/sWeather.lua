Weather = {id = nil}

function Weather.change()
	local weather = math.random(0,18)
	setWeather(weather)
	Weather.id = weather
	setTimer(Weather.change,3600000,1)
end
Weather.change()

function Weather.set(player)
	triggerClientEvent(player,"Weather.set",player,Weather.id)
end