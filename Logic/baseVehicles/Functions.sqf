dzn_fnc_baseVehicles_spawnVehicle = {
	// [@Class, @PosAndDir, @Kit, @AceSpareParts, @TFAR_IsolatedAmount] call dzn_fnc_baseVehicles_spawnVehicle
	params["_classname","_posAndDir","_kit","_aceSpareParts", "_tfarIsolatedAmount"];

	private _veh = createVehicle [_classname, (_posAndDir select 0), [], 0, 'CAN_COLLIDE'];
	_veh allowDamage false;
	_veh setDir (_posAndDir select 1);
	_veh setPosATL (_posAndDir select 0);

	[_veh, _kit, _aceSpareParts, _tfarIsolatedAmount] spawn {
		params["_veh","_kit","_aceSpareParts","_tfarIsolatedAmount"];

		waitUntil { !isNil "dzn_gear_serverInitDone" };
		sleep 2;
		[_veh, _aceSpareParts select 1, _aceSpareParts select 0] call ace_repair_fnc_addSpareParts;
		[_veh, _kit, true] spawn dzn_fnc_gear_assignKit;

		waitUntil {!isNil "dzn_fnc_tfar_setVehicleLR"};
		[_veh, baseVehicles_TFAR_radioSide, _tfarIsolatedAmount] call dzn_fnc_tfar_setVehicleLR;

		waitUntil { sleep 5; !([_veh, baseVehicles_vehicleBaseArea] call dzn_fnc_isInLocation) };
		_veh allowDamage true;
	};

	_veh
};

dzn_fnc_baseVehicles_checkAndSpawnVehicles = {
	{
		// No object or not alive, then spawn new object
		if (isNull (_x select 0) || { !alive (_x select 0) }) then {
			_veh = [_x select 1, _x select 2, _x select 3, _x select 4, _x select 5] call dzn_fnc_baseVehicles_spawnVehicle;
			baseVehicles_VehiclesList set [_forEachIndex, [_veh, _x select 1, _x select 2, _x select 3, _x select 4, _x select 5]];
		};
	} forEach baseVehicles_VehiclesList;
};