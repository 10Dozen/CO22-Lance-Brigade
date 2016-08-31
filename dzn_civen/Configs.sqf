//  **************** SETTINGS - MAPPINGS ********************

/*
 *	Locations
 *
 *	[ @Location (typeOf object or roleDescription), [ @CivilianType, @CivilianAmount, @VehicleType, @VehicleAmount ] ]
 *	@Location 	- (string) classname or role description of the game logic
 *	@CivilianType	- (string) name of the dzn_civen_civilianTypes item
 *	@CivilianAmount	- [] to use GameLogic settings, or [min,max] to get random
 *	@VehicleType	- (string) name of the dzn_civen_vehicleTypes item
 *	@VehicleAmount	- (number) amount of parked vehicles per 1 location's civilian (e.g. 0.3 means that there will be 1 car per each 3 civilians)
 *				or (array) in format [min, max] of vehicles per 1 location (e.g. [1,5] means that there will be spawned random from 1 to 5 cars, no matter how many civilians in location)
 */
 
dzn_civen_locationSettings = [
	[
		"LocationCity_F",		["NogovaCivil", [1,1], "NogovaVehicles", [1,1]]
	]
	,[ 
		"LocationVillage_F",	["NogovaCivil", [1,1], "NogovaVehicles", [0,1]]
	]
];







/*
 *	Civilians
 *
 *	[ @CivilianTypename, [ @Classnames, @dzn_gear Kits, @Custom code to execute ] ]
 *	@CivilianTypename	- (string) name of the type
 *	@Classnames		- (array) list of the classnames for civilians units
 *	@dzn_gear Kits		- (array) list of the dzn_gear kits that will be applied randomly to spawned units
 *	@Custom code to execute	- (code) code that whill be executed once civilian unit was spawned (use _this as refernece to unit itself)
 */
dzn_civen_civilianTypes = [
	[
		"NogovaCivil"		, [["C_man_hunter_1_F"], ["kit_che_civ"], { }]
	]
];






/*
 *	Vehicles
 *
 *	[ @VehicleType, [ @Classnames, @dzn_gear Cargo kit, @Custom code to execute, @Fuel-Locked-Damage random] ]
 *	@VehicleType		- (string) name of the type
 *	@Classnames		- (array) list of the classnames for vehicles
 *	@dzn_gear Cargo Kits	- (array) list of the dzn_gear cargo kits that will be applied randomly to spawned vehicles
 *	@Custom code to execute	- (code) code that whill be executed once vehicle was spawned (use _this as refernece to vehicle itself)
 *	@Fuel-Locked-Damage random	- (nil) or (array) in format [Max.fuel, Max.locked chance, Max.damage]. 
 *						Random fuel, locked chance and damage will be applied to vehicle on spawn. 
 *						If nil - global settings will be used.
 *				
 */
#define     NOGOVA_CARS    "CUP_C_Skoda_Blue_CIV", "CUP_C_Skoda_Green_CIV", "CUP_O_UAZ_Unarmed_SLA", "CUP_C_Skoda_Red_CIV", "CUP_C_Skoda_White_CIV", "CUP_C_Datsun", "CUP_C_Datsun_4seat", "CUP_C_Datsun_Covered", "CUP_C_Datsun_Plain"
#define     NOGOVATRUCKS  "CUP_C_Ural_Civ_01", "CUP_C_Ural_Open_Civ_01", "CUP_C_Ural_Civ_03", "CUP_C_Ural_Open_Civ_03", "CUP_C_Ural_Open_Civ_02", "CUP_C_Ural_Civ_02", "C_Truck_02_transport_F", "C_Truck_02_covered_F", "CUP_C_LR_Transport_CTK", "CUP_C_V3S_Open_TKC", "CUP_C_V3S_Covered_TKC", "CUP_C_UAZ_Unarmed_TK_CIV"
dzn_civen_vehicleTypes = [
	[
		"NogovaVehicles"
		, [
			[
				NOGOVA_CARS
				, NOGOVA_CARS
				, NOGOVATRUCKS
			]	/* ClassNames */ 
			, ["kit_nogova_veh_empty"]				/* Kits */
			, { }				/* Code to execute */
			, [.5,.5,.2]			/* Fuel,Locked Chance,Damage, nil - if used global */
		]
	]
];
