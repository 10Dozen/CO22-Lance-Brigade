call compile preprocessFileLineNumbers "Logic\interactives\Settings.sqf";

#define     APPLY_CLIENT_CODE(X,Y)      if (hasInterface) then {waitUntil {!isNull player && { local player}}; [X, Y] call dzn_fnc_interactives_executeEach; }
#define     APPLY_SEVER_CODE(X,Y)       if (isServer || isDedicated) then { [X, Y] call dzn_fnc_interactives_executeEach; };

dzn_fnc_interactives_executeEach = {
	// [@ReferenceList, @Code] call dzn_fnc_interactives_executeEach
	params ["_reference", "_code"];

	private _objects = [];
	if (typename (_reference select 0) == "STRING") then {
		{
			_objects = _objects + entities _x;
		} forEach _reference;
	} else {
		_objects = _reference;
	};

	{ _x spawn _code; } forEach _objects;
};

{
	private _reference = _x select 0;
	private _code = _x select 1;
	private _locality = toLower (_x select 2);

	switch (_locality) do {
		case "client": {
			APPLY_CLIENT_CODE(_reference, _code);
		};
		case "server": {
			APPLY_SEVER_CODE(_reference, _code);
		};
		case "global": {
			APPLY_CLIENT_CODE(_reference, _code);
            if (!hasInterface) then {
                APPLY_SEVER_CODE(_reference, _code);
            };
		};
	};
} forEach dzn_interactives_objectsAndClasses;