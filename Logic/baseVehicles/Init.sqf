call compile preprocessFileLineNumbers "Logic\baseVehicles\Settings.sqf";

respawnableVehicles = [];
private _vehPoses = synchronizedObjects baseVehiclesCore;

// vehType1_...

{
	private _class = _x select 0;
	private _kit = _x select 1;
	private _numberOfACEWheels = _x select 2;
	private _tfar_isolatedAmount = if (!isNil {_x select 3}) then { _x select 3 } else { baseVehicles_TFAR_defaultIsolatedAmount };

	private _vehTypeId = _forEachIndex;
	private _posesAndDirections = [];

	// Get Poistions of vehType logic
	{
		if (
			[format["vehType", _vehTypeId], str(_x), false] call BIS_fnc_inString
			&& !(_x getVariable ["baseVehicle_set", false])
		) then {
			_posesAndDirections pushBack [getPosATL _x, getDir _x];
			_x setVariable ["baseVehicle_set", true];
		};
	} forEach _vehPoses;

	// Add Vehicle to Respawnable list
	{
		respawnableVehicles pushBack [
			objNull
			, _class
			, _x
			, _kit
			, ["ACE_Wheel",_numberOfACEWheels]
			, _tfar_isolatedAmount
		];
	} forEach _posesAndDirections;
} forEach baseVehicles_types;

// Remove Vehicle Pos Logics
while {count (synchronizedObjects baseVehiclesCore) > 0} do {
	deleteVehicle (synchronizedObjects baseVehiclesCore select 0);
};
deleteVehicle baseVehiclesCore;




waitUntil { !isNil "ace_repair_fnc_addSpareParts" };
baseVehicles_vehicleBaseArea = [];
{
	baseVehicles_vehicleBaseArea pushBack ([_x, false] call dzn_fnc_convertTriggerToLocation);
} forEach [baseArea];

dzn_fnc_spawnRespawnableVehicle = {
	// [@Class, @PosAndDir] call dzn_fnc_spawnRespawnableVehicle
	params["_classname","_posAndDir","_kit","_aceWheels", "_tfarIsolatedAmount"];
	private["_veh"];
	_veh = createVehicle [_classname, (_posAndDir select 0), [], 0, 'CAN_COLLIDE'];
	_veh allowDamage false;
	_veh setDir (_posAndDir select 1);
	_veh setPosATL (_posAndDir select 0);

	[_veh, _kit, _aceWheels] spawn {
		params["_veh","_kit","_aceWheels"];
		waitUntil { !isNil "dzn_gear_serverInitDone" };
		sleep 2;
		[_veh, _aceWheels select 1, _aceWheels select 0] call ace_repair_fnc_addSpareParts;
		[_veh, _kit, true] spawn dzn_fnc_gear_assignKit;
	};

	_veh spawn {
		waitUntil { sleep 5; !([getPosASL _this, baseVehicles_vehicleBaseArea] call dzn_fnc_isInLocation) };
		_this allowDamage true;
	};

	_veh spawn {
		waitUntil {!isNil "dzn_tfar_setVehicleLR"};
		[_veh, west, _tfarIsolatedAmount] call dzn_tfar_setVehicleLR;
	};

	_veh
};

dzn_fnc_checkAndSpawnRespawnableVehicles = {
	{
		// No object or not alive, then spawn new object
		if (isNull (_x select 0) || { !alive (_x select 0) }) then {
			_veh = [_x select 1, _x select 2, _x select 3, _x select 4, _x select 5] call dzn_fnc_spawnRespawnableVehicle;
			respawnableVehicles set [_forEachIndex, [_veh, _x select 1, _x select 2, _x select 3, _x select 4, _x select 5]];
		};
	} forEach respawnableVehicles;
};


dzn_fnc_respawnableVehicles_canCheck = true;
dzn_fnc_respawnableVehicles_waitToCheck = {
	dzn_fnc_respawnableVehicles_canCheck = false;
	sleep 60;
	dzn_fnc_respawnableVehicles_canCheck = true;
};

["respawnableVehiclesController", "onEachFrame", {
	if (dzn_fnc_respawnableVehicles_canCheck) then {
		[] spawn dzn_fnc_respawnableVehicles_waitToCheck;
		call dzn_fnc_checkAndSpawnRespawnableVehicles;
	};
}] call BIS_fnc_addStackedEventHandler;