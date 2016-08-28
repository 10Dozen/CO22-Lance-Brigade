  // dzn Gear
  // set true to engage Edit mode
[false] execVM "dzn_gear\dzn_gear_init.sqf";
  // dzn DynAI
[] execVM "dzn_dynai\dzn_dynai_init.sqf";
  // TS Framework
[] execVM "dzn_tSFramework\dzn_tSFramework_Init.sqf";


// Common Script Stuff
[] spawn {
	[] execVM "Logic\commonScripts\Init.sqf";

	// Service Logic
	// [] execVM "Logic\service\serviceLogic.sqf";

	// Tasks
	// [] execVM "Logic\tasks\taskFunctions.sqf";

	// Rally points
	// [] execVM "Logic\rallypoint\rallypointSystem.sqf";
};
