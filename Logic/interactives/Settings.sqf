
/*
	Configuration of interative objects:
		[ @List of Classname or @List of Objects to apply, @CodeToExecute, @Client/Server/Global ]

		0:  @List of Classname OR List of @Objects  -   if list of classname is used, then all map objects with given class will be applyed
		1:  @CodeToExecute  -   code to execute, _this as reference; will be spawned
		2:  @Client/Server/Global   -   locality run ("client","server","global")
*/
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
		["LRRadio_Base"]
		, {
			_this addAction [
            	"<t color='#FFE240'>Report to HQ</t>",{
            	    [] spawn {
	                    player commandChat "Lance-Commander, this is Ebin-One-One. Do you read me? Over.";
	                    sleep 2;
	                    [west, "HQ"] commandChat "Ebin-One-One, this is Lance-Commander. Say, over.";
	                    sleep 2;
	                    player commandChat (selectRandom [
	                        "Lance-Commander, wen do we eat :DDDD"
	                        , "mr Lance-Commander i have losd my rifle :DDD"
	                        , "chaaarge :DD"
	                    ]);
	                    sleep 2;
	                    [west, "HQ"] commandChat "Damn idiods, you could adlest try!";
            	    };
            	},"",6,true,true,"","_this distance2d _target < 1.6"
            ];
		}
		, "client"
	]
	/*, [
		["Radio"]
		, {
			_this addAction [
            	"<t color='#FFE240'>Find some music</t>",{
					(_this select 0) say3d [
						"radioMusic0"
						, 25
						, 1
					];
            	},"",6,true,true,"","_this distance2d _target < 1.6"
            ];
		}
		, "client"
	]
	*/
];