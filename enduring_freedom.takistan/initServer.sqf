["Initialize", [true]] call BIS_fnc_dynamicGroups; 

addMissionEventHandler ["HandleDisconnect",
{
	[(_this select 0)] spawn 
	{
		sleep 5;
		deleteVehicle (_this select 0);
	};
}];