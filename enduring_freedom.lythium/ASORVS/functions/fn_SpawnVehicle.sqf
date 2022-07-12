objNull spawn {
	private _approvedRefundList = ["rhsusf_m1151_mk19_v2_usarmy_d",  
									"rhsusf_m1151_m2_v2_usarmy_d",  
									"rhsusf_M1220_MK19_usarmy_d",  
									"rhsusf_M1230_M2_usarmy_d",  
									"rhsusf_M1237_MK19_usarmy_d",  
									"rhsusf_M1237_M2_usarmy_d",  
									"rhsusf_M1083A1P2_B_D_fmtv_usarmy",  
									"rhsusf_M1085A1P2_B_D_Medical_fmtv_usarmy",  
									"rhsusf_m1165a1_gmv_m2_m240_socom_d",  
									"rhsusf_m1165a1_gmv_mk19_m240_socom_d",  
									"vtx_UH60M_MEDEVAC","B_Truck_01_box_F","rhsusf_m1240a1_m2_uik_usarmy_d",
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
									"vtx_UH60M",
									"vtx_MH60M_DAP",
									"kyo_MH47E_HC",
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
									"B_Plane_Fighter_01_Stealth_F",
									"fza_ah64d_b2e",
									"RHS_MELB_MH6M", 
									"RHS_MELB_AH6M"];

	private _doNotDdeleteObject = "PortableHelipadLight_01_green_F";

	private _currentBudget = [west] call ace_fortify_fnc_getBudget;
	private _vehicleCost = ["cys_vechile_cost", 100] call BIS_fnc_getParamValue;
	private _allowedVehicleRefunWorth = ["cys_vechile_refund_allowed", 100] call BIS_fnc_getParamValue;
	private _scrapVehicleWorth = ["cys_vechile_refund_scrap", 100] call BIS_fnc_getParamValue;

	sleep 2; //wait for client to be able to check vehicles positions properly again.
	_somedeleted =false;
	{
		_vehicle = typeOf(_x);
		if (_vehicle != _doNotDdeleteObject) then {
				deleteVehicle _x;
			_somedeleted =true;
			if (_vehicle in _approvedRefundList) then {
				[west, _allowedVehicleRefunWorth, false] call acex_fortify_fnc_updateBudget;
				["ACE_Fortify_budget_change", []] call CBA_fnc_serverEvent;
			} else {
				hintSilent "Vehicle Not Approved for Refunded, but we will scrap it";
				[west, _scrapVehicleWorth, false] call acex_fortify_fnc_updateBudget;
				["ACE_Fortify_budget_change", []] call CBA_fnc_serverEvent;
			}
		}
	}
	forEach (ASORVS_VehicleSpawnPos nearEntities ASORVS_VehicleSpawnRadius);
	if(_somedeleted) then {
		sleep 2;
	};


	if (_currentBudget >= _vehicleCost) then {
		_veh = createVehicle [ASORVS_CurrentVehicle, ASORVS_VehicleSpawnPos, [], 0, "CAN_COLLIDE"];
		clearItemCargoGlobal _veh;
		clearWeaponCargoGlobal _veh;
		clearMagazineCargoGlobal _veh;
		removeBackpackGlobal _veh;
		_veh setVehicleLock "UNLOCKED";
		_veh setDir ASORVS_VehicleSpawnDir;
		_spending = _vehicleCost * -1;
		[west, _spending, false] call acex_fortify_fnc_updateBudget;
		["ACE_Fortify_budget_change", []] call CBA_fnc_serverEvent;
	} else {
		hintSilent "Not enough funds in the budget";
	}
};