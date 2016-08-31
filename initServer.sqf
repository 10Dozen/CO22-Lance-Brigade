// Base Vehicles
[] execVM "Logic\baseVehicles\Init.sqf";

// Arsenal
[] execVM "Logic\inventory\Init.sqf";

[] spawn {
	// Date Params
	private _date = [2017, 3, 10];
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
    [] execVM "Logic\weather\Init.sqf";
};

if (hasInterface) exitWith {};

// Misc Functions
[] execVM "Logic\commonScripts\Init.sqf";

// Rally points
[] execVM "Logic\rallypoint\Init.sqf";

// Interactives
[] execVM "Logic\interactives\Init.sqf";

// Task Manager
[] execVM "Logic\taskManager\Init.sqf";