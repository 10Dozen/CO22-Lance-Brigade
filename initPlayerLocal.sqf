// TFAR disable radio
tf_no_auto_long_range_radio = true;

// Radio Services (ACE Self-interaction actions)
call compile preProcessFileLineNumbers "Logic\radioServices\Init.sqf";

// Air Taxi
[] execVM "Logic\dzn_atc\Init.sqf";

// Misc Functions
[] execVM "Logic\commonScripts\Init.sqf";

// Rally points
[] execVM "Logic\rallypoint\rallypointSystem.sqf";




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

	/*
	waitUntil { !isNil "ServiceZone" };
	["servicePoint", "onEachFrame", {
		if (vehicle player == player) exitWith {};

		if ((getPosASL player) in ServiceZone) then {
			(vehicle player) spawn dzn_fnc_serviceVehicle;
		};
	}] call BIS_fnc_addStackedEventHandler;
	*/

	waitUntil { !isNil "Chapel" };
	Chapel addAction [
		"<t color='#FFE240' size='1.5'>Pray the God</t>",{
			[player,player] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
			[] spawn {
				1000 cutText ["","WHITE OUT",0.3];
				sleep 1;
				1000 cutText ["","WHITE IN",1];
				hint parseText "<t color='#FFE240' size='2'>You feel the blessing</t>";
			};
		},"",6,true,true,"","_this distance2d _target < 1.6"
	];
};

[] spawn {
	waitUntil { time > 0 };
	1000 cutText ["","BLACK",0.01];
	1001 cutText ["DEPLOYMENT IN PROGRESS","BLACK",0];
	sleep 3; 1001 cutText ["Signing of a contract","BLACK",0];
	sleep 3; 1001 cutText ["Medical insurance registration","BLACK",0];
	sleep 3; 1001 cutText ["WELCOME TO CROATIA", "BLACK OUT",1];
	sleep 5; 1000 cutText ["", "BLACK IN",1]; 1001 cutText ["", "BLACK IN",1];
};

// [] execVM "Logic\utilities\utilities.sqf";

// Weather Controller
/*
[] spawn {
	waitUntil { time > 0 };
	[] execVM "Logic\weather\weatherConditions.sqf";
};
*/
