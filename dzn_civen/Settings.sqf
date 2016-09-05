/*
	Timers
*/
dzn_civen_InitTime				=	.1; // seconds after mission start
dzn_civen_LicationInitTimeout			=	.01;
dzn_civen_LocationActivateTimeout		=	.01;
dzn_civen_UnitSpawnTimeout			= 	.01;
dzn_civen_ParkedSpawnTimeout			=	.01;

/*
 *	Town Civils
 */
dzn_civen_allowCivils			= true; 
dzn_civen_enableIdleAnimation		= false;
dzn_civen_behavior_walkStandChance 	= [	
						20 /* % Go to Random house */	
						, 70 /* % Go to Random point */
						, 20 /* % Stand on current pos */
					];

// Seconds too return from DANGER to SAFE behavior
dzn_civen_enableUnsafeBehaviour	=	true;
dzn_civen_cooldownTimer			= 	30;
/*
	Civil Control
*/
dzn_civen_enableCivilControl		= true;


/*
 *	Town Parked Vehicles
 */
 
dzn_civen_allowParkedVehicles				= true;
dzn_civen_parked_forceAmountPerLocation		= false;	// Is qunatity of parked vehicles calculated according to population of area?
dzn_civen_parked_forceAmountLimit			= [5,5]; // Min and max amount of parked vehicles per location
 
// Parked vehicles global settings (values will be randomized from 0 to given max value, if ther is no vehoicleType specific)

dzn_civen_parked_gFuelMaxForced			=	false;
dzn_civen_parked_gLockedChanceForced	=	false;
dzn_civen_parked_gDamageForced			=	false;

dzn_civen_parked_gFuelMax 				= 	0.7;
dzn_civen_parked_gLockedChance			=	0.5;
dzn_civen_parked_gDamage				=	0.3;




/*
 * 	Traffic
 */
dzn_civen_allowTraffic				=	false;
dzn_civen_trafficMaxAmount          =   8;
dzn_civen_trafficPerLocation		=	1;
dzn_civen_trafficVehicleType		=	["NogovaVehicles"];	// Array of vehicle types (will be randomly chosed)
