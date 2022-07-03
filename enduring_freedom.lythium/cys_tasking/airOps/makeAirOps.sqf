_missionType = [_this, 0, ""] call BIS_fnc_param;
	
_myHint ="Requesting Air Strike Operations";
GlobalHint = _myHint;
publicVariable "GlobalHint";
hintsilent parseText _myHint;

sleep 0.3;

_markerArray = ["aosite","aosite_1","aosite_2","aosite_3","aosite_4","aosite_5","aosite_6","aosite_7","aosite_8","aosite_9","aosite_10"];
_rnd 	= floor(random(count(_markerArray)));
_mrkSpawnSite = getMarkerPos(_markerArray select _rnd);

sleep 5;

//Artillery Site Objective
fn_spawnArtyMission = {

	hint "Stand by for tasking order...";
	//Finding Safe Locations	
	_newPosHQ = [_mrkSpawnSite, 0, 100, 15, 0, 10, 0] call BIS_fnc_findSafePos;
	_newPos1 = [_newPosHQ, 30, 60, 10, 0, 10, 0] call BIS_fnc_findSafePos;
	_newPos2 = [_newPos1, 40, 50, 10, 0, 10, 0] call BIS_fnc_findSafePos;
	_newPos3 = [_newPosHQ, 400, 500, 10, 0, 10, 0] call BIS_fnc_findSafePos;
	_newPos4 = [_newPos3, 30, 150, 10, 0, 10, 0] call BIS_fnc_findSafePos;
	
	_markerAO = createMarker ["mob_arty", _newPosHQ];
	_markerAO setMarkerType "Empty";

	//Spawning alive composition
	_radioHQ = [_newPosHQ, "Military", "Fort", "OPF_F", "Small", 0] call ALIVE_fnc_spawnRandomPopulatedComposition;

	//Spawning Objive targets
	_arty1 = createVehicle ["cfp_i_is_T72", _newPos1, [], 0, "NONE"];
	_arty1 setFuel 0;
	_arty1 setDamage 0;
	sleep 0.3;	
	_arty2 = createVehicle ["cfp_i_is_T72", _newPos2, [], 0, "NONE"];
	_arty2 setFuel 0;
	_arty2 setDamage 0;
	sleep 0.3;	
	
	//Spawning in vehicle crew
	_armor = createGroup INDEPENDENT;
	_crew1 = [ _arty1 , _armor, false, "", "cfp_i_is_crewman" ] call BIS_fnc_spawnCrew;
	sleep 0.3;
	_crew2 = [ _arty2 , _armor, false, "", "cfp_i_is_crewman" ] call BIS_fnc_spawnCrew;
	sleep 0.3;
	
	//Spawning in foot patrol units
	_grp1A = [getMarkerPos _markerAO, INDEPENDENT, (configfile >> "CfgGroups" >> "Indep" >> "CFP_I_IS" >> "Infantry" >> "CFP_I_grp_is_inf_squad")] call BIS_fnc_spawnGroup;
	_defendHq = [_grp1A, _markerAO, 300] call BIS_fnc_taskDefend;
	sleep 0.3;	

	//Creating Vehicle Patrol
	_vehiclePatrol = createGroup INDEPENDENT;
	_vehicle1 = [_newPos3, 10, "cfp_i_is_hmmwv_dshkm", _vehiclePatrol] call BIS_fnc_spawnvehicle;
	sleep 0.3;	
	_vehicle2 = [_newPos4, 10, "cfp_i_is_hmmwv_dshkm", _vehiclePatrol] call BIS_fnc_spawnvehicle;
	sleep 0.3;
	_defendHq2 = [_vehiclePatrol, getPos _arty1, 300] call BIS_fnc_taskPatrol;
	sleep 0.3;

	(_vehicle1 select 0) setVehicleTIPars [0.7,0.4,0.3];
	(_vehicle2 select 0) setVehicleTIPars [0.7,0.4,0.3];
	_arty1 setVehicleTIPars [0.7,0.2,0.3];
	_arty2 setVehicleTIPars [0.7,0.2,0.3];

	//Tasking Order Creation and revealing marker
	_null = [west, "mob_arty", ["Must destroy two ISIS T72", "Destroy Tanks", "Destroy Tanks"], getMarkerPos "mob_arty", false] spawn BIS_fnc_taskCreate;
	_null = ["mob_arty", "CREATED"] spawn BIS_fnc_taskSetState;
	_markerAO setMarkerType "o_art";
	_markerAO setMarkerColor "ColorGreen";
	_markerAO setMarkerText "Mobile Arty";
	_markerAO setMarkerSize [1,1];
	waitUntil { !alive _arty1 && !alive _arty2 };
	_null = ["mob_arty", "SUCCEEDED"] spawn BIS_fnc_taskSetState;

	//this should wait until players are 100m away before despawning the objects, but I'm 99% sure it's wrong
	waitUntil 
	{
		{getMarkerPos (_markerAO) distance _x > 200 } count (playableUnits + switchableUnits) > 0
	};
	sleep 10;

	{
		sleep 0.3;
		deleteVehicle _x;
	} forEach units _grp1A;
	sleep 0.3;

	{
		sleep 0.3;
		deleteVehicle _x;
	} forEach units _armor;
	sleep 0.3;

	{
		sleep 0.3;
		deleteVehicle _x;
	} forEach units _vehiclePatrol;
	sleep 0.3;
	deleteVehicle (_vehicle1 select 0);
	sleep 0.3;
	deleteVehicle (_vehicle2 select 0);
	sleep 0.3;
	deleteGroup _grp1A;
	sleep 0.3;	
	deleteGroup _vehiclePatrol;
	sleep 0.3;	
	deleteGroup _armor;
	sleep 0.3;
	deleteMarker _markerAO;

	[_newPosHQ, 150] call ALIVE_fnc_removeComposition;
	sleep 0.3;
	_myHint ="Good Job!";
	GlobalHint = _myHint;
	publicVariable "GlobalHint";
	hintsilent parseText _myHint;

	_mySChat ="OBJECTIVE COMPLETED";
	GlobalSCHat = _mySChat;
	publicVariable "GlobalSCHat";
	player sideChat _mySChat;
	
	[west, "mob_arty"] call LARs_fnc_removeTask;
};

