dzn_fnc_inventory_addArsenal = {
	// [@Object, @Whitelist] call dzn_fnc_inventory_addArsenal;
	params["_box"];
	
	[_box , (_box call BIS_fnc_getVirtualBackpackCargo)] call BIS_fnc_removeVirtualBackpackCargo;
	[_box , (_box call BIS_fnc_getVirtualItemCargo)] call BIS_fnc_removeVirtualItemCargo;
	[_box , (_box call BIS_fnc_getVirtualWeaponCargo)] call BIS_fnc_removeVirtualWeaponCargo;
	[_box , (_box call BIS_fnc_getVirtualMagazineCargo)] call BIS_fnc_removeVirtualMagazineCargo;
	
	[_box, _weapons, true, false] call BIS_fnc_addVirtualWeaponCargo;
	[_box, _magazines, true, true] call BIS_fnc_addVirtualMagazineCargo;
	[_box, _items, true, false] call BIS_fnc_addVirtualItemCargo;
	[_box, _backpacks, true, false] call BIS_fnc_addVirtualBackpackCargo;
};

dzn_fnc_inventory_getWhitelist = {
	private _whitelist		= call compile ("[" + preProcessFile "Logic\inventory\Whitelist.sqf" + "]");
	private _weapons		= [];
	private _magazines 		= [];
	private _backpacks		= [];
	private _items			= [];

	{
		if (isText (configFile >> "cfgMagazines" >> _x >> "displayName")) then { 
			_magazines pushBack _x; 
		} else {
			if (isText (configFile >> "CfgGlasses" >> _x >> "displayName")) then { 
				_items pushBack _x; 
			} else {
				if (isText (configFile >> "cfgVehicles" >> _x >> "displayName")) then { 
					_backpacks pushBack _x; 
				} else {
					_weapons pushBack _x;
				};
			};
		};
	} forEach _whitelist;

	_items = _items + _weapons;
	
	[_weapons, _magazines, _items, _backpacks]
};
