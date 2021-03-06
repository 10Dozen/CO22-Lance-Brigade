// **************************
// 	DZN TS FRAMEWORK v1.2
//
//	Initialized when:
//	{ }
//
//	Server-side initialized when:
//	{  }
//
// **************************

// **************************
//  MODULES
// **************************
tSF_module_MissionDefaults = false;
tSF_module_MissionConditions = false;

tSF_module_IntroText = true;
tSF_module_Briefing = true;
tSF_module_tSNotes = true;
tSF_module_tSNotesSettings = true;

tSF_module_CCP = false;

tSF_module_tSAdminTools = false;


// **************************
//  INIT
// **************************
if (tSF_module_MissionDefaults) then { [] execVM "dzn_tSFramework\Modules\MissionDefaults\Init.sqf"; };
if (tSF_module_MissionConditions) then { [] execVM "dzn_tSFramework\Modules\MissionConditions\Init.sqf"; };

if (tSF_module_IntroText) then { [] execVM "dzn_tSFramework\Modules\IntroText\Init.sqf"; };
if (tSF_module_Briefing) then { [] execVM "dzn_tSFramework\Modules\Briefing\Init.sqf"; };
if (tSF_module_tSNotes) then { [] execVM "dzn_tSFramework\Modules\tSNotes\Init.sqf"; };
if (tSF_module_tSNotesSettings) then { [] execVM "dzn_tSFramework\Modules\tSNotesSettings\Init.sqf"; };

if (tSF_module_CCP) then { [] execVM "dzn_tSFramework\Modules\CCP\Init.sqf"; };

if (tSF_module_tSAdminTools) then { [] execVM "dzn_tSFramework\Modules\tSAdminTools\Init.sqf"; };
