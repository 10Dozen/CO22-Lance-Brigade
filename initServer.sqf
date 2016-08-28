[] execVM "Logic\baseVehicles\Init.sqf";

[] spawn {
	waitUntil { !isNil "arsenalBox1" };
	// arsenalBox1 execVM "Logic\inventory\createWhiteListedArsenal.sqf";
};

[] spawn {
	// Date Params
	private _date = date;
	private _time = "par_daytime" call BIS_fnc_getParamValue;
	setDate [
		_date select 0
		, _date select 1
		, _date select 2
		, if (_time == 0) then { floor(random 23) } else { _time }
		, 0
	];

	// Weather Params
	("par_weather" call BIS_fnc_getParamValue) call dzn_fnc_setWeather;

	// Dynamic Weather
	waitUntil { time > 0 };
	// [] execVM "Logic\weather\weatherConditions.sqf";
};
