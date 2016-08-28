call compile preprocessFileLineNumbers "Logic\inventory\Settings.sqf";
call compile preprocessFileLineNumbers "Logic\inventory\Functions.sqf";

private _whitelistedArsenal = call dzn_fnc_inventory_getWhitelist;
{
	[_x, _whitelistedArsenal] spawn dzn_fnc_inventory_addArsenal;	
} forEach dzn_inventory_boxes;
