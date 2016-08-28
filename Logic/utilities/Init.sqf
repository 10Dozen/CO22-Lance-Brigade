call compile preprocessFileLineNumbers "Logic\utilities\Settings.sqf";

dzn_fnc_utilities_addClearAction = {
	player setVariable ["utilities_clearAction", player addAction ["<t color='#0AC2FF'>Clear</t>", { deleteVehicle cursorTarget; }]];
};

dzn_fnc_utilities_removeClearAction = {
	player removeAction (player getVariable "utilities_clearAction");
};

#define	ADD_NOTES	call compile preProcessFileLineNumbers "Logic\utilities\Topics.sqf"

waitUntil { !isNull findDisplay 52 || getClientState == "BRIEFING SHOWN" || time > 0 };
ADD_NOTES;

// If not added accidentally, re-add
if !(player diarySubjectExists "tSF_NotesSettingsPage") then {
	ADD_NOTES;

	// If cannot be added until mission start - add after.
	waitUntil { time > 3 };
	if !(player diarySubjectExists "utilities") then { ADD_NOTES; };
};