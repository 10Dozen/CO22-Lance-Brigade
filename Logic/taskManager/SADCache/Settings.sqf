private ["_taskID", "_taskSafetyReward", "_taskDisplayName", "_taskDesc", "_taskGroups", "_taskZonesProperties"];

/* *********************************
 * TASK SETTINGS
 * ********************************* */

_taskDisplayName        = "Weapon cache at %1";
_taskDesc               = "Find and destroy enemy weapon cache at grid %1.";

_taskID                 = "task_SADCache_%1";
_taskSafetyReward       = 100;

/* *********************************
 * TASK DYNAI UNITS
 * ******************************** */
_taskGroups = [
	[
		[1 + ceil(random 2),	[["O_Soldier_F",["indoors"],"kit_ins_random"],["O_Soldier_F",["indoors"],"kit_ins_random"],["O_Soldier_F",["indoors"],"kit_ins_random"]]]
		, [2 + ceil(random 4), [["O_Soldier_F",[],"kit_ins_random"],["O_Soldier_F",[],"kit_ins_random"]]]
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