fn_spawnCasMission = {

	hint "Stand by for tasking order...";
	//creating the marker 

	//Finding empty locations for possable spawn points
	_newPosHQ = [_mrkSpawnSite, 0, 100, 15, 0, 8, 0] call BIS_fnc_findSafePos;
	_newPos1 = [_newPosHQ, 30, 60, 10, 0, 10, 0] call BIS_fnc_findSafePos;
	_newPos2 = [_newPos1, 10, 30, 10, 0, 10, 0] call BIS_fnc_findSafePos;
	_newPos3 = [_newPos2, 10, 30, 10, 0, 10, 0] call BIS_fnc_findSafePos;
	_newPos4 = [_newPos3, 10, 30, 10, 0, 10, 0] call BIS_fnc_findSafePos;

	_markerAO = createMarker ["mob_cas", _newPosHQ];
	_markerAO setMarkerType "Empty";
	sleep 0.3;
	
	[_newPosHQ, "Military", "fuel", "OPF_F", "Small", 0] call ALIVE_fnc_spawnRandomPopulatedComposition;
	//_mhq = createVehicle ["Land_Cargo_HQ_V2_F",[(getMarkerpos _markerAO select 0) + 1, getMarkerpos _markerAO select 1,0],[], 0, "NONE"];
	
	//creating the objectives vehicles
	_tanques1 = createGroup INDEPENDENT;
	[_newPos1, 10, "cfp_i_is_T72_flag", _tanques1] call BIS_fnc_spawnvehicle;
	sleep 3;
	[_newPos2, 10, "cfp_i_is_T55", _tanques1] call BIS_fnc_spawnvehicle;
	sleep 3;
	[_newPos3, 10, "cfp_i_is_T55", _tanques1] call BIS_fnc_spawnvehicle;
	sleep 3;
	[_newPos4, 10, "cfp_i_is_T55", _tanques1] call BIS_fnc_spawnvehicle;
	sleep 3;
	nul = [_tanques1, _markerAO, 150] call BIS_fnc_taskPatrol;

	{
		sleep 0.6;
		_veh = vehicle _x;
		_veh setVehicleTIPars [0.8,0.3,0.5];
	} forEach units _tanques1;
	
	//Revealing mission location on map
	_markerAO setMarkerType "o_armor";
	_markerAO setMarkerColor "ColorGreen";
	_markerAO setMarkerText "ISIS Armor Ptn";
	_markerAO setMarkerSize [1,1];
	_null = [west, "mob_cas", ["Destroy the ISIS armor platoon", "Destroy Armor", "Destroy Armor"], getMarkerPos "mob_cas", false] spawn BIS_fnc_taskCreate;
	_null = ["mob_cas", "CREATED"] spawn BIS_fnc_taskSetState;
	

	waitUntil {{ alive _x } count units _tanques1 <= 5}; 
	_null = ["mob_cas", "SUCCEEDED"] spawn BIS_fnc_taskSetState;

	waitUntil 
	{
		{getMarkerPos (_markerAO) distance _x > 200 } count (playableUnits + switchableUnits) > 0
	};

	{
		sleep 0.3;
		deleteVehicle _x;
	} forEach units _tanques1;
	sleep 0.3;
	[_newPosHQ, 150] call ALIVE_fnc_removeComposition;
	sleep 0.3;
	deleteMarker _markerAO;

	{
		sleep 0.3;
		deleteVehicle _x;
	} forEach units _tanques1;
	sleep 0.3;

	deleteGroup _tanques1;

	_myHint ="Good Job!";
	GlobalHint = _myHint;
	publicVariable "GlobalHint";
	hintsilent parseText _myHint;

	_mySChat ="OBJECTIVE COMPLETED";
	GlobalSCHat = _mySChat;
	publicVariable "GlobalSCHat";
	player sideChat _mySChat;
	
	[west, "mob_cas"] call LARs_fnc_removeTask;
};

