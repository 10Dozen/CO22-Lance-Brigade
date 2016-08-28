//	************** DZN_AirTaxiCall PARAMETERS ******************

dzn_atc_onlyLeader 			=	false;	// Allow AirTaxi for leaders only
dzn_atc_needLeaderApprove		=	true;

dzn_atc_useCustomPlacement		=	true; 	// Allow players to choose spawn point of vehicle directly on the map
dzn_atc_customPlacementMinDist 		=	700; 	// Minimum distance from player position to nearest position for custom placement
dzn_atc_customRestrictedLocs		=	[]; 	// List of locations restricted to spawn vehicles

// Pos3d of vehicle spawn point, if custom placement isn't chosen
dzn_atc_placementPoint			=	[getMarkerPos "atcExitPoint" select 0, getMarkerPos "atcExitPoint" select 1, 50];
dzn_atc_placementPointMarker 		=	true;		// Place marker of Initial Point for ATC

dzn_atc_exitPoint			=	getMarkerPos "atcExitPoint"; // Pos3d of vehicle exit point (where to vehicles will fly from player). It can be an object - use (getPosASL OBJECT) instead


dzn_atc_vehiclesList			= [
							"B_Heli_Light_01_F"
							,"RHS_UH60M_d"
							,"RHS_UH60M_MEV2_d"
							,"CUP_O_UH1H_TKA"
							,"CUP_O_Mi17_TK"
							,"CUP_O_Mi24_D_TK"
							
							/*
							,"LOP_TKA_Mi8MT_Cargo"
							,'LOP_TKA_Mi24V_AT'
							*/
];

dzn_atc_pilotsPerSide 			= [
							"B_helipilot_F"	// West
							,"O_helipilot_F"	// East
							,"I_helipilot_F"	// Indep
							,"C_man_pilot_F"	// Civilian
];

// Custom pilot gear code to execute: _this = unit 
dzn_atc_useCustomPilotGear		=	false;
dzn_atc_customPilotsGear 		= 	{ 
	waitUntil { !isNil "dzn_gear_serverInitDone" };
	[_this, "kit_atc_helipilot"] spawn dzn_fnc_gear_assignKit;
};

dzn_atc_tfar_enabledOverride		=	true;
dzn_atc_tfar_side			=	west;
