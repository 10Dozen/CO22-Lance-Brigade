dzn_fnc_servicePoint_serviceVehicle = {
	if (player getVariable ["onServing", false]) exitWith {};

	params ["_v"];

	1000 cutText ["Vehicle Servicing", "PLAIN"];
	player setVariable ["onServing", true];

	sleep dzn_servicePoint_repairTime;
	_v setDamage 0;
	{
		_v setHit [_x, 0];
	} forEach [
		"wheel_1"
		,"wheel_2"
		,"wheel_3"
		,"wheel_4"
		,"pas_L"
		,"pas_P"
	];

	sleep dzn_servicePoint_refuelTime;
	_v setFuel 1;

	sleep dzn_servicePoint_rearmTime;
	_v setVehicleAmmo 1;

	sleep 1;
	1000 cutText ["Vehicle Servicing - Done", "PLAIN"];
	[] spawn {
		sleep 20;
		player setVariable ["onServing", false];
	};
};