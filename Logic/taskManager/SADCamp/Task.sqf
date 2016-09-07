/*
    [ @ServerExec ] execVM "task.sqf";

	// Specific parameters for SAD Camp task
	"active"        - true
	"task"          - task_SADCache_14124
	"type"          - 0
	"pos"           - [ @Pos3d, @CompositionArray]
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
	private _taskComposition =  ("pos" call dzn_fnc_TaskManager_getProperty) select 1;
	private _taskLocation = [_taskPos, 65] call dzn_fnc_task_createTaskSimpleLocation;

	private _taskGroups = ("presets" call dzn_fnc_TaskManager_getProperty) select 0;
	private _taskZonesProperties = ("presets" call dzn_fnc_TaskManager_getProperty) select 1;

	private _taskReward = ("misc" call dzn_fnc_TaskManager_getProperty) select 0;

	private _taskDisplayPos = ([_taskPos, 200] call dzn_fnc_task_getDisplayTaskPos) call dzn_fnc_getMapGrid_Nogova;
	private _taskTitle = format [
		("info" call dzn_fnc_TaskManager_getProperty) select 0
		, _taskDisplayPos
	];
	private _taskDesc = format [
		("info" call dzn_fnc_TaskManager_getProperty) select 1
		, _taskDisplayPos
	];

	if (DEBUG) then { player setPos _taskPos; };
	[_taskID, _taskLocation, _taskTitle, _taskDesc, _taskSide] spawn dzn_fnc_task_create;

	/*
     *	Task Logic
     */
	private _taskObjects = [[_taskPos, 0], _taskComposition] call dzn_fnc_setComposition;
	[ _taskId, "objects", _taskObjects ] call dzn_fnc_task_setProperty;

	//  Add Dynai zone:
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
