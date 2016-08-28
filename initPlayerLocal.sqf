// TFAR disable radio
tf_no_auto_long_range_radio = true;

// Radio Services (ACE Self-interaction actions)
call compile preProcessFileLineNumbers "Logic\radioServices\Init.sqf";

// Air Taxi
[] execVM "Logic\dzn_atc\Init.sqf";

// Misc Functions
[] execVM "Logic\commonScripts\Init.sqf";

// Rally points
[] execVM "Logic\rallypoint\Init.sqf";

// Service Point
[] execVM "Logic\servicePoint\Init.sqf";

// Utilities
[] execVM "Logic\utilities\Init.sqf";

// Weather
[] execVM "Logic\weather\Init.sqf";

// Holy Bless
[] execVM "Logic\holyBless\Init.sqf";


// Gear save/set on using arsenal
[] spawn {
	saveGearOnArsenalClose_opened = false;
	["saveGearOnArsenalClose", "onEachFrame", {
		if !(saveGearOnArsenalClose_opened) then {
			if !(isNull ( uinamespace getVariable "RSCDisplayArsenal" )) then {
				saveGearOnArsenalClose_opened = true;
			};
		} else {
			if (isNull ( uinamespace getVariable "RSCDisplayArsenal" )) then {
				saveGearOnArsenalClose_opened = false;
				player setVariable ["dzn_gear_kit", player call dzn_fnc_gear_getGear];
			};
		};
	}] call BIS_fnc_addStackedEventHandler;
};

// Intro
[] spawn {
	waitUntil { time > 0 };
	1000 cutText ["","BLACK",0.01];
	1001 cutText ["DEPLOYMENT IN PROGRESS","BLACK",0];
	sleep 3; 1001 cutText ["Signing of a contract","BLACK",0];
	sleep 3; 1001 cutText ["Medical insurance registration","BLACK",0];
	sleep 3; 1001 cutText ["WELCOME TO CROATIA", "BLACK OUT",1];
	sleep 5; 1000 cutText ["", "BLACK IN",1]; 1001 cutText ["", "BLACK IN",1];
};