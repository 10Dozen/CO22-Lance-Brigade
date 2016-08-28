//	**************
//	Creates an object and assign white-listed arsenal to it.
//	**************

call compile preProcessFileLineNumbers "Logic\inventory\Settings.sqf";
call compile preProcessFileLineNumbers "Logic\inventory\Functions.sqf";

private _whitelistedArsenal = call dzn_fnc_inventory_getWhitelist;
{
	[_x, _whitelistedArsenal] spawn dzn_fnc_inventory_addArsenal;	
} forEach dzn_inventory_boxes;
