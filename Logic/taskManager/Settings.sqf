/*
	List of available tasks in format:
        [@NumberInTheList, [ @DisplayName, @FolderName ] ]
*/
dzn_TaskManager_availableTasks = [
	[0,	    ["SAD Weapon Cache", "SADCache"]]
	,[1,	["SAD Insurgent Camp", "SADCamp"]]
	,[2,    ["Arrest MVP", "MVPArrest"]]
];

dzn_TaskManager_ranges = [
	[0, 0]
	,[1, 4000]
	,[2, 8000]
	,[3, 12000]
];

dzn_TaskManager_taskResultPageName  =   "Lance Mission Reports";
dzn_TaskManager_taskRequestPosition =   { getMarkerPos "respawn_west" };