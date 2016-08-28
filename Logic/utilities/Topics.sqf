// ********** Topics ****************
#define NOTES		        private["_topics"]; _topics = []; player createDiarySubject ["utilities",dzn_utilities_displayName];
#define TOPIC(Y, NAME) 	    if (Y) then { _topics pushBack ["utilities", [ NAME,
#define END			        ]]; };
#define ADD_TOPICS	        for "_i" from (count _topics) to 0 step -1 do {player createDiaryRecord (_topics select _i);};

NOTES

TOPIC(true, "Настройки доп. опций")
"<font color='#12C4FF' size='14'>Настройки доп. опций</font>
<br /><font color='#A0DB65'><execute expression='[] call dzn_fnc_utilities_addClearAction;'>Add 'Clear' action</execute></font>
<br /><font color='#A0DB65'><execute expression='[] call dzn_fnc_utilities_removeClearAction;'>Remove 'Clear' action</execute></font>
"
END

ADD_TOPICS