	// dzn Gear
	// set true to engage Edit mode
[false] execVM "dzn_gear\dzn_gear_init.sqf";
	// dzn DynAI
[] execVM "dzn_dynai\dzn_dynai_init.sqf";
	// dzn Civen
[] execVM "dzn_civen\dzn_civen_init.sqf";
	// TS Framework
[] execVM "dzn_tSFramework\dzn_tSFramework_Init.sqf";

// TFAR disable radio
tf_no_auto_long_range_radio = true;