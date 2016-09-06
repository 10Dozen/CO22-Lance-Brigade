/*
    [ @ServerExec ] execVM "task.sqf";

	// Specific parameters for SAD Cache task
	"active"        - true
	"task"          - task_SADCache_14124
	"type"          - 0
	"pos"           - [ @Pos3d, @Radius]
	"presets"       - [ @DynaiGroups[] , @DynaiZonesProperties[] ]
	"info"          - [ @DisplayName, @Desc]
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

	private _taskPos = ("pos" call dzn_fnc_TaskManager_getProperty) select 0;
	private _taskRadius =  ("pos" call dzn_fnc_TaskManager_getProperty) select 1;
	private _taskLocation = [_taskPos, _taskRadius] call dzn_fnc_task_createTaskSimpleLocation;

	private _taskGroups = ("presets" call dzn_fnc_TaskManager_getProperty) select 0;
	private _taskZonesProperties = ("presets" call dzn_fnc_TaskManager_getProperty) select 1;

	private _taskReward = ("misc" call dzn_fnc_TaskManager_getProperty) select 0;

	private _taskTitle = format [
		("info" call dzn_fnc_TaskManager_getProperty) select 0
		, ([_taskPos, 200] call dzn_fnc_getDisplayTaskPos) call dzn_fnc_getMapGrid_Nogova
	];
	private _taskDesc = format [
		("info" call dzn_fnc_TaskManager_getProperty) select 1
		, ([_taskPos, 200] call dzn_fnc_getDisplayTaskPos)  call dzn_fnc_getMapGrid_Nogova
	];

	if (DEBUG) then { player setPos _taskPos; };
	[_taskID, _taskLocation, _taskTitle, _taskDesc, _taskSide] spawn dzn_fnc_task_create;

	/*
     *	Task Logic
     */
	private _cacheObjectClass = "Box_FIA_Support_F";

	// 1. Get nearest houses
	private _buildings = [_taskPos, _taskRadius, ["House"], []] call dzn_fnc_getHousesNear;

	if (_buildings isEqualTo []) exitWith { hint "NO HOUSES. CANCELLED" };

	// 2. Select buildingPos
	// 2.1. Select building with position
	private _enterableBuildings = [
		_buildings
		, { [_x] call BIS_fnc_isBuildingEnterable }
	] call BIS_fnc_conditionalSelect;

	// 2.2. Get buildingPos
	private _taskBuilding = _enterableBuildings call BIS_fnc_selectRandom;

	// 2.3. Spawn crate
	private _cacheObject = _cacheObjectClass createVehicle (_taskPos);
	_cacheObject allowDamage false;

	// 3. Place crate at building pos
	[_cacheObject, [_taskBuilding], nil, nil, false] spawn dzn_fnc_assignInBuilding;
	_cacheObject spawn { sleep 5; _this allowDamage true; };

	[ _taskID, "objects", [_cacheObject] ] call dzn_fnc_task_setProperty;

	// 4. Spawn thread - waitUntil { !alive crate };
	// 5. Spawn general task thread - waitUntil { taskEnd };
	// 6. Add Dynai zone:
	{
		private _zoneSide = _x select 0;
		private _zoneWP = _x select 1;
		private _zoneBehavior = _x select 2;

		[
			format["%1_%2", _taskId, _forEachIndex]
			, _zoneSide
			, true
			, [_taskLocation]
			, _zoneWP
			, (_taskGroups select _forEachIndex)
			, _zoneBehavior
		] call dzn_fnc_dynai_addNewZone;
	} forEach _taskZonesProperties;
};

// *******************************************************
// TASK Client Init (called from Player's Task Listener)
// *******************************************************
if (DEBUG) then {};
