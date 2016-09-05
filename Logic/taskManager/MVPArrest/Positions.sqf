/*
	@List of available positions = @Range call Positions.sqf
*/
#define POSITION_ELEMENT    _x select 0
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
	[[6557.29,4183.23,-7.62939e-006],100]
    , [[5755.91,4014.87,0.0119171],100]
    , [[5058.46,3887.84,-7.62939e-006],100]
    , [[4571.57,5081.47,-7.62939e-006],100]
    , [[4836.92,4715.4,-0.00541687],100]
    , [[5615.39,4341.62,-0.0547714],100]
    , [[7538.16,3770.62,-7.62939e-006],100]
    , [[7259.76,4083.44,-7.62939e-006],100]
    , [[7024.93,4166.48,-0.00900269],100]
    , [[7681.02,4412.48,-0.000452042],100]
    , [[6742.14,5056.76,-0.0141296],100]
    , [[5809.73,5136.81,-7.62939e-006],100]
    , [[5444.99,4757.49,0.0120773],100]
    , [[5296.29,5498.28,-0.0209785],100]
    , [[6730.19,6138.45,-7.62939e-006],100]
    , [[6839.17,5557.58,-7.62939e-006],100]
    , [[8073.03,7073.96,-0.061039],100]
    , [[6826.96,6800.87,0.00165558],100]
    , [[6217.12,7375.25,-7.62939e-006],100]
    , [[5834.66,8737.03,-7.62939e-006],100]
    , [[5924.83,8475.13,0.000289917],100]
    , [[5562.57,8477.08,0.00137329],100]
    , [[5536.74,9448.31,-0.00323486],100]
    , [[3925.52,7121.33,-7.62939e-006],100]
    , [[2944.21,7385.22,-0.00509644],100]
    , [[3272.64,7838.71,0],100]
    , [[2702.1,8586.47,-0.0121918],100]
    , [[2439.03,9739.08,0.0301895],100]
    , [[1675.2,11297.3,-0.0105515],100]
    , [[8049.13,9410.09,0],100]
    , [[11073.8,11565.7,0.0626526],100]
    , [[11151.7,7686.96,-1.52588e-005],100]
    , [[9553.05,8286.5,0],100]
    , [[8857.58,7886,0.000564575],100]
    , [[9782.48,6942.6,0.0162964],100]
    , [[8971.56,5474.24,-7.62939e-006],100]
    , [[9378.49,2758.28,-0.00449371],100]
    , [[10658.7,1747.67,-7.62939e-006],100]
    , [[10383.6,758.942,-7.62939e-006],100]
    , [[11526.3,2226.47,-7.62939e-006],100]
    , [[10606.6,3808.55,0],100]
    , [[10442.8,4103.59,-7.62939e-006],100]
    , [[11165.7,5384.79,0.00748444],100]
    , [[10850.1,5393.91,-0.0152206],100]
    , [[10425.8,5378.92,0.00241852],100]
    , [[9168.09,4970.85,0],100]
];




// *********************************
GET_POSITION;