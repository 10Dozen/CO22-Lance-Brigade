// ***********************************
// Gear Kits 
// ***********************************

// ******** USEFUL MACROSES *******
// Maros for Empty weapon
#define EMPTYKIT	[["","","","",""],["","","","",""],["","","","",""],["","","","",""],[],[["",0],["",0],["",0],["",0],["",0],["",0],["",0],["",0],["",0]],[["",0],["",0],["",0],["",0],["",0],["",0]],[]]
// Macros for Empty weapon
#define EMPTYWEAPON	"","",["","","",""]
// Macros for the list of items to be chosen randomly
#define RANDOM_ITEM	["H_HelmetB_grass","H_HelmetB"]
// Macros to give the item only if daytime is in given inerval (e.g. to give NVGoggles only at night)
#define NIGHT_ITEM(X)	if (daytime < 9 || daytime > 18) then { X } else { "" }

/*
	Lance
*/
kit_lance_default  =
	[
	["<EQUIPEMENT >>  ","TRYK_U_B_OD_OD_R_CombatUniform","CUP_V_I_RACS_Carrier_Vest_wdl","","rhsusf_ach_bare_wood_headset",""],
	["<PRIMARY WEAPON >>  ","","",["","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",5],["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_quikclot",5],["ACE_CableTie",2],["ACE_Flashlight_XL50",1],["ACE_EarPlugs",1]]],
	["<VEST ITEMS >> ",[]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_lance_pilot =
	[
	["<EQUIPEMENT >>  ","TRYK_U_B_OD_OD_R_CombatUniform","TRYK_V_Bulletproof_BLK","TRYK_B_Belt_GR","rhs_gssh18","TRYK_Shemagh_shade_G"],
	["<PRIMARY WEAPON >>  ","","",["","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","rhsusf_weap_glock17g4","rhsusf_mag_17Rnd_9x19_JHP",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","ACE_NVG_Gen2"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",5],["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_quikclot",5],["ACE_CableTie",2],["ACE_Flashlight_XL50",1],["ACE_EarPlugs",1]]],
   	["<VEST ITEMS >> ",[]],
	["<BACKPACK ITEMS >> ",[["HANDGUN MAG",6],["SmokeShellBlue",2],["SmokeShellPurple",2],["rhs_mag_m67",2],["rhs_mag_nspn_red",2]]]
];

