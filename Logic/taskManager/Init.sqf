call compile preprocessFileLineNumbers "Logic\taskManager\Settings.sqf";
call compile preprocessFileLineNumbers "Logic\taskManager\Functions.sqf";

waitUntil { !isNil "dzn_dynai_initialized" && { dzn_dynai_initialized  } };
if !(isServer) then { waitUntil { !isNil "dzn_fnc_addRadioService" }; };

call dzn_fnc_TaskManager_init;