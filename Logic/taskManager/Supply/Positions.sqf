/*
	@List of available positions = @Range call Positions.sqf
*/
#define POSITION_ELEMENT    _x select 1
#define CHECK_POSITIONS     [_pos, POSITION_ELEMENT, _rangeType] call dzn_fnc_TaskManager_selectByRangeType
#define GET_POSITION        [call dzn_TaskManager_taskRequestPosition, _this, _positions] call _returnPositions

private _returnPositions = {
	params["_pos","_rangeType","_positions"];
	private _result = [];
	{ if (CHECK_POSITIONS) then { _result pushBack _x; }; } forEach _positions;
	_result
};

// *********************************
// TASK AVAILABLE PLACES
// *********************************

private _positions = [
	[0, [1302.22,9620.6,0]]
];

// *********************************
GET_POSITION;