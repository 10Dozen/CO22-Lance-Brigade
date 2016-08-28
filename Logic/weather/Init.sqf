call compile preprocessFileLineNumbers "Logic\weather\Settings.sqf";
call compile preprocessFileLineNumbers "Logic\weather\Functions.sqf";

if (hasInterface && !isServer) exitWith {
	if (isNil "PublicWeather") then { PublicWeather = []; };
	waitUntil { time > 0 };
	"PublicWeather" addPublicVariableEventHandler {
		PublicWeather call dzn_fnc_weather_change;
	};
};

[] spawn dzn_fnc_weather_changeLoop;