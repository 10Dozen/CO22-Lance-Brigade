// FUNCTIONS

dzn_atc_fnc_showRequestMenu = {
	// @Unit call dzn_fnc_rp_showRequestMenu
	[west,"HQ"] commandChat format ["Evac vehicle is called by %1", name (player getVariable 'atcRequestBy')];
	atc_menu = [
		[format ["Called by %1", name (player getVariable 'atcRequestBy')] ,false],
		["Accept", [2], "", -5, [["expression", "(player getVariable 'atcRequestBy') setVariable ['atcRequestAccepted', true, true];"]], "1", "1"],
		["Decline", [3], "", -5, [["expression", "(player getVariable 'atcRequestBy')  setVariable ['atcRequestAccepted', false, true];"]], "1", "1"]
	];
	showCommandingMenu "#USER:atc_menu";
	
	player setVariable ["atcRequested", false, true];
};

dzn_atc_callFromAction = {
	// Exit if leader already have request
	if ((leader player) == player) exitWith { player setVariable ['atcRequestAccepted', true, true] };
	if ((leader player) getVariable "atcRequested") exitWith {};
	
	// Show comanding menu
	player setVariable ["atcRequestAccepted", false];
	(leader player) setVariable ["atcRequested", true, true];
	(leader player) setVariable ["atcRequestBy", player, true];
};

dzn_atc_showVehicleMenu = {
	dzn_atc_menu = [["Air Taxi Call",false]];
	{
		dzn_atc_menu pushBack [ 
			_x call dzn_atc_fnc_getVehicleDisplayName
			,[(2 + _forEachIndex)]
			,""
			,-5
			,[["expression", format ['player setVariable ["dzn_atc_called", "%1"];', _x] ]]
			,"1"
			,"1"
		];
	} forEach dzn_atc_vehiclesList;
	showCommandingMenu "#USER:dzn_atc_menu";
};

KK_fnc_setVelocityModelSpaceVisual = {
    private "_o";
    _o = _this select 0;
    _o setVelocity (
        _o modelToWorldVisual (_this select 1) vectorDiff (
            _o modelToWorldVisual [0,0,0]
        )
    );
};

dzn_atc_fnc_getPilotClassByPlayerSide = {
	// Return pilot for player's side
	private ["_id"];
	
	_id = switch (side player) do {
		case west: { 0 };
		case east: { 1 };
		case resistance: { 2 };
		case civilian: { 3 };
	};

	(dzn_atc_pilotsPerSide select _id)
};

dzn_atc_fnc_spawnAirTaxiVehicle = {
	// Spawn AirTaxi vehicle at given position
	// [@VehicleClass, @Position[ call dzn_atc_fnc_spawnAirTaxiVehicle
	private["_veh","_vehClass","_pos"];
	
	_vehClass = _this select 0;
	_pos = _this select 1;
	
	_veh = createVehicle [_vehClass, _pos, [], 0, "FLY"];			
	_veh setDir ([_veh, player] call BIS_fnc_dirTo);			
	[_veh, [0,20,0]] call KK_fnc_setVelocityModelSpaceVisual;

	player moveInDriver _veh;
	
	_veh
};

