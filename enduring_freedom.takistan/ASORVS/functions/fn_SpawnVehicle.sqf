objNull spawn {
	sleep 2; //wait for client to be able to check vehicles positions properly again.
	_somedeleted =false;
	{
		deleteVehicle _x;
		_somedeleted =true;
		[west, 100, false] call acex_fortify_fnc_updateBudget;
	}
	forEach (ASORVS_VehicleSpawnPos nearEntities ASORVS_VehicleSpawnRadius);
	if(_somedeleted) then {
		sleep 2;
	};


	private _currentBudget = [west] call ace_fortify_fnc_getBudget;
	private _vehicleCost = 100;
	if (_currentBudget >= _vehicleCost) then {
		_veh = createVehicle [ASORVS_CurrentVehicle, ASORVS_VehicleSpawnPos, [], 0, "CAN_COLLIDE"];
		_veh setVehicleLock "UNLOCKED";
		_veh setDir ASORVS_VehicleSpawnDir;
		[west, -100, false] call acex_fortify_fnc_updateBudget;
	} else {
		hintSilent "Not enough funds in the budget";
	}
};