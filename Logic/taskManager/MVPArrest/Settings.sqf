private ["_taskID", "_taskSafetyReward", "_taskDisplayName", "_taskDesc", "_taskGroups", "_taskZonesProperties"];

/* *********************************
 * TASK SETTINGS
 * ********************************* */

_taskDisplayName        = "Arrest MVP at %1";
_taskDesc               = "Find and arrest insurgent collaborator at grid %1. Return MVP to Lance camp.";

_taskID                 = "task_MVPArrest_%1";
_taskSafetyReward       = 100;

_taskPatrols            = selectRandom [true, fasle];
_taskBodyguard          = selectRandom [true, fasle];

/* *********************************
 * TASK DYNAI UNITS
 * ******************************** */
_taskGroups = [
	[
		[
			if (_taskBodyguard) then { 1 + ceil(random 1) } else { 0 }
			,	[["O_Soldier_F",["indoors"],"kit_ins_random"],["O_Soldier_F",["indoors"],"kit_ins_random"],["O_Soldier_F",["indoors"],"kit_ins_random"]]
		]
		, [
			if (_taskBodyguard) then { 1 + ceil(random 2) } else { 0 }
			, [["O_Soldier_F",[],"kit_ins_random"],["O_Soldier_F",[],"kit_ins_random"]]
		]
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