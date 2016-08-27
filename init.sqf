  // dzn Gear
  // set true to engage Edit mode
[false] execVM "dzn_gear\dzn_gear_init.sqf";
  // dzn DynAI
[] execVM "dzn_dynai\dzn_dynai_init.sqf";
  // TS Framework
[] execVM "dzn_tSFramework\dzn_tSFramework_Init.sqf";


// Common Script Stuff
[] spawn {
	// Service Logic
	// [] execVM "Logic\service\serviceLogic.sqf";

	// Tasks
	// [] execVM "Logic\tasks\taskFunctions.sqf";

	// Rally points
	// [] execVM "Logic\rallypoint\rallypointSystem.sqf";
};

// Common Function
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



dzn_tfar_setVehicleLR = {
	// [@Vehicle, @Side, @IsolatedAmount, @Range, @RadioType]
	params["_veh", ["_side",west],["_isolated",0.5], ["_range", 30000], ["_type", "tf_rt1523g"]];

	_veh setVariable ["tf_side", _side, true];
	_veh setVariable ["tf_hasRadio", true, true];
	_veh setVariable ["tf_isolatedAmount", _isolated, true];
	_veh setVariable ["tf_range", _range, true];
	_veh setVariable ["TF_RadioType", _type, true];
};