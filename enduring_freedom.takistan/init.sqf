enableSaving [false,false];
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