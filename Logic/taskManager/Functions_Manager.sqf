#define DEBUG       false

/*
	BRIEF GUIDE TO
		TASK MANAGER: MANAGER

	Once player selected task from Task Request menu, task will be created step by step:

	1.  Clinet: TaskType and position data (from %Task%\Positions.sqf) are set to TaskManager entity and published; server is triggered to run task
	2.  Server: Task settings are retrieved from %Task%\Settings.sqf file and set to TaskManager entity
	3.  Server: %Task%\Task (contain all task logic code) executed with @IsServerExec = true
		3.1.    All task data becomes formatted and set to Task Entity; BIS task become created;
	4.  Client: Task runned on client with @IsServerExec = false

	On finishing mission -- players report become added to list of all mission reports and all TaskManager and Task entities become reset.

*/

dzn_fnc_TaskManager_getTaskById = {
	[dzn_TaskManager_availableTasks, _this] call dzn_fnc_getValueByKey
};

/*
 *	**********************
 *  TASK MANAGER
 *	**********************
 */
dzn_fnc_TaskManager_init = {
	if (isNil "TaskManager_NewTask") then { TaskManager_NewTask = false; };
	if (isNil "TaskManager_CompleteReport") then { TaskManager_CompleteReport = [];  };
	if (isNil "TaskManager_NewTaskClient") then { TaskManager_NewTaskClient = false; };
	if (isNil "TaskManager_ResultList") then { TaskManager_ResultList = ["Completed", "Partially Completed", "Not completed", "Cancelled"]; };

	// Task Result page on JIP
	if (isNil "taskPage") then {
		taskPage = "taskPage";
		player createDiarySubject [taskPage, dzn_TaskManager_taskResultPageName];

		if (!isNil "TaskManager_FullReportList" && {!(TaskManager_FullReportList isEqualTo [])}) then {
			{
				_x call dzn_fnc_TaskManager_report;
			} forEach TaskManager_FullReportList;
		};

		"TaskManager_CompleteReport" addPublicVariableEventHandler {
			TaskManager_CompleteReport call dzn_fnc_TaskManager_report;
		};
	};

	// Task Request logic
	if (hasInterface) then {
		["hq_service", "HQ", { [] spawn dzn_fnc_TaskManager_requestTask; }, {true}] call dzn_fnc_addRadioService;
	};
	"TaskManager_NewTaskClient" addPublicVariableEventHandler {
		if (TaskManager_NewTaskClient) then {
			false call dzn_fnc_TaskManager_runTask;
			TaskManager_NewTaskClient = false;
		};
	};

	if !(isServer) exitWith {};
	TaskManager_FullReportList = [];
	publicVariable "TaskManager_FullReportList";

	// @ActiveExist, @TaskID, @Type, @Position, @Presets, @Info
	missionNamespace setVariable [
		"dzn_taskManager"
		,  [ false, nil, nil, nil, nil, nil ]
		, true
	];

	"TaskManager_NewTask" addPublicVariableEventHandler {
		if (TaskManager_NewTask) then {
			true call dzn_fnc_TaskManager_runTask;
			TaskManager_NewTaskClient = true;
			publicVariable "TaskManager_NewTaskClient";
		};
	};
};

//	**********************
dzn_fnc_TaskManager_setProperty = {
	// [@Property, @Value] call dzn_fnc_TaskManager_setProperty
	params["_prop","_val"];
	private _id = switch (toLower(_prop)) do {
		case "active": { 0 };
		case "task": { 1 };
		case "type": { 2 };
		case "pos": { 3 };
		case "presets": { 4 };
		case "info": { 5 };
		case "misc": { 6 };
	};

	(missionNamespace getVariable "dzn_taskManager") set [_id, _val];
	missionNamespace setVariable ["dzn_taskManager", missionNamespace getVariable "dzn_taskManager", true];
};

dzn_fnc_TaskManager_getProperty = {
	// @Property call dzn_fnc_TaskManager_getProperty
	params["_prop"];
	private _id = switch (toLower(_prop)) do {
		case "active": { 0 };
		case "task": { 1 };
		case "type": { 2 };
		case "pos": { 3 };
		case "presets": { 4 };
		case "info": { 5 };
		case "misc": { 6 };
	};
	(missionNamespace getVariable "dzn_taskManager") select _id
};

dzn_fnc_TaskManager_create = {
	// [@TaskType, @Position] call dzn_fnc_TaskManager_create
	params["_taskType","_taskPosition"];

	["active", true] call dzn_fnc_TaskManager_setProperty;
	["type", _taskType] call dzn_fnc_TaskManager_setProperty;
    ["pos", _taskPosition] call dzn_fnc_TaskManager_setProperty;

    if (DEBUG) then { player sideChat format ["TaskManager_create: @Type: %1, @Pos: %2", _taskType, _taskPosition] };

	// This triggers 'dzn_fnc_TaskManager_runTask' both on Server and all Clinets
	TaskManager_NewTask = true;
	publicVariableServer "TaskManager_NewTask";
};

dzn_fnc_TaskManager_runTask = {
	// @IsServerExec call dzn_fnc_TaskManager_runTask
	private _taskFolder = (("type" call dzn_fnc_TaskManager_getProperty) call dzn_fnc_TaskManager_getTaskById) select 1;
	private _taskSettings = call compile preprocessFileLineNumbers format [
		"Logic\taskManager\%1\Settings.sqf"
		, _taskFolder
	];

	if (DEBUG) then { player sideChat format ["TaskManager_runTask: @TaskSettings: %1",_taskSettings] };

	/*
		0:  TaskID template
		1:  Display info:   [ @Task DisplayName template, @Task Description template]
		2:  Dynai info:     [ @Group template, @Zone properties ]
		3:  Misc:           [ @TaskSafetyReward ]
	*/
	["task", format [ _taskSettings select 0, call dzn_fnc_task_generateGUID]] call dzn_fnc_TaskManager_setProperty;
	["info", _taskSettings select 1] call dzn_fnc_TaskManager_setProperty;
	["presets", _taskSettings select 2] call dzn_fnc_TaskManager_setProperty;
	["misc", _taskSettings select 3] call dzn_fnc_TaskManager_setProperty;

	[_this] execVM format ["Logic\taskManager\%1\Task.sqf", _taskFolder];
};

