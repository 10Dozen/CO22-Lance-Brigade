#define DEBUG       false

/*
	BRIEF GUIDE TO
		TASK MANAGER: REQUESTER

	Player acces Task Request menu via ACE Self-interaction key.
	Once Radio-HQ selected and No active tasks are present -- Task Request menu appears, where player can select
		task type and range from base.
		Then TM search for task of given type in selected range via exec of Task\Position.sqf file, which return list of tasks in range.
		Random one will be selected if exist, or task creation will be cancelled if there is none.

		Once task was found -- task become created. Check Task Manager: Manager for more details about task generation.

	If Radio-HQ was selected while active task exists -- Task Result menu will be displayed and player will be able to finish current task.
		On clicking 'OK' current active task will be finished with selected result, task become inactive and Task Manager becomes reset.
*/




dzn_fnc_TaskManager_getRangeLimit = {
	[dzn_TaskManager_ranges, _this] call dzn_fnc_getValueByKey
};

dzn_fnc_TaskManager_requestTask = {
	// If NO Active Task -- show select task dialog
	// If Active task exist already -- show AAR task dialog

	if !("active" call dzn_fnc_TaskManager_getProperty) then {
		player sideChat "1'6, this is 1'1, requesting new mission. Over.";
		private _taskList = [];
		{
			_taskList pushBack (_x select 1 select 0);
		} forEach dzn_TaskManager_availableTasks;

		private _dialogResult =	[
			"HQ - Request Task",
			[
				["Task", _taskList]
				,["Location", ["All", "Near", "Medium", "Far"]]
			]
		] call dzn_fnc_ShowChooseDialog;
		if (count _dialogResult == 0) exitWith { player sideChat "1'6, this is 1'1, cancel. Out."; };
		_dialogResult call dzn_fnc_TaskManager_selectTask;
	} else {
		player sideChat "1'6, this is 1'1, reporting mission result. Over.";
		private _dialogResult =	[
			"HQ - Report Task Result",
			[
				["Task", [ ("info" call dzn_fnc_TaskManager_getProperty) select 0 ]]
				,["Result", TaskManager_ResultList]
				,["Allied forces", []]
				,["Hostile forces", []]
				,["Notes", []]
			]
		] call dzn_fnc_ShowChooseDialog;
		if (count _dialogResult == 0) exitWith { player sideChat "1'6, this is 1'1, cancel. Out."; };
		_dialogResult call dzn_fnc_TaskManager_endTask;
	};
};

dzn_fnc_TaskManager_selectByRangeType = {
	// [@Position1, @Position2, @RangeType] call dzn_fnc_selectByRangeType
	params["_pos1","_pos2","_rangeType"];
	private _distance = _pos1 distance2D _pos2;

	switch (_rangeType) do {
		case 0: { true };
		case 1: {
			_distance <= (1 call dzn_fnc_TaskManager_getRangeLimit)
		};
		case 2: {
			_distance >= (1 call dzn_fnc_TaskManager_getRangeLimit)
			&& _distance <= (2 call dzn_fnc_TaskManager_getRangeLimit)
		};
		case 3: {
			_distance >= (2 call dzn_fnc_TaskManager_getRangeLimit)
		};
		default { false };
	};
};

dzn_fnc_TaskManager_selectTask = {
	// ["TaskType", "RangeCategory"] call dzn_fnc_selectTask;
	params["_type","_rangeType"];
	private _taskFolder = (_type call dzn_fnc_TaskManager_getTaskById) select 1;
	private _tasksInRange = (_rangeType) call compile preprocessFileLineNumbers format [
		"Logic\taskManager\%1\Positions.sqf"
		, _taskFolder
	];

	if (DEBUG) then { player sideChat format ["selectTask: @Type = %1; @InRange = %2.", _type, _tasksInRange]; };

	if (_tasksInRange isEqualTo []) exitWith { [west, "HQ"] sideChat "This is 1-6, We have no missions in your area. Out." };

	if (DEBUG) then { player sideChat format ["selectTask: Selected"]; };

	[_type, selectRandom _tasksInRange] call dzn_fnc_TaskManager_create;
};

dzn_fnc_TaskManager_endTask = {
	// [ 0, @ResultID, @AlliedForces Text, @HostileForces Text, @Notes Text ] call dzn_fnc_TaskManager_endTask

	/*
	    TaskManager_CompleteReport = [
	        @TaskID
	        , @TaskTitle
	        , @TaskDesc
	        , @ResultID
	        , @AlliedForces Text
	        , @HostileForces Text
	        , @Notes Text
		]
    */
    params["_z","_resultID","_alliedForcesText","_hostileForcesText","_notesText"];

	TaskManager_CompleteReport = [
		"task" call dzn_fnc_TaskManager_getProperty
		, ("info" call dzn_fnc_TaskManager_getProperty) select 0
		, ("info" call dzn_fnc_TaskManager_getProperty) select 1
		, _resultID
		, _alliedForcesText
		, _hostileForcesText
		, _notesText
	];

	TaskManager_CompleteReport call dzn_fnc_TaskManager_report;
	publicVariable "TaskManager_CompleteReport";

	TaskManager_FullReportList pushBack TaskManager_CompleteReport;
	publicVariable "TaskManager_FullReportList";

	// Reset 'dzn_taskManager' entity
	missionNamespace setVariable ["dzn_taskManager", [ false, nil, nil, nil, nil, nil ], true];

	TaskManager_NewTask = false;
	publicVariableServer "TaskManager_NewTask";
};