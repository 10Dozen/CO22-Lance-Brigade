call compile preprocessFileLineNumbers "Logic\radioServices\Functions.sqf";


radioServices_action = [ "dzn_services_action", "Radio", "", { }, {true}]  call ace_interact_menu_fnc_createAction; 
[typeOf player, 1, [ "ACE_SelfActions" ], radioServices_action ] call ace_interact_menu_fnc_addActionToClass;
