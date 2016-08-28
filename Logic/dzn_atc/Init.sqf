// AIR TAXI!!
if (isDedicated || !hasInterface) exitWith {};

//	************** DZN_AirTaxiCall PARAMETERS ******************

// Condition of initialization
#define	dzn_atc_CONDITION_BEFORE_INIT	true


dzn_atc_onlyLeader 		= 		false;	// Allow AirTaxi for leaders only
dzn_atc_needLeaderApprove	=		true;
dzn_atc_exitPoint			= 		getMarkerPos "atcExitPoint"; //[ 6688, 14431, 46];
	// Pos3d of vehicle exit point (where to vehicles will fly from player). It can be an object - use (getPosASL OBJECT) instead

dzn_atc_useCustomPlacement	=		true; 	// Allow players to choose spawn point of vehicle directly on the map
dzn_atc_customPlacementMinDist =		700; 		// Minimum distance from player position to nearest position for custom placement
dzn_atc_customRestrictedLocs	=		[]; 		// List of locations restricted to spawn vehicles
dzn_atc_placementPoint		=		[getMarkerPos "atcExitPoint" select 0, getMarkerPos "atcExitPoint" select 1, 50];
	// Pos3d of vehicle spawn point, if custom placement isn't chosen
dzn_atc_placementPointMarker 	=		true;		// Place marker of Initial Point for ATC

dzn_atc_vehiclesList		= [
							"B_Heli_Light_01_F"
							,"RHS_UH60M_d"
							,"RHS_UH60M_MEV2_d"
							,"CUP_O_UH1H_TKA"
							,"CUP_O_Mi17_TK"
							,"CUP_O_Mi24_D_TK"
							
							/*
							,"LOP_TKA_Mi8MT_Cargo"
							,'LOP_TKA_Mi24V_AT'
							*/
];

dzn_atc_pilotsPerSide 		= [
							"rhsusf_army_ocp_helipilot"	// West
							,"O_helipilot_F"	// East
							,"I_helipilot_F"	// Indep
							,"C_man_pilot_F"	// Civilian
];

// Custom pilot gear code to execute: _this = unit 
dzn_atc_useCustomerPilotGear		=	false;
dzn_atc_customPilotsGear 		= 	{};

//	************** END OF DZN_AirTaxiCall PARAMETERS ******************
//
//
//
//
//
//
//	**************	INITIALIZATION 	*************************
//	
waitUntil { dzn_atc_CONDITION_BEFORE_INIT };

// Initialization of dzn_atc
call compile preProcessFileLineNumbers "Logic\dzn_atc\dzn_atc_functions.sqf";
// call compile preProcessFileLineNumbers "Logic\dzn_atc\dzn_atc_menus.sqf";

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
