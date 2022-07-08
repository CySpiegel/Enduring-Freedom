waitUntil {
	!isNil "ALiVE_SYS_DATA_SOURCE";
};

private _saveInterval = ["cys_save_interval", 3600] call BIS_fnc_getParamValue;
if (_saveInterval > 0) then {
	if (ALiVE_SYS_DATA_SOURCE isEqualTo "pns") then {
		_saveInterval call ALiVE_fnc_AutoSave_PNS;
	};
};

_budget = "ACE_fortify_budget" call AliVE_fnc_ProfileNameSpaceLoad;
_objects = ["ASO_Fortify_Objects"] call acex_fortify_fnc_getPlaceableSet;

if (_budget isEqualType 0) then {
	["acex_fortify_registerObjects", [west, _budget, _objects]] call CBA_fnc_serverEvent;
} else {
	["acex_fortify_registerObjects", [west, 0, _objects]] call CBA_fnc_serverEvent;
};

["ACE_Fortify_budget_change", {
	_budget = [west] call acex_fortify_fnc_getBudget;
	_saved = ["ACE_fortify_budget", _budget] call ALiVE_fnc_ProfileNameSpaceSave;
}] call CBA_fnc_addEventHandler;

_objects = [alive_sys_logistics, "allObjects"] call ALiVE_fnc_logistics;
_aceFortifyObjects = ["ASO_Fortify_Objects"] call acex_fortify_fnc_getPlaceableSet;
private _aceFortifyObjectsCleaned = [];
{
	_aceFortifyObjectsCleaned pushBack (_x select 0);
} forEach _aceFortifyObjects;

{
	if (_x isKindOf "Static") then {
		if (_x isKindOf "CBA_NamespaceDummy" || _x isKindOf "Helipad_base_F") exitWith {};
		if ((typeOf _x) in _aceFortifyObjectsCleaned) then {
			_jipID = ["acex_fortify_addActionToObject", [west, _x]] call CBA_fnc_globalEventJIP;  
			[_jipID, _x] call CBA_fnc_removeGlobalEventJIP;
		};
	};
} forEach _objects;

// Code snip from alive wiki 
// ["acex_fortify_objectPlaced", {
//     [ALiVE_SYS_LOGISTICS, "updateObject", [(_this select 2)]] call ALIVE_fnc_logistics;
//     }] call CBA_fnc_addEventHandler;
 
// ["acex_fortify_objectDeleted", {
//     [ALiVE_SYS_LOGISTICS, "removeObject", [(_this select 2)]] call ALIVE_fnc_logistics;
//     }] call CBA_fnc_addEventHandler;

["Initialize", [true]] call BIS_fnc_dynamicGroups; 

addMissionEventHandler ["HandleDisconnect",
{
	[(_this select 0)] spawn {
		sleep 5;
		deleteVehicle (_this select 0);
	};
}];