dzn_fnc_TaskManager_report = {
	/*
		[
			@TaskID
	        , @TaskTitle
	        , @TaskDesc
	        , @ResultID
	        , @AlliedForces Text
	        , @HostileForces Text
	        , @Notes Text
		] call dzn_fnc_TaskManager_report;
	*/

	params [
		"_taskID"
		, "_taskTitle"
		, "_taskDesc"
		, "_resultID"
		, "_alliedForcesText"
		, "_hostileForcesText"
		, "_notesText"
	];

	private _resultText = TaskManager_ResultList select _resultID;

	if (DEBUG) then { player sideChat format ["TaskManager_report: @Title = %1, @Desc = %2, @Result = %3", _taskTitle, _taskDesc, _resultText]};


	player createDiaryRecord [
		taskPage
		, [
			_taskTitle
			, format [
				"<font color='#A0DB65'>Task:</font> %1
				<br /><font color='#A0DB65'>Result:</font> %2
				<br />----------------------
				<br /><font color='#A0DB65'>Allied Forces:</font> %3
				<br /><font color='#A0DB65'>Hostile Forces:</font> %4
				<br />----------------------
				<br /><font color='#A0DB65'>Notes:</font><br />%5"
				,_taskDesc
				,_resultText
				,if (typeName _alliedForcesText == "STRING") then { _alliedForcesText } else { "" }
				,if (typeName _hostileForcesText == "STRING") then { _hostileForcesText } else { "" }
				,if (typeName _notesText == "STRING") then { _notesText } else { "" }
			]
		]
	];

	[
		_taskID
		, switch (_resultID) do {
			case 0: { "SUCCEEDED" };
			case 1: { "SUCCEEDED" };
			case 2: { "FAILED" };
			case 3: { "CANCELED" };
		}
		,true
	] spawn BIS_fnc_taskSetState;
};

/*
 *	**********************
 *  TASK ENTITY
 *	**********************
 */


dzn_fnc_task_createTaskSimpleLocation = {
	// @Location = [@Pos, @Radius, (@Direction), (@IsSquare)] call dzn_fnc_createTaskSimpleLocation
	private["_loc"];
	params["_pos","_size", ["_dir", 0], ["_isSquare",false]];

	_loc = createLocation ["Name", _pos, _size, _size];
	_loc setDirection _dir;
	if (_isSquare) then { _loc setRectangular true; };

	_loc
};

dzn_fnc_task_create = {
	// [@taskID, @taskLocation, @taskTitle, @taskDesc, @taskSide] spawn dzn_fnc_task_create;
	params ["_taskID", "_taskLocation", "_taskTitle", "_taskDesc", "_taskSide"];

	missionNamespace setVariable [_taskID, [ nil, nil, nil, nil, nil, nil ], true];

	[_taskID, "state", "incomplete"] call dzn_fnc_task_setProperty;
	[_taskID, "active", true] call dzn_fnc_task_setProperty;
	[_taskID, "location", _taskLocation] call dzn_fnc_task_setProperty;
	[_taskID, "objects", []] call dzn_fnc_task_setProperty;

	sleep 3;
	[ "info", [_taskTitle, _taskDesc] ] call dzn_fnc_TaskManager_setProperty;
    [_taskSide, [_taskID], [_taskDesc, _taskTitle, ""], objNull, 1, 8, true, "", true] call BIS_fnc_taskCreate;
};

dzn_fnc_task_setProperty = {
	// [@TaskId, @Property, @Value] call dzn_fnc_task_setProperty
	params["_taskId", "_prop", "_val"];
	private _id = switch (toLower(_prop)) do {
		case "state": { 0 };
		case "active": { 1 };
		case "location": { 2 };
		case "objects": { 3 };
		case "item": { 4 };
		case "dynaizone": { 5 };
	};

	(missionNamespace getVariable _taskId) set [_id, _val];
	missionNamespace setVariable [_taskId, missionNamespace getVariable _taskId, true];
};
dzn_fnc_task_getProperty = {
	// [@TaskId, @Property] call dzn_fnc_task_getProperty
	params["_taskId", "_prop"];
	private _id = switch (toLower(_prop)) do {
		case "state": { 0 };
		case "active": { 1 };
		case "location": { 2 };
		case "objects": { 3 };
		case "item": { 4 };
		case "dynaizone": { 5 };
	};

	(missionNamespace getVariable _taskId) select _id
};

dzn_fnc_task_generateGUID = {
	private ["_i","_guid"];
	_guid = "";
	for "_i" from 0 to 6 do {
		_guid = format ["%1%2", _guid, floor(random 9)];
	};

	_guid
};



/*
 *	**********************
 *  Other Functions
 *	**********************
 */

dzn_fnc_task_getDisplayTaskPos = {
	// @RandomizedPos3d = [@Pos3d or @Pos2d, @RandomizeRange] call dzn_fnc_getDisplayTaskPos
	params[ "_pos", "_range" ];

	[
		(_pos select 0) + round(random(_range)) - round(random(_range))
		, (_pos select 1) + round(random(_range)) - round(random(_range))
		,0
	]
};