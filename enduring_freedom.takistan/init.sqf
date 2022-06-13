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
			case west: { -200 };
			case east: { 10 };
			case resistance: { 10 };
			case civilian: {
				if ((side _instigator) isEqualTo west) then { -100 } else { 0 }
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

// Only turn on if server logging is turned off
//inCap = compile preprocessfilelinenumbers "scripts\inCap.sqf";
//_null = [true, true, false, 70, 20] execvm "scripts\injured.sqf";

//Radio Net Programming.........//
//_nop = [] execVM "radioNoFreq.sqf";

//Sandstorm
[3, 8, 265] execvm "ROS_Sandstorm\scripts\ROS_Sandstorm_Scheduler.sqf";

//Rest of init code
#include "initMission.hpp"

// Hovering 3D marker
_3dIcon_text = addMissionEventHandler ["Draw3D", { 
    if ((repairTrailer distance player < 20) && ([repairTrailer, "VIEW", player] checkVisibility [eyePos repairTrailer, eyePos player]>0.3)) then { 
        private _position = getPos repairTrailer;     
        private _offsetX = 0;  
        private _offsetY = 0.03;  
        private _drawSideArrows = false;  
        //private _texture = getMissionPath '\a3\soft_f_beta\truck_02\data\ui\map_truck_02_repair_ca.paa'; 
		private _texture = '\a3\soft_f_beta\truck_02\data\ui\map_truck_02_repair_ca.paa';// custom icon path to show over object
        _position set [2, (_position # 2) + 3.3]; // distance over object (customise this value = 3.3)
        private _width = 0.8;  
        private _height = 0.8;  
        private _angle = 0;  
        private _text = 'Repair bay';  // text to show over object
        private _textSize = 0.05;  
        private _font = 'PuristaSemiBold';  
        private _textAlign = 'center';  
        private _shadow = 2; 
        drawIcon3D [  
        _texture,  
        [1,1,1,1],  
        _position,  
        _width,   
        _height,   
        _angle,  
        _text,  
        _shadow,  
        _textSize,  
        _font,  
        _textAlign,  
        _drawSideArrows,  
        _offsetX,  
        _offsetY  
        ];
    };   
}];