dzn_atc_fnc_returnAirTaxi = {
	// Spawn ai-pilot for leaved vehice and move it t exit point
	// @Vehicle call dzn_atc_fnc_returnAirTaxi
	
	private["_veh"];
	
	_veh = _this;	
	
	["dzn_atc_noCrewHandler_" + str(round(time)), "onEachFrame", {
		private ["_ehId","_grp","_veh","_pilot"];
		_ehId = _this select 0;
		_veh = _this select 1;

		if (driver _veh != player && canMove _veh) then {
			_veh setVariable ["dzn_atc_clearOut", true, true];
			_veh lock true;
			
			_grp = createGroup (side player);
			_pilot = _grp createUnit [call dzn_atc_fnc_getPilotClassByPlayerSide, [0,0,0], [], 0, "NONE"];				
	
			if (dzn_atc_useCustomerPilotGear) then { _pilot spawn dzn_atc_customPilotsGear; };
	
			_pilot assignAsDriver _veh;
			_pilot moveInDriver _veh;		
			
			_pilot doMove dzn_atc_exitPoint;
			
			_pilot disableAI "TARGET";
			_pilot disableAI "AUTOTARGET";
			_pilot disableAI "SUPPRESSION";
			_pilot disableAI "AIMINGERROR";
			_pilot disableAI "COVER";
			_pilot disableAI "AUTOCOMBAT";
			
			[_ehId, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
			[_pilot] spawn {
				for "_i" from 0 to 10 do {
					sleep 5;
					if (!isNil { _this select 0}) then {					
						(_this select 0) doMove dzn_atc_exitPoint;
					};
				};
			};
			[_veh, _pilot] spawn {
				waitUntil { (_this select 0) distance dzn_atc_exitPoint < 300 };
				moveOut (_this select 1);
				deleteVehicle (_this select 1);
				deleteVehicle (_this select 0);			
			};
		};
	}, ["dzn_atc_noCrewHandler_" + str(round(time)), _veh]] call BIS_fnc_addStackedEventHandler;	
};

dzn_atc_fnc_showIPMarker = {
	private["_mrk"];
	
	_mrk = createMarkerLocal ["dzn_atc_IPMarker", [dzn_atc_placementPoint select 0, dzn_atc_placementPoint select 1]];
	"dzn_atc_IPMarker" setMarkerShapeLocal "ICON";
	"dzn_atc_IPMarker" setMarkerTypeLocal "mil_start";
	"dzn_atc_IPMarker" setMarkerColorLocal "ColorBLUFOR";
	"dzn_atc_IPMarker" setMarkerTextLocal "IP ZULU";
};

dzn_atc_fnc_showCloseAreaMarker = {
	// Create marker to represent area too close to spawn air taxi unit
	private["_closeAreaMarker"];
	_closeAreaMarker = createMarkerLocal ["dzn_atc_closeAreaMarker", [getPosASL player select 0, getPosASL player select 1]];
	"dzn_atc_closeAreaMarker" setMarkerShapeLocal "ELLIPSE";
	"dzn_atc_closeAreaMarker" setMarkerSizeLocal [dzn_atc_customPlacementMinDist, dzn_atc_customPlacementMinDist];
	"dzn_atc_closeAreaMarker" setMarkerColorLocal "ColorRed";
	"dzn_atc_closeAreaMarker" setMarkerAlphaLocal 0.5;	
};

dzn_atc_fnc_hideCloseAreaMarker = {
	deleteMarkerLocal "dzn_atc_closeAreaMarker";
};

dzn_atc_fnc_callAirTaxi = {
	// OpenMenu and allow to choose IP for air taxi and/or spawn it on init point

	if (dzn_atc_useCustomPlacement) then {
		call dzn_atc_fnc_showCloseAreaMarker;
		openMap [true, false];
		
		
		["dzn_atc_clickForSpawn", "onMapSingleClick", {
			if (_pos distance (getPosASL player) < dzn_atc_customPlacementMinDist) exitWith {
				player sideChat format ["Air Taxi Request Cancelled: Too close to player position! Place start point out of %1 m radius.", dzn_atc_customPlacementMinDist];
			};
			
			private ["_veh","_allowed"];
			
			_allowed = true;
			{if (_pos in _x) exitWith {_allowed = false;};	} forEach dzn_atc_customRestrictedLocs;
			if !(_allowed) exitWith {player sideChat "Air Taxi Request Cancelled: Chosen position is in restricted area!";};
			
			_veh = [_this, _pos] call dzn_atc_fnc_spawnAirTaxiVehicle;
			
			openMap [false, false];
			call dzn_atc_fnc_hideCloseAreaMarker;
			
			["dzn_atc_clickForSpawn", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
			
			_veh call dzn_atc_fnc_returnAirTaxi;
		}, _this] call BIS_fnc_addStackedEventHandler;
	} else {
		private ["_veh"];		
		_veh = [_this, dzn_atc_placementPoint] call dzn_atc_fnc_spawnAirTaxiVehicle;
		_veh call dzn_atc_fnc_returnAirTaxi;
	};
};


dzn_atc_fnc_getVehicleDisplayName = {
	// Return display name of given classname of vehicle
	// "B_Heli_Transport_01_camo_F" call dzn_atc_fnc_getVehicleDisplayName
	// 0: STRING 	- classname
	// RETURN:		displayed name
	
	private["_class","_item","_CName", "_DName"];
	
	_class = _this;
	
	_item = (( "configName(_x) == _class") configClasses  (configFile >> "CfgVehicles")) select 0;
	_CName = configName(_item);
	_DName = getText(configFile >> "CfgVehicles" >> _CName >> "displayName");
	
	_DName
};
