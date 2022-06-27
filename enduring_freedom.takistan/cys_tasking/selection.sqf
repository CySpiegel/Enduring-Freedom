_selection = _this select 0;

switch (_selection) do
{
	case 0:
		{
			//Air Strike Operations
			[[],"cys_tasking\airOps\missionAir.sqf"] remoteExec ["BIS_fnc_execVM", 0]; 
		};
	case 1:
		{
			//Combat Operations
			//[[],"cys_tasking\combatOps\missionCombat.sqf"] remoteExec ["BIS_fnc_execVM", 0]; 
			hint "No missions available";
		};
	case 2:
		{
			//Support Operations
			//[[],"cys_tasking\supportOps\missionSupport.sqf"] remoteExec ["BIS_fnc_execVM", 0]; 
			hint "No missions available";
		};
	case 3:
		{
			//Town Aid Operations
			hint "No missions available";
		};
	default {hint "Select an operation from the buttons on the right."};
};