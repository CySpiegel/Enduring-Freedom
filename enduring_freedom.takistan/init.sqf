enableSaving [false,false];

// Initialise the respawn system
//null= [[West_Base],WEST,TRUE,40] execVM "BRS\BRS_launch.sqf";

// Scripts
[] execVM "bon_recruit_units\init.sqf";
//0 = [] execvm "scripts\tpw_core.sqf";
call compile preprocessFileLineNumbers "removeTasks.sqf";

// Starts the earning and penelty systems for killing units
["CAManBase", "Init", {
	params ["_entity"];
	_entity setVariable ["side_unit", side _entity];
	_entity addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		_sideUnit = _unit getVariable ["side_unit", sideUnknown];
		if (_sideUnit isEqualTo sideUnknown) exitWith {};
		_budget = switch(_sideUnit) do {
			case west: { 0 };
			case east: { 10 };
			case resistance: { 10 };
			case civilian: {
				if ((side _instigator) isEqualTo west) then { 0 } else { 0 }
			};
			default { 0 };
		};

		if (_budget isEqualTo 0) exitWith {};
		[west, _budget, (_sideUnit isEqualTo civilian)] call acex_fortify_fnc_updateBudget;
		["ACE_Fortify_budget_change", []] call CBA_fnc_serverEvent;
	}];
}] call CBA_fnc_addClassEventHandler;

call compile preprocessFileLineNumbers "Engima\Traffic\Init.sqf";

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

// Prison System initilization
if (isServer) then {
    ["ace_captiveStatusChanged", {
        params ["_unit", "_state", "_reason"];
 
        if ((getPos _unit) inArea prison_trigger) then {
            _unit setVariable ["detained", true, true];
        };
    }] call CBA_fnc_addEventHandler;
 
    [{
        [getPos prison_marker_or_trigger_name, [side player], -10] call ALIVE_fnc_updateSectorHostility;
    }, 3600, []] call CBA_fnc_addPerFrameHandler;
};

if(isServer) then {
    // set the civilian types that will act as next-of-kin
    GR_CIV_TYPES = ["CFP_C_ME_Civ_1_01","CFP_C_ME_Civ_2_01"];

    // set the maximum distance from murder that next-of-kin will be spawned
    GR_MAX_KIN_DIST = 10000;

    // Chance that a player murdering a civilian will get an "apology" mission
    GR_MISSION_CHANCE = ["cys_guilt_chance", 10] call BIS_fnc_getParamValue;

    // Delay in seconds after death until player is notified of body delivery mission
    GR_TASK_MIN_DELAY=10;
    GR_TASK_MID_DELAY=15;
    GR_TASK_MAX_DELAY=20;

    // Set custom faction names to determine blame when performing an autopsy
    GR_FACTIONNAME_EAST = "RUSSIA";
    GR_FACTIONNAME_WEST = "NATO";
    //GR_FACTIONNAME_IND = "CFP_I_IS";
    GR_FACTIONNAME_IND = "ISIS";

    // You can also add/remove custom event handlers to be called upon
    // certain events.

    // // On civilian murder by player:
    // [yourCustomEvent_OnCivDeath] call GR_fnc_addCivDeathEventHandler; // args [_killer, _killed, _nextofkin]
    // // (NOTE: _nextofkin will be nil if a body delivery mission wasn't generated.)
    // [yourCustomEvent_OnCivDeath] call GR_fnc_removeCivDeathEventHandler;

    // // On body delivery:
    // [yourCustomEvent_OnDeliverBody] call GR_fnc_addDeliverBodyEventHandler; // args [_killer, _nextofkin, _body]
    // [yourCustomEvent_OnDeliverBody] call GR_fnc_removeDeliverBodyEventHandler;

    // // On successful concealment of a death:
    // [yourCustomEvent_OnConcealDeath] call GR_fnc_addConcealDeathEventHandler; // args [_killer, _nextofkin, _grave]
    // [yourCustomEvent_OnConcealDeath] call GR_fnc_removeConcealDeathEventHandler;

    // // On reveal of a concealed death via autopsy:
    // [yourCustomEvent_OnRevealDeath] call GR_fnc_addRevealDeathEventHandler; // args [_medic, _body, _killerSide]
    // [yourCustomEvent_OnRevealDeath] call GR_fnc_removeRevealDeathEventHandler;

    // NOTE: if your event handler uses _nextofkin or _body, make sure to turn off garbage collection with:
    // _nextofkin setVariable ["GR_WILLDELETE",false];
    //_body setVariable ["GR_WILLDELETE",false];
};

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
#include "initmission.hpp"


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

_initialBudget = ["cys_budget_start", 1000] call BIS_fnc_getParamValue;
[west, _initialBudget, false] call acex_fortify_fnc_updateBudget;