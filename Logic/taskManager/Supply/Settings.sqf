private ["_taskID", "_taskSafetyReward", "_taskDisplayName", "_taskDesc", "_taskGroups", "_taskZonesProperties"];

/* *********************************
 * TASK SETTINGS
 * ********************************* */

_taskDisplayName        = "Supply %1-%2";
_taskDesc               = "Supply insecured town %1 from %2 supply point.";

_taskID                 = "task_Supply_%1";
_taskSafetyReward       = 300;


/* *********************************
 * TASK PRESETS
 * ********************************* */

/*
	Format:
	[
		@Route Name (String)
		, @RouteID
		, @Start Point (Pos3d)
		, @Route WPs List (Array)
		, @Route Ambushes (Array)
		, @Route Blocks (Array)
		, @EndPoint Items (Array of Pos3d)
	]

	Where:
		@Route WPs List (Array)
		[
			[
				@WP Name (String)
				, @WP Position (Pos3d)
			]
			, ...
		]

		@Route Ambushes (Array)
		[
			[ @composition array ]
			, ...
		]

		@Route Blocks (Array)
		[
			[ @composition array ]
			, ...
		]


*/

#define     NOGOVA_CARS             "CUP_C_Skoda_Blue_CIV", "CUP_C_Skoda_Green_CIV", "CUP_O_UAZ_Unarmed_SLA", "CUP_C_Skoda_Red_CIV", "CUP_C_Skoda_White_CIV", "CUP_C_Datsun", "CUP_C_Datsun_4seat", "CUP_C_Datsun_Covered", "CUP_C_Datsun_Plain"
#define     NOGOVA_TRUCKS           "CUP_C_Ural_Civ_01", "CUP_C_Ural_Open_Civ_01", "CUP_C_Ural_Civ_03", "CUP_C_Ural_Open_Civ_03", "CUP_C_Ural_Open_Civ_02", "CUP_C_Ural_Civ_02", "C_Truck_02_transport_F", "C_Truck_02_covered_F", "CUP_C_LR_Transport_CTK", "CUP_C_V3S_Open_TKC", "CUP_C_V3S_Covered_TKC", "CUP_C_UAZ_Unarmed_TK_CIV"
#define     GET_NOGOVA_CARS         selectRandom [NOGOVA_CARS]
#define     GET_NOGOVA_TRUCKS       selectRandom [NOGOVA_TRUCKS]
#define     GET_NOGOVA_VEHS         selectRandom [NOGOVA_CARS, NOGOVA_TRUCKS]
#define     SET_VEH_KIT             [_this, "kit_nogova_veh_empty", true] call dzn_fnc_gear_assignKit

