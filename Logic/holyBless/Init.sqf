call compile preprocessFileLineNumbers "Logic\holyBless\Settings.sqf";

{
	waitUntil {!isNil "ace_medical_fnc_treatmentAdvanced_fullHealLocal"};
	_x addAction [
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
} forEach dzn_holyBless_objects;