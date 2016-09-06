// Common Function

dzn_fnc_tfar_setVehicleLR = {
	// [@Vehicle, @Side, @IsolatedAmount, @Range, @RadioType]
	params["_veh", ["_side",west],["_isolated",0.5], ["_range", 30000], ["_type", "tf_rt1523g"]];

	_veh setVariable ["tf_side", _side, true];
	_veh setVariable ["tf_hasRadio", true, true];
	_veh setVariable ["tf_isolatedAmount", _isolated, true];
	_veh setVariable ["tf_range", _range, true];
	_veh setVariable ["TF_RadioType", _type, true];
};


dzn_fnc_randomACEHit = {
	[
		_this
		, [
			"hand_l"
			,"hand_r"
			,"leg_l"
			,"leg_r"
			,"head"
			,"body"
		] call BIS_fnc_selectRandom
		, 0.4 + random(0.5)
		, ""
	] call ace_medical_fnc_addDamageToUnit;
};

dzn_fnc_ACEHit = {
	// [@Unit, @Part, @Damage] call dzn_fnc_ACEHit
	[
		_this select 0
		, _this select 1
		, _this select 2
		, ""
	] call ace_medical_fnc_addDamageToUnit;
};

dzn_fnc_fullHealPlayer = {
	params[["_unit", player]];
	if (isNil "ace_medical_fnc_treatmentAdvanced_fullHealLocal") exitWith {
		_unit spawn {
			waitUntil {!isNil "ace_medical_fnc_treatmentAdvanced_fullHealLocal"};
			_this call dzn_fnc_fullHealPlayer;
		};
	};

	[_unit,_unit] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
};

dzn_fnc_getItemNames = {
	/* Return string of item classnames + display name */
	private _list = if (_this == "items") then {
		call compile ("[" + preProcessFile "Logic\inventory\whitelist.sqf" + "]")
	} else {
		call compile ("[" + preProcessFile "Logic\inventory\whitelistWeapons.sqf" + "]")
	};
	private _namedListString = "";
	{
		_namedListString = format [
			"%1<br/>, ""%2"" /* %3 */"
			, _namedListString
			, _x
			, _x call dzn_fnc_getItemDisplayName
		];
	} forEach _list;

	copyToClipboard _namedListString
};




// @Override
dzn_fnc_getMapGrid_Nogova = {
/*
	@MapGrid(String) = @Pos2d/3d call dzn_fnc_getMapGrid
	Return XXXX YYYY string of given position
	OUTPUT: Map Grid String in XXXX YYYY format

	NOTE: On Nogova [0,0] pos is 0000 8720 map grid
*/

	private["_mapGrid","_i", "_grid","_coordinate"];
	_mapGrid = "";
	for "_i" from 0 to 1 do {
		_coordinate = if (_i == 0) then { _this select _i } else { 87200 + (_this select _i) };
		_grid = str ( ( round ( _coordinate/10 ) ) );
		while {count _grid < 4} do {
			_grid = format ["0%1", _grid];
		};
		_mapGrid = if (_mapGrid == "") then { _grid } else { format ["%1 %2", _mapGrid, _grid] };
	};

	_mapGrid
};