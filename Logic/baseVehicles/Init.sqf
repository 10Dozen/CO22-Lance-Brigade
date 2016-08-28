call compile preprocessFileLineNumbers "Logic\baseVehicles\Settings.sqf";

baseVehicles_VehiclesList = [];
private _vehPoses = synchronizedObjects baseVehiclesCore;

// vehType1_...

{
	private _class = _x select 0;
	private _kit = _x select 1;
	private _ACE_spareParts = _x select 2;
	private _tfar_isolatedAmount = if (!isNil {_x select 3}) then { _x select 3 } else { baseVehicles_TFAR_defaultIsolatedAmount };

	private _vehTypeId = _forEachIndex;
	private _posesAndDirections = [];

	// Get Poistions of vehType logic
	{
		if (
			[format["vehType%1", _vehTypeId], str(_x), false] call BIS_fnc_inString
			&& !(_x getVariable ["baseVehicle_set", false])
		) then {
			_posesAndDirections pushBack [getPosATL _x, getDir _x];
			_x setVariable ["baseVehicle_set", true];
		};
	} forEach _vehPoses;

	// Add Vehicle to Respawnable list
	{
		baseVehicles_VehiclesList pushBack [
			objNull
			, _class
			, _x
			, _kit
			, _ACE_spareParts
			, _tfar_isolatedAmount
		];
	} forEach _posesAndDirections;
} forEach baseVehicles_types;

// Remove Vehicle Pos Logics
while {count (synchronizedObjects baseVehiclesCore) > 0} do {
	deleteVehicle (synchronizedObjects baseVehiclesCore select 0);
};
deleteVehicle baseVehiclesCore;


// Spawn Vehicles
waitUntil { !isNil "ace_repair_fnc_addSpareParts" };

// Base area (where vehicles are invincible until they leave base)
baseVehicles_vehicleBaseArea = [];
{
	baseVehicles_vehicleBaseArea pushBack ([_x, false] call dzn_fnc_convertTriggerToLocation);
} forEach [baseArea];

dzn_fnc_baseVehicles_spawnVehicle = {
	// [@Class, @PosAndDir, @Kit, @AceSpareParts, @TFAR_IsolatedAmount] call dzn_fnc_baseVehicles_spawnVehicle
	params["_classname","_posAndDir","_kit","_aceSpareParts", "_tfarIsolatedAmount"];
	
	private["_veh"];
	_veh = createVehicle [_classname, (_posAndDir select 0), [], 0, 'CAN_COLLIDE'];
	_veh allowDamage false;
	_veh setDir (_posAndDir select 1);
	_veh setPosATL (_posAndDir select 0);

	[_veh, _kit, _aceSpareParts] spawn {
		params["_veh","_kit","_aceSpareParts"];
		
		waitUntil { !isNil "dzn_gear_serverInitDone" };
		sleep 2;
		[_veh, _aceSpareParts select 1, _aceSpareParts select 0] call ace_repair_fnc_addSpareParts;
		[_veh, _kit, true] spawn dzn_fnc_gear_assignKit;
		
		waitUntil {!isNil "dzn_fnc_tfar_setVehicleLR"};
		[_veh, baseVehicles_TFAR_radioSide, _tfarIsolatedAmount] call dzn_fnc_tfar_setVehicleLR;
		
		waitUntil { sleep 5; !([getPosASL _this, baseVehicles_vehicleBaseArea] call dzn_fnc_isInLocation) };
		_this allowDamage true;
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

// If no respawn needed - exit
if !(baseVehicles_respawnable) exitWith { call dzn_fnc_baseVehicles_checkAndSpawnVehicles; };

// Respawn vehicle loop
dzn_fnc_baseVehicles_respawn_canCheck = true;
dzn_fnc_baseVehicles_respawn_waitToCheck = {
	dzn_fnc_baseVehicles_respawn_canCheck = false;
	sleep baseVehicles_respawnCheckTimer;
	dzn_fnc_baseVehicles_respawn_canCheck = true;
};

["baseVehicles_respawnVehiclesController", "onEachFrame", {
	if (dzn_fnc_baseVehicles_respawn_canCheck) then {
		[] spawn dzn_fnc_baseVehicles_respawn_waitToCheck;
		call dzn_fnc_baseVehicles_checkAndSpawnVehicles;
	};
}] call BIS_fnc_addStackedEventHandler;
