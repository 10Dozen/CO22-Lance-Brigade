dzn_fnc_weather_change = {
	// [Settings, Time] call dzn_fnc_changeWeather

	(_this select 1) setOvercast ((_this select 0) select 1);
	(_this select 1) setRain ((_this select 0) select 1);
};

// Server-Side
dzn_fnc_weather_changeLoop = {
	private _sleepTime = dzn_weather_sleepTimeAverage
	    + round(random (dzn_weather_sleepTimeAverage/3))
	    - round(random (dzn_weather_sleepTimeAverage/3));

	// Change weather
	PublicWeather = [
		dzn_weather_settings call BIS_fnc_selectRandom
		, round(random 120)
	];
	PublicWeather call dzn_fnc_weather_change;
	publicVariable "PublicWeather";

	// Change wind
	setWind [
		random(15) - random(15)
		, random(15) - random(15)
		, true
	];

	_sleepTime spawn {
		sleep _this;
		[] spawn dzn_fnc_weather_changeLoop;
	};
};

