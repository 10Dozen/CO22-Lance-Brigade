// FUNCTIONS
dzn_fnc_rp_setRallypoint = {
	RallyPoint_Position = getPos player;
	publicVariable "RallyPoint_Position";
};

dzn_fnc_rp_showRequestMenu = {
	// call dzn_fnc_rp_showRequestMenu
	(player getVariable 'rpRequestBy') sideChat format ["Deployment to rallypoint is called by %1", name (player getVariable 'rpRequestBy')];
	rp_menu = [
		[format ["Deploy %1", name (player getVariable 'rpRequestBy')] ,false],
		["Accept", [2], "", -5, [["expression", "(player getVariable 'rpRequestBy') setVariable ['rpRequestAccepted', true, true];"]], "1", "1"],
		["Decline", [3], "", -5, [["expression", "(player getVariable 'rpRequestBy')  setVariable ['rpRequestAccepted', false, true];"]], "1", "1"]
	];
	showCommandingMenu "#USER:rp_menu";
	
	player setVariable ["rpRequested", false, true];
};

dzn_fnc_rp_checkPlayerAtBase = {
	/*
		If dzn_rp_freeDeploymentFromBase is true, 
			then return TRUE once player at base;
		If dzn_rp_freeDeploymentFromBase is false, 
			then return TRUE once both player and RP are at base
	*/
	private _playerInBase = [getPosASL player, rpAllowedAreas] call dzn_fnc_isInLocation;
	
	(
		( 
			dzn_rp_freeDeploymentFromBase 
			&& _playerInBase
		)
		||
		(
			!dzn_rp_freeDeploymentFromBase 
			&& _playerInBase
			&& [RallyPoint_Position,  rpAllowedAreas] call dzn_fnc_isInLocation
		)
	)
};

dzn_fnc_rp_safeMove = {
	// @Pos call dzn_fnc_rp_safeMove	
	1000 cutText ["","BLACK OUT",1];
	player allowDamage false;
	sleep 2; 
	moveOut player;
	player setVelocity [0,0,0];
	player setPos _this;
	player allowDamage true; 
	1000 cutText ["","BLACK IN",1];
};

dzn_fnc_rp_moveToRallypoint = {
	if (call dzn_fnc_rp_checkPlayerAtBase) then {
		// Move instantly if in allowed zones
		RallyPoint_Position spawn dzn_fnc_rp_safeMove;
	} else {
		// Exit if leader already have request
		if ((leader player) == player) exitWith { player setVariable ['rpRequestAccepted', true, true] };	
		if ((leader player) getVariable "rpRequested") exitWith {};
	
		// Show comanding menu
		player setVariable ["rpRequestAccepted", false];
		(leader player) setVariable ["rpRequested", true, true];
		(leader player) setVariable ["rpRequestBy", player, true];
	};
};
