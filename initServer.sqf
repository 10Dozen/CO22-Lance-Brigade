// Base Vehicles
[] execVM "Logic\baseVehicles\Init.sqf";

// Arsenal
[] execVM "Logic\inventory\Init.sqf";

[] spawn {
	// Date Params
	private _date = [2017, 3, 10];
	private _time = "par_daytime" call BIS_fnc_getParamValue;
	setDate [
		_date select 0
		, _date select 1
		, _date select 2
		, if (_time == 0) then { floor(random 23) } else { _time }
		, 0
	];

	// Weather Params
	("par_weather" call BIS_fnc_getParamValue) call dzn_fnc_setWeather;

	// Dynamic Weather
	waitUntil { time > 0 };
    [] execVM "Logic\weather\Init.sqf";
};

if (hasInterface) exitWith {};

// Misc Functions
[] execVM "Logic\commonScripts\Init.sqf";

// Rally points
[] execVM "Logic\rallypoint\Init.sqf";

// Interactives
[] execVM "Logic\interactives\Init.sqf";

// Task Manager
[] execVM "Logic\taskManager\Init.sqf";


// Close doors
[] spawn {
	waitUntil { time > 5 };
	private _pos = [3050,6090,0];
	private _houseClases = [
                               "Land_MBG_Hlidac_budka"
                               ,"Land_MBG_tovarna1"
                               ,"Land_Panelak1_Grey"
                               ,"Land_Panelak2_Grey"
                               ,"Land_cwa_domek_zluty"
                               ,"land_cwa_zluty_statek_in"
                               ,"Land_cwa_Domek_sedy"
                               ,"Land_cwa_domek05"
                               ,"Land_MBG_dum_podloubi03MagicLand"
                               ,"Land_MBG_dum_patrovy01"
                               ,"Land_MBG_dum_patrovy01c"
                               ,"Land_Panelak3_Grey"
    ];
	private _processedHouses = [];
	private _houses = [];
	HousesProcessed = false;

	private _closeDoors = {
		HousesProcessed = false;
		params["_houses","_timer"];
		{
			private _zeroes = ["dvere","dvere1l","dvere1r","dvere2l","dvere2r","dvere_spodni_r","dvere_spodni_l","dvere_vrchni","vrata1","vrata2","vratal1","vratar1","vratal2","vratar2","vratal3","vratar3"];
			private _ones = ["door","door_1_1","door_1_2","door_2_1","door_2_2","dvere1","dvere2","dvere3","dvere4","dvere5","dvere6","dvere7","dvere8","dvere9","dvere10","dvere11","dvere12","dvere13","dvere14","doorl","doorr","door_01","door01_a","door_02","door02_a","door_03","door_04","door_05","door_06","door_1a","door_1","door_2"];

			private _y = _x;
			{_y animate [format ["%1", _x], 0];} foreach _zeroes;
			{_y animate [format ["%1", _x], 1];} foreach _ones;
			sleep (_timer);
		} foreach _houses;

		HousesProcessed = true;
	};

	_houses = (nearestObjects [_pos, _houseClases, 2000]) - _processedHouses;
	_processedHouses = _processedHouses + _houses;
	[_houses, 0.02] spawn _closeDoors;
	waitUntil { HousesProcessed };

	_houses = (nearestObjects [_pos, _houseClases, 5000]) - _processedHouses;
	_processedHouses = _processedHouses + _houses;
	[_houses, 0.8] spawn _closeDoors;
	waitUntil { HousesProcessed };

	_houses = (nearestObjects [_pos, _houseClases, 25000]) - _processedHouses;
	_processedHouses = _processedHouses + _houses;
	[_houses, 1] spawn _closeDoors;
	waitUntil { HousesProcessed };
};