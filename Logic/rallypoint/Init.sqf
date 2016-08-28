call compile preProcessFileLineNumbers "Logic\rallypoint\Settings.sqf";
call compile preProcessFileLineNumbers "Logic\rallypoint\Functions.sqf";

if (isServer) then {
	RallyPoint_Position = dzn_rp_RallyPointPosition;
	publicVariable "RallyPoint_Position";
	
	rpObject = createVehicle  ["Sign_DangerMines_ACR", RallyPoint_Position, [], 0, "NONE"];
	rpObject enableSimulation false;
	
	// Move Rallypoint
	"RallyPoint_Position" addPublicVariableEventHandler {
		rpObject setPos RallyPoint_Position;
	};	
};

if !(hasInterface) exitWith {};

// CREATE BASE AREA
rpAllowedAreas = [];
{
	rpAllowedAreas pushBack ([_x, false] call dzn_fnc_convertTriggerToLocation);
} forEach dzn_rp_freeDeploymentAreas;

// SET UP MENU CHECKER
[] spawn {
	player setVariable ["rpRequested", false, true];
	player setVariable ["rpRequestBy", objNull, true];
	player setVariable ['rpRequestAccepted', false];
	
	// Leader requests loop
	["Rallypoint_Leader_Menu_Check", "onEachFrame", {
		if (player == (leader player) && {player getVariable "rpRequested"} ) then {		
			[] call dzn_fnc_rp_showRequestMenu;
		};		
	}] call BIS_fnc_addStackedEventHandler;
	
	// Player accepted loops
	["Rallypoint_Request_Check", "onEachFrame", {
		if (player getVariable "rpRequestAccepted") then {
			RallyPoint_Position spawn dzn_fnc_rp_safeMove;
			player setVariable ['rpRequestAccepted', false];
		};		
	}] call BIS_fnc_addStackedEventHandler;
};

// Add SELF-INTERACTION actions
waitUntil { !isNil "dzn_fnc_addRallypointAction" };

rp_action = [ "dzn_rp_action", "Rallypoint", "", { }, {true}]  call ace_interact_menu_fnc_createAction; 
[typeOf player, 1, [ "ACE_SelfActions" ], rp_action ] call ace_interact_menu_fnc_addActionToClass;

["dzn_rp_action_moveTo", "Move To RP", { call dzn_fnc_rp_moveToRallypoint }, {true}] call dzn_fnc_addRallypointAction;
["dzn_rp_action_set", "Set Rallypoint", { call dzn_fnc_rp_setRallypoint }, {player == (leader player)}] call dzn_fnc_addRallypointAction;
