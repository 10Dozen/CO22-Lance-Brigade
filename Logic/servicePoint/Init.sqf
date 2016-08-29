call compile preprocessFileLineNumbers "Logic\servicePoint\Settings.sqf";
call compile preprocessFileLineNumbers "Logic\servicePoint\Functions.sqf";

ServiceZones = [];
{
	ServiceZones pushBack ([_x, false] call dzn_fnc_convertTriggerToLocation);
} forEach dzn_servicePoint_ServiceAreas;

dzn_servicePoint_canCheck = true;
dzn_servicePoint_waitToCheck = {
	dzn_servicePoint_canCheck = false;
	sleep 15;
	dzn_servicePoint_canCheck = true;
};

["servicePoint_Controller", "onEachFrame", {
	if !(dzn_servicePoint_canCheck) exitWith {};
	[] spawn dzn_servicePoint_waitToCheck;

	if (vehicle player == player) exitWith {};

	if ( [player, ServiceZones] call dzn_fnc_isInLocation ) then {
        (vehicle player) spawn dzn_fnc_servicePoint_serviceVehicle;
    };
}] call BIS_fnc_addStackedEventHandler;
