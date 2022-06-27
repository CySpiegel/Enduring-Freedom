if(!isServer) exitWith {}; 
//_missions = ["arty","cas","convoy","warehouse"] call BIS_fnc_selectRandom; //mission array + Random
_missions = ["arty","cas","convoy","warehouse"] call BIS_fnc_selectRandom; //mission array + Random
[_missions] execVM "cys_tasking\airOps\makeAirOps.sqf";  //call mission