enableSaving [false,false];

// Stuff
["CAManBase", "Init", {
	params ["_entity"];
	
	_entity setVariable ["side_unit", side _entity];

	_entity addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

		_sideUnit = _unit getVariable ["side_unit", sideUnknown];
		if (_sideUnit isEqualTo sideUnknown) exitWith {};

		_budget = switch(_sideUnit) do {
			case west: { 0 };
			case east: { 50 };
			case resistance: { 50 };
			case civilian: {
				if ((side _instigator) isEqualTo west) then { -200 } else { 0 }
			};
			default { 0 };
		};
		
		if (_budget isEqualTo 0) exitWith {};

		[west, _budget, (_sideUnit isEqualTo civilian)] call acex_fortify_fnc_updateBudget;
		["ACE_Fortify_budget_change", []] call CBA_fnc_serverEvent;
	}];

}] call CBA_fnc_addClassEventHandler;

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

["ALiVE | Enduring Freedom - Executing init.sqf..."] call ALiVE_fnc_Dump;

//Disable Vcom on vehicles
[{{Driver _x setvariable ["NOAI",true];} foreach (vehicles select {_x isKindOf 'air'});}, 1, []] call CBA_fnc_addPerFrameHandler;


inCap = compile preprocessfilelinenumbers "scripts\inCap.sqf";
_null = [true, true, false, 70, 20] execvm "scripts\injured.sqf";

//Radio Net Programming.........//
_nop = [] execVM "radioNoFreq.sqf";

//Sandstorm
[1, 4, 645] execvm "ROS\scripts\ROS_Sandstorm_Scheduler.sqf";

//Rest of init code
#include "initMission.hpp"