/*
    [ @ServerExec ] execVM "task.sqf";

	// Specific parameters for Supply task
	[
    	_taskID
    	, [_taskDisplayName, _taskDesc]
    	, [_routeWPs, _routeEndPositions, _routeAmbushes, _routeCarblocks]
    	, [_taskSafetyReward]
    ]

	"active"        - true
	"task"          - task_Supply_14124
	"type"          - 3
	"pos"           - [ @RouteID, @Pos3d]
	"presets"       - [ @RouteWPs, @routeEndPositions, @routeAmbushes, @routeCarblocks]
	"info"          - [ @FormattedDisplayName, @FormattedDesc]
	"misc"          - [ @SafetyReward ]
*/

#define DEBUG       false


params ["_serverExec"];

if (DEBUG) then {  player sideChat format ["Task: @ServerExec: %1", _serverExec] };

// *********************************************
// TASK Server Init (called from Task Generator)
// *********************************************
if (_serverExec) exitWith {
	/*
 	 *	Initialize Task entity
	 */

	private _taskID = "task" call dzn_fnc_TaskManager_getProperty;
	private _taskSide = west;

	private _taskPos = ("pos" call dzn_fnc_TaskManager_getProperty) select 1;
	private _taskLocation = [_taskPos, 15] call dzn_fnc_task_createTaskSimpleLocation;

	private _taskRouteWPs = ("presets" call dzn_fnc_TaskManager_getProperty) select 0;
	private _taskRouteEndPoses = ("presets" call dzn_fnc_TaskManager_getProperty) select 1;
	private _taskRouteAmbushes = ("presets" call dzn_fnc_TaskManager_getProperty) select 2;
	private _taskRouteCarblocks = ("presets" call dzn_fnc_TaskManager_getProperty) select 3;

	private _taskReward = ("misc" call dzn_fnc_TaskManager_getProperty) select 0;

	private _taskTitle = ("info" call dzn_fnc_TaskManager_getProperty) select 0;
	private _taskDesc = ("info" call dzn_fnc_TaskManager_getProperty) select 1;

	if (DEBUG) then { player setPos _taskPos; };
	[_taskID, _taskLocation, _taskTitle, _taskDesc, _taskSide] spawn dzn_fnc_task_create;

	/*
     *	Task Logic
     */

     // Draw Markers
     TaskMarkers = [];
     {
		TaskMarkers pushBack (
			[
			    format ["mrk_supply_%1_%2", _taskID, _forEachIndex]
			    , _x select 1
			    , "hd_dot"
			    , "ColorBlack"
			    , _x select 0
			    , false
			] call dzn_fnc_createMarkerIcon
		);
     } forEach _taskRouteWPs;

	[] spawn {
		waitUntil { !("active" call dzn_fnc_TaskManager_getProperty) };
		{
			deleteMarker _x;
		} forEach TaskMarkers;
	};

	// Spawn Suppy truck
	private _supplyVeh = [
		[_taskRouteWPs select 0 select 1, 0]
		, "C_Truck_02_covered_F"
		, "kit_nogova_veh_empty"
	] call dzn_fnc_createVehicle;

	{
		private _oClass = _x select 0;
		{
			private _o = _oClass createVehicle [0,0,0];
			_o attachTo [_supplyVeh, _x];
		} forEach (_x select 1);
	} forEach [
		["Land_WoodenCrate_01_F", [[.8,0,-0.2], [-0.8,0,-0.2], [0,0,-0.2], [0.8,0,0.2], [-0.8,0,0.2], [0,0,0.2]]]
    	, ["Land_MetalCase_01_large_F" , [[0.8,-2,-0.2]]]
    	, ["Barrels", [[-0.2,-2,-0.15]]]
	];

	// Spawn Endpoint fellows ["C_man_hunter_1_F"], ["kit_che_civ"]
	private _grp = createGroup civilian;
	{
		private _u = _grp createUnit ["C_man_hunter_1_F", _x, [], 0, "FORM"];
		[_u, format ["kit_che_civ_supplyOwner%1", _forEachIndex + 1],false] call dzn_fnc_gear_assignKit;

		_u doWatch ((_u nearRoads 10) select 0);	
		_u setSkill 0;
		_u disableAI "ALL";
	} forEach _taskRouteEndPoses;

	// Spawn Ambushes
	{
		private _grpAmbush = createGroup east;
		_grpAmbush setBehaviour "AWARE";
		_grpAmbush setCombatMode "RED";
		
		private _ambushPositions = _x;		
		
		{
			private _u = _grpAmbush createUnit ["O_Soldier_F", _x, [], 0, "NONE"];

			[_u, if (_forEachIndex == 3) then { "kit_ins_mg" } else { "kit_ins_random" },false] call dzn_fnc_gear_assignKit;

			_u setSkill 1;
			_u setUnitPos "DOWN";
		} forEach _ambushPositions;
	} forEach _taskRouteAmbushes;	

	// Spawn carblocks
	private _carBlockObjects = [];
	{
		_carBlockObjects pushBack (
			[[_x select 0, 0], _x select 1] call dzn_fnc_setComposition
		);
	} forEach _taskRouteCarblocks;

	
	[ _taskId, "objects", _carBlockObjects ] call dzn_fnc_task_setProperty;
};

// *******************************************************
// TASK Client Init (called from Player's Task Listener)
// *******************************************************

if (DEBUG) then {};