fn_spawnConvoyMission = {

	hint "UPDATED AIR OPS";
	//creating the marker 

	_markerAO = createMarker ["mob_convoy", _mrkSpawnSite];
	_markerAO setMarkerType "o_support";
	_markerAO setMarkerColor "ColorGreen";
	_markerAO setMarkerText "Supply Convoy";
	_markerAO setMarkerSize [1,1];
	
	_null = [west, "mob_convoy", ["Attack and destroy the supply convoy", "Eliminate Convoy", "Eliminate Convoy"], getMarkerPos "mob_convoy", false] spawn BIS_fnc_taskCreate;
	_null = ["mob_convoy", "CREATED"] spawn BIS_fnc_taskSetState;
	
	sleep 30;

	//creating the vehicle
	
	_newPos = [getMarkerPos _markerAO, 500, 700, 10, 0, 0, 0] call BIS_fnc_findSafePos;
	
	_shed2 = createVehicle ["Land_Cargo_HQ_V2_F", [(getMarkerpos _markerAO select 0) + 10, getMarkerpos _markerAO select 1,0],[], 0, "NONE"];
	
	_convoy1 = createGroup INDEPENDENT;
	[_newPos, 10, "CFP_I_IS_Hilux_ZU_23_01", _convoy1] call BIS_fnc_spawnvehicle;
	nul = [_convoy1,getPos _shed2, 300] call BIS_fnc_taskPatrol;
	sleep 15;
	[_newPos, 10, "CFP_I_IS_Hilux_SPG_Armored_01", _convoy1] call BIS_fnc_spawnvehicle;
	sleep 15;
	[_newPos, 10, "cfp_i_is_Ural", _convoy1] call BIS_fnc_spawnvehicle;
	sleep 15;
	[_newPos, 10, "cfp_i_is_Ural", _convoy1] call BIS_fnc_spawnvehicle;
	sleep 15;
	[_newPos, 10, "cfp_i_is_Ural", _convoy1] call BIS_fnc_spawnvehicle;
	sleep 15;
	[_newPos, 10, "CFP_I_IS_Hilux_ZU_23_01", _convoy1] call BIS_fnc_spawnvehicle;

	waitUntil {{ alive _x } count units _convoy1 <= 5}; 

	if (configfile >> "CfgPatches" >> "ALiVE_main") then
	{
		_null = ["mob_convoy", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
	};

	waitUntil 
	{ 
		//this should wait until players are 100m away before despawning the objects, but I'm 99% sure it's wrong
		{getMarkerPos (_markerAO) distance _x > 100 } count (player + playableUnits + switchableUnits) > 0
	};
	sleep 10;

	deleteMarker _markerAO;
	sleep 0.3;
	deleteGroup _convoy1;
	sleep 0.3;
	deleteVehicle _shed2;

	_myHint ="Good Job!";
	GlobalHint = _myHint;
	publicVariable "GlobalHint";
	hintsilent parseText _myHint;

	_mySChat ="OBJECTIVE COMPLETED";
	GlobalSCHat = _mySChat;
	publicVariable "GlobalSCHat";
	player sideChat _mySChat;
	
	[west, "mob_convoy"] call LARs_fnc_removeTask;
};

fn_spawnPlacementMission = {

	hint "UPDATED AIR OPS";
	//creating the marker 

	_markerAO = createMarker ["mob_placement", _mrkSpawnSite];
	_markerAO setMarkerType "o_installation";
	_markerAO setMarkerColor "ColorGreen";
	_markerAO setMarkerText "Warehouse";
	_markerAO setMarkerSize [1,1];
	
	_null = [west, "mob_placement", ["Eliminate the OPFOR Depot.", "Eliminate Depot", "Eliminate Depot"], getMarkerPos "mob_placement", false] spawn BIS_fnc_taskCreate;
	_null = ["mob_placement", "CREATED"] spawn BIS_fnc_taskSetState;
	
	sleep 30;

	//creating the vehicle
	
	_newPos = [getMarkerPos _markerAO, 200, 300, 10, 0, 0, 0] call BIS_fnc_findSafePos;
	
	_warehouse = createVehicle ["WarfareBDepot",[(getMarkerpos _markerAO select 0) + 1, getMarkerpos _markerAO select 1,0],[], 0, "NONE"];
	_warehouse setDamage 0.9;
	_truck1 = createVehicle ["cfp_i_is_LR_M2",[(getMarkerpos _markerAO select 0) + 13, getMarkerpos _markerAO select 1,0],[], 0, "NONE"];
	
	//default line
	//_grp1A = [getMarkerPos _markerAO, EAST, (configfile >> "CfgGroups" >> "Indep" >> "LOP_ISTS" >> "Infantry" >> "I_C_Soldier_Bandit_4_F")] call BIS_fnc_spawnGroup;
	
	
	_grp1A = [getMarkerPos _markerAO, independent, ["cfp_i_is_irregular"]] call BIS_fnc_spawnGroup;
	nul = [_grp1A,getpos _warehouse] call BIS_fnc_taskDefend;
	
	_AA2 = createGroup INDEPENDENT;
	[_newPos, 10, "cfp_i_is_offroad_M2", _AA2] call BIS_fnc_spawnvehicle;
	nul = [_AA2,getPos _warehouse, 150] call BIS_fnc_taskPatrol;
	sleep 15;
	[_newPos, 10, "cfp_i_is_offroad_M2", _AA2] call BIS_fnc_spawnvehicle;

	waitUntil { !alive _warehouse };
	
	_null = ["mob_placement", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
	
	sleep 3;
	_sbomb1 = "R_60mm_HE" createVehicle (getPos _truck1);
	_truck1 setDammage 1;
	
	sleep 10;

	deleteMarker _markerAO;
	sleep 0.3;
	{deleteVehicle _x} forEach units _grp1A;
	sleep 0.3;
	{deleteVehicle _x} forEach units _AA2;
	sleep 0.3;
	deleteGroup _grp1A;
	sleep 0.3;
	deleteGroup _AA2;

	_myHint ="Good Job!";
	GlobalHint = _myHint;
	publicVariable "GlobalHint";
	hintsilent parseText _myHint;

	_mySChat ="OBJECTIVE COMPLETED";
	GlobalSCHat = _mySChat;
	publicVariable "GlobalSCHat";
	player sideChat _mySChat;
	
	[west, "mob_placement"] call LARs_fnc_removeTask;
};

// MAIN LOGIC

_missionDetails = switch (_missionType) do {
	case "arty": {call fn_spawnArtyMission;};
	case "cas": {call fn_spawnCasMission;};
	case "convoy": {call fn_spawnConvoyMission;};
	case "warehouse": {call fn_spawnPlacementMission;};
};