kit_sec_veh_unarmed = [
	[],
	[["Chemlight_red",10],["B_IR_Grenade",2],["SmokeShellBlue",2],["SmokeShellRed",2],["SmokeShellYellow",2]],
	[["ACE_fieldDressing",20],["ACE_packingBandage",10],["ACE_elasticBandage",10],["ACE_tourniquet",5],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_quikclot",10],["ACE_CableTie",10],["ACE_EarPlugs",6]],
	[]
];

kit_sec_veh_armed = [
	[["rhs_weap_aks74un",1],["rhs_weap_rshg2",2]],
	[["Chemlight_red",10],["B_IR_Grenade",2],["SmokeShellBlue",2],["SmokeShellRed",2],["SmokeShellYellow",2],["rhs_30Rnd_545x39_AK",10],["rhs_30Rnd_762x39mm",10],["rhs_VOG25P",10],["rhs_mag_M433_HEDP",10],["30Rnd_556x45_Stanag",10]],
	[["ACE_fieldDressing",20],["ACE_packingBandage",10],["ACE_elasticBandage",10],["ACE_tourniquet",5],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_quikclot",10],["ACE_CableTie",10],["ACE_EarPlugs",6]],
    []
];


/*
	Local Millitary
*/
#define	CRO_UNI	"rhs_uniform_g3_m81","CUP_V_B_Interceptor_Rifleman","","TRYK_H_Helmet_WOOD",["rhs_googles_black", "rhs_googles_yellow","","","",""]

kit_croatian_random = [
	"kit_croatian_r"
	,"kit_croatian_r"
	,"kit_croatian_r"
	,"kit_croatian_gl"
	,"kit_croatian_gl"
	,"kit_croatian_mg"
];

kit_croatian_r =
	[
	["<EQUIPEMENT >>  ", CRO_UNI],
	["<PRIMARY WEAPON >>  ","rhs_weap_akms","rhs_30Rnd_762x39mm",["","rhs_acc_2dpZenit","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","CUP_NVG_PVS7"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",5],["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_quikclot",5],["ACE_CableTie",2],["ACE_Flashlight_XL50",1],["ACE_EarPlugs",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",6],["rhs_mag_an_m8hc",1],["CUP_HandGrenade_RGD5",1]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_croatian_gl =
	[
	["<EQUIPEMENT >>  ",CRO_UNI],
	["<PRIMARY WEAPON >>  ","rhs_weap_akms_gp25","rhs_30Rnd_762x39mm",["","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","CUP_NVG_PVS7"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",5],["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_quikclot",5],["ACE_CableTie",2],["ACE_Flashlight_XL50",1],["ACE_EarPlugs",1]]],
	["<VEST ITEMS >> ",[["rhs_mag_an_m8hc",1],["rhs_VOG25P",6],["PRIMARY MAG",5]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_croatian_mg =
	[
	["<EQUIPEMENT >>  ",CRO_UNI],
	["<PRIMARY WEAPON >>  ","rhs_weap_pkm","rhs_100Rnd_762x54mmR",["","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","CUP_NVG_PVS7"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",5],["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_quikclot",5],["ACE_CableTie",2],["ACE_Flashlight_XL50",1],["ACE_EarPlugs",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",2]]],
	["<BACKPACK ITEMS >> ",[]]
];


/*
	Insurgents
*/

/*
	EUROPEAN INSURGENTS
*/

kit_ins_random = [
	"kit_ins_r"
	,"kit_ins_gr"
	,"kit_ins_rheavy"
	,"kit_ins_r"
	,"kit_ins_gr"
	,"kit_ins_rheavy"
	,"kit_ins_mg"
];

#define INS_UNI	["CUP_U_O_Partisan_VSR_Mixed2","CUP_U_O_Partisan_VSR_Mixed1","CUP_U_O_Partisan_TTsKO_Mixed","CUP_U_O_Partisan_TTsKO","CUP_U_I_GUE_Woodland1","CUP_U_I_GUE_Flecktarn","CUP_U_I_GUE_Flecktarn3","CUP_U_I_GUE_Flecktarn2"]
#define INS_HEAD	["H_Bandanna_cbr","H_Bandanna_camo", "H_MilCap_dgtl"]
kit_ins_r =
	[
	["<EQUIPEMENT >>  ",INS_UNI,"TRYK_V_harnes_od_L","",INS_HEAD,"G_Bandanna_oli"],
	["<PRIMARY WEAPON >>  ","rhs_weap_ak74m","rhs_30Rnd_545x39_AK",["rhs_acc_dtk","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemCompass","ItemWatch","ItemRadio"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",8],["ACE_packingBandage",4],["PRIMARY MAG",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",8],["HandGrenade",3],["rhs_mag_rdg2_black",2]]],
	["<BACKPACK ITEMS >> ",[]]
];
kit_ins_gr =
	[
	["<EQUIPEMENT >>  ",INS_UNI,"TRYK_V_harnes_od_L","",INS_HEAD,"G_Bandanna_oli"],
	["<PRIMARY WEAPON >>  ","rhs_weap_ak74m_gp25","rhs_30Rnd_545x39_AK",["rhs_acc_dtk","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemCompass","ItemWatch","ItemRadio"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",8],["ACE_packingBandage",4],["PRIMARY MAG",1]]],
	["<VEST ITEMS >> ",[["HandGrenade",1],["rhs_mag_rdg2_black",2],["PRIMARY MAG",6],["rhs_VOG25",8]]],
	["<BACKPACK ITEMS >> ",[]]
];
kit_ins_rheavy =
	[
	["<EQUIPEMENT >>  ",INS_UNI,"TRYK_V_harnes_od_L","",INS_HEAD,"G_Bandanna_oli"],
	["<PRIMARY WEAPON >>  ","rhs_weap_akms","rhs_30Rnd_762x39mm",["","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemCompass","ItemWatch","ItemRadio"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",8],["ACE_packingBandage",4],["PRIMARY MAG",3]]],
	["<VEST ITEMS >> ",[["HandGrenade",2],["rhs_mag_rdg2_black",2],["PRIMARY MAG",8]]],
	["<BACKPACK ITEMS >> ",[]]
];
kit_ins_mg =
	[
	["<EQUIPEMENT >>  ",INS_UNI,"TRYK_V_harnes_od_L","CUP_B_AlicePack_Khaki",INS_HEAD,"G_Bandanna_oli"],
	["<PRIMARY WEAPON >>  ","CUP_lmg_PKM","CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",["","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemCompass","ItemWatch","ItemRadio"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",8],["ACE_packingBandage",4]]],
	["<VEST ITEMS >> ",[["HandGrenade",2],["rhs_mag_rdg2_black",2],["PRIMARY MAG",1]]],
	["<BACKPACK ITEMS >> ",[["PRIMARY MAG",2]]]
];

kit_ins_mvp = [];



/*
	Civilians
*/
#define CHE_CIV_UNI ["CUP_U_C_Citizen_01","CUP_U_C_Citizen_02","CUP_U_C_Citizen_03","CUP_U_C_Citizen_04","CUP_U_O_CHDKZ_Lopotev"]
#define CHE_CIV_HEAD ["","H_Bandanna_surfer_blk","CUP_H_C_Beanie_03","H_Cap_surfer","CUP_H_C_Ushanka_04","H_Cap_oli","CUP_H_C_Beanie_01","CUP_H_FR_BandanaWdl","H_Booniehat_oli"]
#define CHE_CIV_BEARD ["TRYK_Beard_BK","TRYK_Beard_BK2","TRYK_Beard_BK3","TRYK_Beard_BK4", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]


kit_che_civ =
	[
	["<EQUIPEMENT >>  ",CHE_CIV_UNI,"","",CHE_CIV_HEAD,CHE_CIV_BEARD],
	["<PRIMARY WEAPON >>  ","","",["","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemWatch"],
	["<UNIFORM ITEMS >> ",[]],
	["<VEST ITEMS >> ",[]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_nogova_veh_empty = [
	[],
	[],
	[["ACE_fieldDressing",4],["ACE_tourniquet",1]],
    []
];






