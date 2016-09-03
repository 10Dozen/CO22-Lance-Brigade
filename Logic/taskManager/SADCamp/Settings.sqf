private ["_taskID", "_taskSafetyReward", "_taskDisplayName", "_taskDesc", "_taskGroups", "_taskZonesProperties"];

/* *********************************
 * TASK SETTINGS
 * ********************************* */

_taskDisplayName        = "Insurgents camp at %1";
_taskDesc               = "Find and secure enemy camp site at grid %1.";

_taskID                 = "task_SADCamp_%1";
_taskSafetyReward       = 300;

/* *********************************
 * TASK DYNAI UNITS
 * ******************************** */
_taskGroups = [
	[
		[2 + ceil(random 4), [["O_Soldier_F",[],"kit_ins_random"],["O_Soldier_F",[],"kit_ins_random"]]]
	]
];

_taskZonesProperties = [
	["EAST", "randomize", ["LIMITED","SAFE","YELLOW","STAG COLUMN"]]
];



/* *********************************
 * RETURN PRESETS
 * ******************************** */

[
	_taskID
	, [_taskDisplayName, _taskDesc]
	, [_taskGroups, _taskZonesProperties]
	, [_taskSafetyReward]
]