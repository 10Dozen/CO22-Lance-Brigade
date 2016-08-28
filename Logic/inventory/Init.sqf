//	**************
//	Creates an object and assign white-listed arsenal to it.
//	**************
private["_boxClass","_boxPosition","_whitelist","_box","_weapons","_magazines","_backpacks","_items"];
/*	Assigning Whitelisted Arsenal		*/
_box = _this;

/* 	Settings	*/
_whitelist		= call compile ("[" + preProcessFile "Logic\inventory\whitelist.sqf" + "]");
_weapons		= [];
_magazines 	= [];
_backpacks	= [];
_items		= [];

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

[_box , (_box call BIS_fnc_getVirtualBackpackCargo)] call BIS_fnc_removeVirtualBackpackCargo;
[_box , (_box call BIS_fnc_getVirtualItemCargo)] call BIS_fnc_removeVirtualItemCargo;
[_box , (_box call BIS_fnc_getVirtualWeaponCargo)] call BIS_fnc_removeVirtualWeaponCargo;
[_box , (_box call BIS_fnc_getVirtualMagazineCargo)] call BIS_fnc_removeVirtualMagazineCargo;
	
[_box, _backpacks, true, false] call BIS_fnc_addVirtualBackpackCargo;
[_box, _items, true, false] call BIS_fnc_addVirtualItemCargo;
[_box, _weapons, true, false] call BIS_fnc_addVirtualWeaponCargo;
[_box, _magazines, true, true] call BIS_fnc_addVirtualMagazineCargo;
