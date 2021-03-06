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

[[1428.13,10854.3,0.00134277],[["Land_TentA_F",168.016,4.645,180,0.003,true,{},true],["Land_TentA_F",139.953,6.433,0,0.005,true,{},true],["AmmoCrates_NoInteractive_Small",74.6794,12.197,0,0.016,true,{},true],["Land_FirePlace_F",129.946,0.611,0,0.176,true,{},true],["Land_TentDome_F",91.536,8.197,330.078,0.024,true,{},true],["CUP_bedna_ammo2X",83.1997,10.499,14.908,0,true,{},true]]]
, [[3490.64,10261,0.00218964],[["CUP_bedna_ammo2X",232.488,8.141,14.935,0,true,{},true],["AmmoCrates_NoInteractive_Small",239.814,5.922,0,0.021,true,{},true],["Land_TentA_F",185.181,6.116,180,0.002,true,{},true],["Land_FirePlace_F",1.28527,0.152,0,0,true,{},true],["Land_TentDome_F",18.0079,5.044,239.922,-0.005,true,{},true],["Land_TentA_F",143.178,6.361,314.891,0.003,true,{},true]]]
, [[3739.18,8950.65,0.000579834], [["CUP_bedna_ammo2X",209.977,9.378,0,0,true,{},true],["AmmoCrates_NoInteractive_Small",215.363,8.473,345.002,0.008,true,{},true],["Land_TentA_F",172.876,9.167,164.999,0,true,{},true],["Land_TentA_F",150.382,6.219,344.999,0,true,{},true],["Land_TentDome_F",342.614,6.493,300.066,0.015,true,{},true],["Land_FirePlace_F",285.76,0.413,345.002,-0.001,true,{},true]]]
, [[4203.24,8244.27,0.00138855], [["Land_TentDome_F",319.095,6.015,240.031,-0.003,true,{},true],["Land_FirePlace_F",217.388,6.182,225,0.255,true,{},true],["CUP_bedna_ammo2X",110.395,2.158,14.999,0,true,{},true],["AmmoCrates_NoInteractive_Small",69.9354,3.578,0,0.004,true,{},true],["Land_TentA_F",165.217,3.437,90.052,0.001,true,{},true],["Land_TentA_F",353.312,1.048,225.018,0,true,{},true]]]
, [[4230.69,6335.81,0.00114441], [["CUP_bedna_ammo2X",55.83,5.077,15.014,0,true,{},true],["AmmoCrates_NoInteractive_Small",63.3602,5.524,0,-0.016,true,{},true],["Land_TentA_F",246.328,5.024,225.002,0,true,{},true],["Land_FirePlace_F",317.753,0.144,0,0.231,true,{},true],["Land_TentDome_F",85.1224,5.157,0,-0.008,true,{},true],["Land_TentA_F",191.501,4.077,0,0,true,{},true]]]
, [[5080.55,9188.62,0.00189209], [["CUP_bedna_ammo2X",226.397,7.505,14.904,0,true,{},true],["AmmoCrates_NoInteractive_Small",231.743,5.052,0,0.026,true,{},true],["Land_TentA_F",204.394,6.411,224.676,0.004,true,{},true],["Land_FirePlace_F",137.541,0.74,0,0.175,true,{},true],["Land_TentDome_F",251.833,3.79,239.642,-0.005,true,{},true],["Land_TentA_F",164.516,5.458,150.344,0.007,true,{},true]]]
, [[5465.07,10540.3,0.0020752], [["CUP_bedna_ammo2X",182.966,7.294,269.814,0,true,{},true],["AmmoCrates_NoInteractive_Small",202.061,7.018,255.202,-0.03,true,{},true],["Land_TentA_F",222.078,5.377,59.995,0.009,true,{},true],["Land_TentA_F",170.732,5.254,0,0.011,true,{},true],["Land_FirePlace_F",206.305,0.866,0,0.001,true,{},true],["Land_TentA_F",266.775,4.288,89.317,0.007,true,{},true]]]
, [[6658.49,8933.32,0.00161743], [["cwa_Radio",14.3538,3.077,45,0.497,true,{},true],["AmmoCrates_NoInteractive_Small",289.164,4.757,0,-0.015,true,{},true],["Land_TentA_F",243.321,4.267,225.15,0.003,true,{},true],["Land_TentA_F",195.56,4.738,225.15,0.003,true,{},true],["Land_FirePlace_F",143.12,1.129,0,0,true,{},true],["Land_TentDome_F",319.875,3.226,240.102,0.015,true,{},true],["CUP_bedna_ammo2X",264.922,5.804,15.048,0,true,{},true]]]
, [[7946.68,10126.2,0.00119019], [["CUP_bedna_ammo2X",278.627,7.916,14.96,0,true,{},true],["AmmoCrates_NoInteractive_Small",296.017,7.22,0,0.01,true,{},true],["Land_TentA_F",201.254,4.624,224.9,0.001,true,{},true],["Land_FirePlace_F",79.2103,0.485,0,0,true,{},true],["Land_TentDome_F",324.335,5.443,239.878,-0.009,true,{},true],["Land_TentA_F",162.445,7.016,0,0.002,true,{},true]]]
, [[7753.78,9362.45,0.00146484], [["AmmoCrates_NoInteractive_Small",291.702,5.823,0,0.2,true,{},true],["CUP_bedna_ammo2X",271.475,6.751,15.003,0,true,{},true],["Land_TentA_F",217.515,5.343,195.032,0.001,true,{},true],["Land_FirePlace_F",350.352,0.396,0,0.141,true,{},true],["Land_TentDome_F",321.419,4.959,240.195,-0.01,true,{},true],["Land_TentA_F",164.525,6.573,0,0.001,true,{},true]]]
, [[8648.73,8467.1,-0.000457764], [["AmmoCrates_NoInteractive_Small",228.047,7.276,0,-0.023,true,{},true],["Land_FirePlace_F",35.4699,0.096,0,0,true,{},true],["Land_TentDome_F",221.632,4.795,120.577,-0.037,true,{},true],["CUP_bedna_ammo2X",224.605,9.612,15.272,0,true,{},true],["Land_TentA_F",52.813,3.952,60.955,0.01,true,{},true],["Land_TentA_F",59.8688,8.622,149.945,0.012,true,{},true]]]
, [[8546.54,7949.65,0.000900269], [["Land_FirePlace_F",213.93,0.842,0,0,true,{},true],["CUP_bedna_ammo2X",336.502,5.354,45.839,0,true,{},true],["AmmoCrates_NoInteractive_Small",0.140937,5.955,30.361,-0.03,true,{},true],["Land_TentA_F",19.3561,4.476,61.119,0.014,true,{},true],["Land_TentDome_F",114.521,6.306,330.644,0.075,true,{},true],["Land_TentA_F",75.1887,3.66,61.18,0.016,true,{},true]]]
, [[9508.58,8134.75,0.00134277], [["CUP_bedna_ammo2X",338.23,9.705,165.076,0,true,{},true],["AmmoCrates_NoInteractive_Small",339.192,7.953,150.097,-0.019,true,{},true],["Land_TentA_F",352.574,7.344,44.685,0.005,true,{},true],["Land_FirePlace_F",349.333,0.58,0,0,true,{},true],["Land_TentDome_F",290.788,4.408,89.717,0.01,true,{},true],["Land_TentA_F",21.2236,5.7,254.651,0.004,true,{},true]]]
, [[9560.51,7806.92,0.00137329], [["CUP_bedna_ammo2X",120.514,6.062,180,0,true,{},true],["AmmoCrates_NoInteractive_Small",140.226,6.944,165.002,-0.016,true,{},true],["Land_TentA_F",309.709,4.467,299.93,0.001,true,{},true],["Land_FirePlace_F",25.3606,1.475,165,0.222,true,{},true],["Land_TentDome_F",143.35,3.809,44.864,0.023,true,{},true],["Land_TentA_F",3.88201,6.52,164.972,0.001,true,{},true]]]
, [[7521.56,6659.21,0.00138855], [["CUP_bedna_ammo2X",96.9358,9.336,195.007,0,true,{},true],["AmmoCrates_NoInteractive_Small",111.396,8.517,180,0.002,true,{},true],["Land_TentA_F",20.3292,8.992,44.975,0.001,true,{},true],["Land_FirePlace_F",91.886,0.964,180,0,true,{},true],["Land_TentDome_F",133.386,6.35,60.004,-0.001,true,{},true],["Land_TentA_F",351.421,7.964,180,0,true,{},true]]]
, [[6488.79,5697.85,0.00118256], [["Land_TentA_F",140.981,5.441,120.308,0.004,true,{},true],["Land_FirePlace_F",72.501,0.794,0,-0.001,true,{},true],["Land_TentA_F",159.304,8.161,90.14,0.004,true,{},true],["AmmoCrates_NoInteractive_Small",342.433,6.976,0,0.114,true,{},true],["Land_TentDome_F",8.69855,7.997,239.808,-0.011,true,{},true],["CUP_bedna_ammo2X",337.716,5.456,14.981,0,true,{},true]]]
, [[5681.72,6685.15,0.00169373], [["CUP_bedna_ammo2X",29.1777,7.152,135.06,0,true,{},true],["AmmoCrates_NoInteractive_Small",32.9796,4.98,120.381,0.04,true,{},true],["Land_TentA_F",297.021,4.746,285.115,0.005,true,{},true],["Land_FirePlace_F",169.465,0.51,120.214,0.001,true,{},true],["Land_TentDome_F",66.657,3.916,315.253,-0.022,true,{},true],["Land_TentA_F",201.337,5.428,239.765,0.006,true,{},true]]]
, [[5600.79,6036.01,0.000339508], [["Land_TentA_F",196.152,6.944,180,0.006,true,{},true],["Land_TentDome_F",315.886,6.228,209.934,0.019,true,{},true],["CUP_bedna_ammo2X",337.879,5.634,14.965,0,true,{},true],["AmmoCrates_NoInteractive_Small",353.791,7.241,0,0,true,{},true],["Land_FirePlace_F",305.113,0.322,0,0.287,true,{},true],["Land_TentA_F",171.409,5.364,0,0.005,true,{},true]]]
, [[6090.62,4566.99,0.00176239], [["CUP_bedna_ammo2X",297.692,7.353,14.874,0,true,{},true],["AmmoCrates_NoInteractive_Small",306.139,6.021,0,0.023,true,{},true],["Land_TentA_F",162.302,5.705,90.033,0.004,true,{},true],["Land_FirePlace_F",252.228,0.507,0,0.308,true,{},true],["Land_TentDome_F",354.764,6.538,269.728,0.001,true,{},true],["Land_TentA_F",183.952,7.984,90.096,0.004,true,{},true]]]

];


// *********************************
GET_POSITION;