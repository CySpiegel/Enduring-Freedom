objNull spawn {
	private _approvedRefundList = ["B_Truck_01_box_F","rhsusf_m1240a1_m2_uik_usarmy_d",   
									"rhsusf_m1a2sep1tuskiid_usarmy",   
									"rhsusf_M977A4_REPAIR_BKIT_usarmy_d",   
									"rhsusf_M978A4_BKIT_usarmy_d",   
									"rhsusf_M977A4_usarmy_d",   
									"rhsusf_M977A4_AMMO_usarmy_d",   
									"rhsusf_m109d_usarmy",   
									"rhsusf_M142_usarmy_D",   
									"rhsusf_m1240a1_mk19_uik_usarmy_d",   
									"RHS_M2A3_BUSKIII",   
									"CFP_B_USMC_HMMWV_Ambulance_DES_01",   
									"rhsusf_mrzr4_d",   
									"B_Quadbike_01_F", 
									"fza_ah64d_b2e", 
									"vtx_UH60M",
									"vtx_MH60M_DAP","kyo_MH47E_HC",
									"USAF_A10",
									"USAF_F22",
									"USAF_F22_EWP_AA",
									"USAF_F22_EWP_AG",
									"USAF_F22_Heavy",
									"USAF_F35A",
									"USAF_F35A_LIGHT",
									"USAF_F35A_STEALTH",
									"JS_JC_FA18E",
									"JS_JC_FA18F",
									"B_Plane_Fighter_01_F",
									"B_Plane_Fighter_01_Stealth_F"];

	private _doNotDdeleteObject = "PortableHelipadLight_01_green_F";

	private _currentBudget = [west] call ace_fortify_fnc_getBudget;
	private _vehicleCost = 100;

	sleep 2; //wait for client to be able to check vehicles positions properly again.
	_somedeleted =false;
	{
		_vehicle = typeOf(_x);
		if (_vehicle != _doNotDdeleteObject) then {
				deleteVehicle _x;
			_somedeleted =true;
			if (_vehicle in _approvedRefundList) then {
				[west, 100, false] call acex_fortify_fnc_updateBudget;
			} else {
				hintSilent "Vehicle Not Approved for Refunded"
			}
		}
	}
	forEach (ASORVS_VehicleSpawnPos nearEntities ASORVS_VehicleSpawnRadius);
	if(_somedeleted) then {
		sleep 2;
	};


	if (_currentBudget >= _vehicleCost) then {
		_veh = createVehicle [ASORVS_CurrentVehicle, ASORVS_VehicleSpawnPos, [], 0, "CAN_COLLIDE"];
		_veh setVehicleLock "UNLOCKED";
		_veh setDir ASORVS_VehicleSpawnDir;
		[west, -100, false] call acex_fortify_fnc_updateBudget;
	} else {
		hintSilent "Not enough funds in the budget";
	}
};