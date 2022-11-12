waitUntil {
	!isNil "ALiVE_SYS_DATA_SOURCE";
};

private _saveInterval = ["cys_save_interval", -1] call BIS_fnc_getParamValue;
if (ALiVE_SYS_DATA_SOURCE isEqualTo "pns") then {
	_saveInterval call ALiVE_fnc_AutoSave_PNS;
};

["Initialize", [true]] call BIS_fnc_dynamicGroups; 

addMissionEventHandler ["HandleDisconnect",
{
	[(_this select 0)] spawn {
		sleep 5;
		deleteVehicle (_this select 0);
	};
}];