private _routesAndPresets = [
	[
		0
		, [
			[ "Modrava", "Mokropsy" ]
			, [
				["FUP",[1291.28,9618.08,0]]
				,["WP1",[2413.61,9751.87,0]]
				,["WP2",[4865.32,10057.4,0]]
				,["WP3",[5468.05,9353.82,0]]
				,["END",[5460.74,9450.4,0]]
			]
			, [
				[[4110.46,10197.7,0],[4105.29,10209,0],[3962.89,10278.6,0],[3974.41,10277.7,0],[4104.46,10222.2,0]]
				, [[3559.45,10124.8,0],[3574.43,10118.7,0],[3576.15,10105,0],[3736.54,10037.2,0],[3733.81,10045.9,0],[3730.54,10052.6,0]]
				, [[3045.73,10068.6,-0.148392],[3061.94,10075.8,0],[3081.21,10076.3,0],[2981.37,10117.4,0],[2988.49,10111.5,0]]
				, [[2567.23,9610.53,0],[2577.02,9613.35,0],[2588.33,9614.31,0.0530548],[2453.11,9741.74,0],[2435,9715.17,7.62939e-006],[2429.32,9745.85,0.03508]]
				, [[4515.31,10311.5,0],[4523.65,10308.3,0],[4534.3,10314.5,0],[4669.39,10236,0.0422058],[4638.96,10227.6,0]]
				, [[5080.93,9339.25,0],[5093.82,9341.57,0],[5115.19,9344.24,0],[5215.39,9438.57,-0.0351868],[5229.91,9435.93,-0.0418549]]
				, [[4983.62,10115.5,0],[4995.2,10098.3,0.0415649],[4966.48,10150.4,0.0424194],[4915.4,9961.76,0.0827026],[4929.78,9968.07,0.0670776],[4911.71,9952.03,0]]
			]
			, [
				[[3217.06,10176.2,0.00143433], [[GET_NOGOVA_VEHS,19.4208,4.967,180.001,-0.033,true,{SET_VEH_KIT},true],[GET_NOGOVA_VEHS,101.993,3.29,284.99,0.005,true,{SET_VEH_KIT},true]]]
				, [[3610.38,10034.1,0.00111389], [[GET_NOGOVA_VEHS,220.185,3.583,359.997,-0.007,true,{SET_VEH_KIT},true],[GET_NOGOVA_VEHS,3.53308,2.421,224.695,-0.003,true,{SET_VEH_KIT},true]]]
				, [[4009.17,10248.1,0.000762939], [[GET_NOGOVA_VEHS,86.7894,2.65,276.701,0.043,true,{SET_VEH_KIT},true],[GET_NOGOVA_VEHS,351.767,2.106,241.725,-0.138,true,{SET_VEH_KIT},true]]]
				, []
				, []
				, []
				, [[4854.86,10027.3,0.000976563], [[GET_NOGOVA_TRUCKS,300.94,3.867,150.046,0.008,true,{SET_VEH_KIT},true]]]
			]
			, [[5461.86,9455.79,0],[5464.12,9455.5,0]]
		]
	]
];


/* *********************************
 * TASK RANDOMIZING PRESETS
 * ******************************** */
private _routePresets = [
	_routesAndPresets
	, ("pos" call dzn_fnc_TaskManager_getProperty) select 0
] call dzn_fnc_getValueByKey;


// Update task name
private _routeFrom = (_routePresets select 0) select 0;
private _routeTo = (_routePresets select 0) select 1;

_taskDisplayName = format [_taskDisplayName, _routeFrom, _routeTo];   // "Supply Town1-Town2";
_taskDesc = format [_taskDesc, _routeTo, _routeFrom]; // "Supply insecured town Town2 from Town1 supply point.";

// Get static content
private _routeWPs = _routePresets select 1;
private _routeEndPositions = _routePresets select 4;

// Randomize ambushes and carblocks
private _routeAvailableAmbushes = _routePresets select 2;
private _routeCarblocksAvailable = _routePresets select 3;

private _routeAmbushCount = if (count (_routeAvailableAmbushes) > 2) then { 1 + ceil(random (count _routeAvailableAmbushes/2)) } else { 1 };

private _routeAmbushes = [];
private _routeCarblocks = [];

for "_i" from 1 to _routeAmbushCount do {
	private _ambush = selectRandom _routeAvailableAmbushes;
	private _ambushId = _routeAvailableAmbushes find _ambush;
	private _isCarblockAvailable = !((_routeCarblocksAvailable select _ambushId) isEqualTo []);
	private _needCarblock = if (_isCarblockAvailable) then { selectRandom [true, false, false, false] } else { false };

	_routeAmbushes pushBack _ambush;
	_routeAvailableAmbushes = _routeAvailableAmbushes - [_ambush];

	if (_needCarblock) then {
		private _carblock = _routeCarblocksAvailable select _ambushId;
		_routeCarblocks pushBack _carblock;
		_routeCarblocksAvailable = _routeCarblocksAvailable - [_carblock];
	};
};

// Additional carblocks (without ambushes 20% per each to spawn
for "_i" from 0 to (count _routeCarblocksAvailable) do {
	if ( selectRandom [true, false, false, false, false] && !((_routeCarblocksAvailable select _i) isEqualTo [])) then {
        _routeCarblocks pushBack (_routeCarblocksAvailable select _i);
	};
};

/* *********************************
 * RETURN PRESETS
 * ******************************** */

[
	_taskID
	, [_taskDisplayName, _taskDesc]
	, [_routeWPs, _routeEndPositions, _routeAmbushes, _routeCarblocks]
	, [_taskSafetyReward]
]