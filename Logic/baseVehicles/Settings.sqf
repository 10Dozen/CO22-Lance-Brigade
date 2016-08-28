/*
	Place GameLogic 'baseVehiclesCore' and sync several GameLogics named 'vehType#', 
		where # - vehicle type number as position in 'baseVehicles_types' array
		
	'baseVehicles_types' is a list of vehicles types that will be spawned;
	Format:
		[ @Class, @Kit, @Ace_Wheels, (opt)@TFAR_IsolatedAmount ]
*/

baseVehicles_types = [
	[ "CUP_C_SUV_CIV", "kit_sec_veh_unarmed", 1  ]
	,[ "CUP_B_LR_Transport_GB_W", "kit_sec_veh_unarmed", 1  ]

	,[ "rhs_tigr_sts_3camo_vv", "kit_sec_veh_armed", 1  ]
	,[ "rhs_tigr_m_3camo_vv", "kit_sec_veh_armed", 1  ]

	,[ "CUP_B_LR_Special_M2_GB_W", "kit_sec_veh_armed", 2, 0.1  ]
	,[ "CUP_B_LR_Special_GMG_GB_W", "kit_sec_veh_armed", 2, 0.1  ]

	,[ "RHS_Ural_Zu23_MSV_01", "kit_sec_veh_unarmed", 1  ]
];

baseVehicles_respawnable = true;
baseVehicles_TFAR_defaultIsolatedAmount = 0.5;
