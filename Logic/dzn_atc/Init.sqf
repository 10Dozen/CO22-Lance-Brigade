// AIR TAXI!!
if (isDedicated || !hasInterface) exitWith {};
#define	dzn_atc_CONDITION_BEFORE_INIT	true


//	**************	INITIALIZATION 	*************************
//	
waitUntil { dzn_atc_CONDITION_BEFORE_INIT };

// Initialization of dzn_atc
call compile preprocessFileLineNumbers "Logic\dzn_atc\Settings.sqf";
call compile preprocessFileLineNumbers "Logic\dzn_atc\Functions.sqf";


// ************** Start of DZN_ATC ********************

if (dzn_atc_onlyLeader) then {
	if (player == leader (group player)) then {
		["dzn_radioServices_atc_action", "Evac Service", { showCommandingMenu "#USER:dzn_atc_menu";}, {true}] call dzn_fnc_addRadioService;
	};
} else {
	if (dzn_atc_needLeaderApprove) then {
		player setVariable ["atcRequested", false, true];
		player setVariable ["atcRequestBy", objNull, true];
		player setVariable ['atcRequestAccepted', false];
		
		// Leader requests loop
		["ATC_Leader_Menu_Check", "onEachFrame", {
			if (player == (leader player) && {player getVariable "atcRequested"} ) then {		
				[] call dzn_atc_fnc_showRequestMenu;
			};
		}] call BIS_fnc_addStackedEventHandler;
		
		// Player accepted loops
		["ATC_Request_Check", "onEachFrame", {
			if (player getVariable "atcRequestAccepted") then {
				[] call dzn_atc_showVehicleMenu;
				player setVariable ['atcRequestAccepted', false];
			};
		}] call BIS_fnc_addStackedEventHandler;
		
		["dzn_radioServices_atc_action", "Evac Service", { 
			[] call dzn_atc_callFromAction;
		}, {true}] call dzn_fnc_addRadioService;
	} else {
		["dzn_radioServices_atc_action", "Evac Service", { showCommandingMenu "#USER:dzn_atc_menu";}, {true}] call dzn_fnc_addRadioService;
	};
};


if (!dzn_atc_useCustomPlacement && dzn_atc_placementPointMarker) then {call dzn_atc_fnc_showIPMarker;};

["dzn_atc_checkMenu", "onEachFrame", {		
	if !isNil {player getVariable "dzn_atc_called"} then {
		(player getVariable "dzn_atc_called") call dzn_atc_fnc_callAirTaxi;
		player setVariable ["dzn_atc_called", nil];	
	};
	
	if (vehicle player != player && (vehicle player) getVariable ["dzn_atc_clearOut", false]) then {
		player allowDamage false;
		moveOut player;
		[] spawn { sleep 2; player allowDamage true; };
	};
}] call BIS_fnc_addStackedEventHandler;
