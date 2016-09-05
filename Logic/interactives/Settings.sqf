
/*
	Configuration of interative objects:
		[ @List of Classname or @List of Objects to apply, @CodeToExecute, @Client/Server/Global ]

		0:  @List of Classname OR List of @Objects  -   if list of classname is used, then all map objects with given class will be applyed
		1:  @CodeToExecute  -   code to execute, _this as reference; will be spawned
		2:  @Client/Server/Global   -   locality run ("client","server","global")
		3:  @Persistant(Boolean) - will apply code for each new entities (false by default)

		To manually apply code, use
			[@ReferenceList, @Code] call dzn_fnc_interactives_executeEach
*/
#define     EXIT_IF_SWITCHED(X)      if (!isNil X) exitWith {}
#define     SWITCH_ON(X)        missionNamespace setVariable [X, true, true]
#define     SWITCH_OFF(X)       missionNamespace setVariable [X, nil, true]

dzn_interactives_objectsAndClasses = [
	[
		["Land_ToiletBox_F"]
		, {
			_this addAction [
				"<t color='#FFE240'>Unload your 'Gun'</t>",{
				[] spawn {
					for "_i" from 0 to (round(random 3)) do {
						1000 cutText ["","WHITE OUT",0.3];
						sleep 1;
						1000 cutText ["","WHITE IN",1];
					};
					hint parseText "<t color='#FFE240' size='2'>You feel empty</t>";
		        };
			},"",6,true,true,"","_this distance2d _target < 1.4"
			];
		}
		, "client"
	]
	, [
		[Chapel]
		, {
			waitUntil {!isNil "ace_medical_fnc_treatmentAdvanced_fullHealLocal"};
            _this addAction [
            	"<t color='#FFE240' size='1.5'>Pray the God</t>",{
            		[player,player] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
            		[] spawn {
            			1000 cutText ["","WHITE OUT",0.3];
            			sleep 1;
            			1000 cutText ["","WHITE IN",1];
            			hint parseText "<t color='#FFE240' size='2'>You feel the blessing</t>";
            		};
            	},"",6,true,true,"","_this distance2d _target < 1.6"
            ];
		}
		, "client"
	]
	, [
		[LRRadio_Base]
		, {
			_this addAction [
            	"<t color='#FFE240'>Radio: Report to HQ</t>"
            	,{
					EXIT_IF_SWITCHED("dzn_interactives_Radio_ReportToHQ");
					[] spawn {
						SWITCH_ON("dzn_interactives_Radio_ReportToHQ");

            	        [player, "Lance-Commander, this is Ebin-One-One. Do you read me? Over."] remoteExec ["commandChat", 0];
	                    sleep 4;
	                    [[west, "HQ"], "Ebin-One-One, this is Lance-Commander. Say, over."] remoteExec ["commandChat", 0];
	                    sleep 3;
	                    [player, (selectRandom [
                            "Lance-Commander, wen do we eat :DDDD"
							, "mr Lance-Commander i have losd my rifle :DDD"
							, "chaaarge :DD"
						])] remoteExec ["commandChat", 0];
	                    sleep 3;
						[[west, "HQ"], "Damn idiods, you could adlest try!"] remoteExec ["commandChat", 0];

						SWITCH_OFF("dzn_interactives_FMRadio_FindSomeMusic");
            	    };
            	},"",6,true,true,"","_this distance2d _target < 1.6"
            ];
		}
		, "client"
	]
	, [
		["Radio"]
		, {
			_this addAction [
            	"<t color='#FFE240'>FM Radio: Find some music</t>"
            	,{
            	    EXIT_IF_SWITCHED("dzn_interactives_FMRadio_FindSomeMusic");
            	    SWITCH_ON("dzn_interactives_FMRadio_FindSomeMusic");

					private _fmTrack = selectRandom [
						"radioMusic1"
						, "radioMusic2"
						, "radioMusic3"
						, "radioMusic4"
						, "radioMusic5"
						, "radioMusic6"
						, "radioMusic7"
						, "radioMusic8"
					];

					[_this select 0, [_fmTrack, 25, 1]] remoteExec ["say3D", 0];
					[] spawn {
						sleep 15;
						SWITCH_OFF("dzn_interactives_FMRadio_FindSomeMusic");
					};
            	},"",6,true,true,"","_this distance2d _target < 1.6"
            ];
		}
		, "client"
		, true
	]

];