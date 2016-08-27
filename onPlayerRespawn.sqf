if (!isNil { player getVariable "dzn_gear_kit" }) then {
	[player, player getVariable "dzn_gear_kit"] spawn dzn_fnc_gear_assignGear;
} else {
	[player, "kit_lance_default"] spawn dzn_fnc_gear_assignKit;
};