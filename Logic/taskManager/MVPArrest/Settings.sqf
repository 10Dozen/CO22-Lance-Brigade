private ["_taskID", "_taskSafetyReward", "_taskDisplayName", "_taskDesc", "_taskGroups", "_taskZonesProperties"];

/* *********************************
 * TASK SETTINGS
 * ********************************* */

_taskDisplayName        = "Arrest MVP at %1";
_taskDesc               = "Find and arrest insurgent collaborator at grid %1. Return MVP to Lance camp.";

_taskID                 = "task_MVPArrest_%1";
_taskSafetyReward       = 100;

_taskPatrols            = selectRandom [true, fasle];
_taskBodyguard          = if (_taskPatrols) then { selectRandom [true, fasle] } else { true };

/* *********************************
 * TASK DYNAI UNITS
 * ******************************** */
#define    PATROL_UNIT          ["O_Soldier_F",[],"kit_ins_random"]
#define    BODYGYARD_UNIT       ["O_Soldier_F",["indoors"],"kit_ins_rheavy"]

private _grp = [];
if (_taskPatrols) then {
	_grp pushBack [1 + ceil(random 2), [PATROL_UNIT,PATROL_UNIT]];
};

if (_taskBodyguard) then {
	_grp pushBack [1 + ceil(random 1), [BODYGYARD_UNIT,BODYGYARD_UNIT,BODYGYARD_UNIT]];
};

_taskGroups = [_grp];

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