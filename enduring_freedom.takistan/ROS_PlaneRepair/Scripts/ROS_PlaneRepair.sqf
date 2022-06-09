/*

ROS Plane repair v1.5 - by RickOShay

Supports all planes in Arma 3 / DLCs / RHS / SOG
Plane must have hitpoints - most CUP planes are therefore not supported.

LEGAL STUFF
Credit must be given in your mission and on the Steam Workshop if this script is used in any mission or
derivative works. There are three dependent scripts: ROS_PlaneRepair.sqf, ROS_WelderPlane.sqf, ROSWavein.sqf.
They must be kept together.

USAGE:
Recommended - copy the demo hangar including the props and units and helipad etc. (Hangar requires SOG CDLC) into your mission or save as Composition - note you will need the ROS_PlaneRepair folder and CFgSounds entries in description.ext as well.

In the editor drop down a square helipad where the plane will be repaired.

You must use the large square pad - and make sure its direction points to the wavein unit (see ROS_waveinplane script header).
Likewise make sure the wavein unit points to the center of the helipad. The wavein unit must be at least 30m directly behind the the helipad.
Place a Repair AI unit 30m behind the helipad (from helipad center) facing the helipad in the direction of incoming planes
and ~3m to the LHS of the wavein unit.
Repair unit must be in his own group and be a minimum of 30m from the helipad.

👨 repair unit 👨 wavein unit

               ↑ 30m

               □ helipad center  → 25m ⛟ (auto spawned fuel truck, refueler & fuel pipe - see options below)

               ↑
               🛧 inbound plane

Place the following line in the Repair units init field:
[this] execvm "ROS_PlaneRepair\scripts\ROS_PlaneRepair.sqf";

Copy the ROS_PlaneRepair folder to your mission root.
Add the sound classes from the provided description.ext to Cfg_Sound in your description.ext.

For added effect use the ROS_wavein.sqf script to have a unit wave in the taxiing plane.
See that included script's header for instructions.

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Auto add Refuel Truck, Fuel Pipes &  Refueler to the right hand side of the helipad. Default ON = true             */

_addRefuelItems = true;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////// DO NOT MAKE CHANGES BELOW THIS LINE //////////////////////////////////////////////// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


if (!isServer) exitWith {};

params ["_pRepairer"];

// helipad types (HeliH)
//_helipads = ["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadEmpty_F","Land_HelipadRescue_F","Land_HelipadSquare_F","HeliH","HeliHCivil","Heli_H_civil","HeliHEmpty","HeliHRescue","Heli_H_rescue"];

// Only ROS plane repair only supports helipad type "Land_HelipadSquare_F".

_npHeliPads = [];
_npHeliPad = objNull;
_fptruck = objNull;
_wplight = objNull;
_cta = false;
_nWeldingRod = objnull;
_nWeldingCart = objNull;
ROSPlaneRepaired = false;
publicVariable "ROSPlaneRepaired";
ROSPlaneRefueled = false;
publicVariable "ROSPlaneRefueled";
ROS_rotpbeaconOn = false;
publicVariable "ROS_rotpbeaconOn";
_prepaircase = objNull;
_initPos = getPosATL _pRepairer;
_nearestPlane = objNull;
_npHeliPads = [];
_planeDamage = 0;
_planeFuel = 0;
_vehType = "";
_firstposp = [0,0,0];
_repposp = [0,0,0];

// Disable damage on repairer
_pRepairer allowDamage false;

_npHeliPads = nearestObjects [_pRepairer, ["Land_HelipadSquare_F"], 35];
if (count _npHeliPads >0) then {_npHeliPad = _npHeliPads select 0};
if (isNull _npHeliPad) exitWith {hint "There is no nearby helipad within (~30m) of the repair unit";};
// Don't change the helipad orientation - it will be automatically pointed at the waveinUnit. See ROS_WaveInPlane.sqf script header.
_dir = _pRepairer getDir _npHeliPad;
_pos = _npHeliPad getPos [-30, _dir-1];
_pRepairer setPosATL _pos;
_pRepairer setdir _dir;
_initPos = getPosATL _pRepairer;

// Light center helipad
_planePadlamp = "PortableHelipadLight_01_red_F" createVehicle [0,0,0];
_planePadlamp setpos (_npHeliPad modeltoworld [0,0,-0.1]);
_planePadlamp enableSimulationGlobal false;
_planePadlamp allowdamage false;
_planePadlamp setdir (getdir _pRepairer);

// Oil spill on helipad
_oil1 = "Oil_Spill_F" createVehicle [0,0,0];
_oil1 setpos (_planePadlamp modeltoworld [0,1.5,0]);

// Place red light on vest
_r1 = "Chemlight_red" createVehicle [0,0,0];
_r1 attachTo [_pRepairer, [0,0.1,0], "Spine3"];

ROS_rotpBeaconOn = false;
publicVariable "ROS_rotpBeaconOn";

sleep 1;

// Add Rotating Orange light on all clients
[[_planePadlamp],"ROS_PlaneRepair\scripts\ROS_pOlight.sqf"] remoteExec ["execVM", 0, true];

_hitpartType = ["#c svetlo","#cabin_light","#cabin_light1","#cabin_light2","#cabin_light3","#cam_gunner","#cargo_light_1","#cargo_light_2","#cargo_light_3","#cargo_light_4","#gear_1_light_1_hit","#gear_1_light_2_hit","#gear_2_light_1_hit","#gear_3_light_1_hit","#gear_3_light_2_hit","#gear_f_lights","#glass11","#hitlight1","#hitlight2","#hitlight3","#l svetlo","#l2 svetlo","#light_1","#light_1_hit","#light_1_hitpoint","#light_2","#light_2_hit","#light_2_hitpoint","#light_3_hit","#light_4_hit","#light_f","#light_fg125","#light_g","#light_hd_1","#light_hd_2","#light_hitpoint","#light_l","#light_l_flare","#light_l_hitpoint","#light_l2","#light_l2_flare","#light_r","#light_r_flare","#light_r_hitpoint","#light_r2","#light_r2_flare","#p svetlo","#p2 svetlo","#reverse_light_hit","#rl_nav_illum","#rl_op_red_illum","#rl_op_teal_illum","#rl_remspot_illum","#searchlight","#svetlo","#t svetlo","#wing_left_light","#wing_right_light","armor_composite_65","glass_pod_01_hitpoint","hit_ammo","hit_optic_crows_day","hit_optic_driver","hit_optic_sosnau","hitatgmsight","hitbody","hitduke1","hitengine","hitfuel","hitfuel_l","hitfueltank_left","hitglass1","hithrotor","hithull","hithull_structural","hitlfwheel","hitvrotor","hitwindshield_1","armor_composite_40","armor_composite_50","armor_composite_60","armor_composite_70","armor_composite_75","armor_composite_80","armor_composite_85","armor_composite_95","glass_1_hitpoint","glass_10_hitpoint","glass_11_hitpoint","glass_12_hitpoint","glass_13_hitpoint","glass_14_hitpoint","glass_15_hitpoint","glass_16_hitpoint","glass_17_hitpoint","glass_18_hitpoint","glass_19_hitpoint","glass_2_hitpoint","glass_20_hitpoint","glass_3_hitpoint","glass_4_hitpoint","glass_5_hitpoint","glass_6_hitpoint","glass_7_hitpoint","glass_8_hitpoint","glass_9_hitpoint","glass_pod_02_hitpoint","glass_pod_03_hitpoint","glass_pod_04_hitpoint","glass_pod_05_hitpoint","glass_pod_06_hitpoint","hit_ammo","hit_gps_headmirror","hit_gps_optical","hit_gps_tis","hit_light_l","hit_light_r","hit_lightl","hit_lightr","hit_longbow","hit_optic_1g46","hit_optic_1k13","hit_optic_1k13","hit_optic_9s475","hit_optic_citv","hit_optic_comcwss","hit_optic_comm2","hit_optic_comperiscope","hit_optic_comperiscope1","hit_optic_comperiscope2","hit_optic_comperiscope3","hit_optic_comperiscope4","hit_optic_comperiscope5","hit_optic_comperiscope6","hit_optic_comperiscope7","hit_optic_comsight","hit_optic_crows_day","hit_optic_crows_day","hit_optic_crows_lrf","hit_optic_crows_ti","hit_optic_driver","hit_optic_driver_rear","hit_optic_driver1","hit_optic_driver2","hit_optic_driver3","hit_optic_dvea","hit_optic_essa","hit_optic_gps","hit_optic_gps_ti","hit_optic_loaderperiscope","hit_optic_mainsight","hit_optic_nsvt","hit_optic_periscope","hit_optic_periscope1","hit_optic_periscope2","hit_optic_periscope3","hit_optic_periscope4","hit_optic_pnvs","hit_optic_sosnau","hit_optic_tads","hit_optic_tkn3","hit_optic_tkn3","hit_optic_tkn4s","hit_optic_tpd1k","hit_optic_tpn4","hit_optics_cdr_civ","hit_optics_cdr_peri","hit_optics_dvr_dve","hit_optics_dvr_peri","hit_optics_dvr_rearcam","hit_optics_gnr","hitaasight","hitammo","hitammohull","hitavionics","hitbattery_l","hitbattery_r","hitbody","hitcomgun","hitcomsight","hitcomturret","hitcontrolrear","hitdoor_1_1","hitdoor_1_2","hitdoor_2_1","hitdoor_2_2","hitduke1","hitduke2","hitengine","hitengine_1","hitengine_2","hitengine_3","hitengine_4","hitengine_c","hitengine_l1","hitengine_l2","hitengine_r1","hitengine_r2","hitengine1","hitengine2","hitengine3","hitengine4","hitfuel","hitfuel_l","hitfuel_lead_left","hitfuel_lead_right","hitfuel_left","hitfuel_left_wing","hitfuel_r","hitfuel_right","hitfuel_right_wing","hitfuel2","hitfuell","hitfuelr","hitfueltank","hitfueltank_left","hitfueltank_right","hitgear","hitglass1","hitglass10","hitglass11","hitglass12","hitglass13","hitglass14","hitglass15","hitglass16","hitglass17","hitglass18","hitglass19","hitglass1a","hitglass1b","hitglass2","hitglass20","hitglass21","hitglass3","hitglass4","hitglass5","hitglass6","hitglass7","hitglass8","hitglass9","hitgun","hitgun1","hitgun2","hitgun3","hitgun4","hitguncom","hitguncomm2","hitgunlauncher","hitgunloader","hitgunnsvt","hithood","hithrotor","hithstabilizerl1","hithull","hithull_structural","hithydraulics","hitlaileron","hitlaileron_link","hitlauncher","hitlbwheel","hitlcelevator","hitlcrudder","hitlf2wheel","hitlfwheel","hitlglass","hitlight","hitlightback","hitlightfront","hitlightl","hitlightr","hitlmwheel","hitlrf2wheel","hitltrack","hitmainsight","hitmissiles","hitperiscope1","hitperiscope10","hitperiscope11","hitperiscope12","hitperiscope13","hitperiscope14","hitperiscope2","hitperiscope3","hitperiscope4","hitperiscope5","hitperiscope6","hitperiscope7","hitperiscope8","hitperiscope9","hitperiscopecom1","hitperiscopecom2","hitperiscopegun1","hitperiscopegun2","hitperiscopegun3","hitperiscopegun4","hitpylon1","hitpylon10","hitpylon11","hitpylon2","hitpylon3","hitpylon4","hitpylon5","hitpylon6","hitpylon7","hitpylon8","hitpylon9","hitraileron","hitraileron_link","hitrbwheel","hitrelevator","hitreservewheel","hitrf2wheel","hitrfwheel","hitrglass","hitrightrudder","hitrmwheel","hitrotor","hitrotor1","hitrotor2","hitrotor3","hitrotor4","hitrotor5","hitrotor6","hitrotorvirtual","hitrrudder","hitrtrack","hitsearchlight","hitspare","hitstarter1","hitstarter2","hitstarter3","hittail","hittransmission","hitturret","hitturret1","hitturret2","hitturret3","hitturret4","hitturretcom","hitturretcomm2","hitturretlauncher","hitturretloader","hitturretnsvt","hitvrotor","hitvstabilizer1","hitwinch","hitwindshield_2","ind_hydr_l","ind_hydr_r","indicatoreng1","indicatoreng2","indicatoroil1","indicatoroil2","usespare","warningaileron","warningelevator"];

_hitpartText = ["Light","Cabin Light","Cabin Light","Cabin Light","Cabin Light","Cam Gunner","Cargo Light","Cargo Light","Cargo Light","Cargo Light","Gear Light","Gear Light","Gear Light","Gear Light","Gear Light","Gear Light","Glass","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Searchlight","Light","Light","Light","Light","Armor","Glass","Ammo","Optics","Optics","Optics","Sight","Body","Duke","Engine Part","Fuel","Fuel","Fuel","Glass","Rotor","Hull","Hull","Wheel","Rotor","Windshield","Armor","Armor","Armor","Armor","Armor","Armor","Armor","Armor","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Ammo","Mirror","GPS","GPS","Light","Light","Light","Light","Longbow","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Sight","Ammo","Ammo","Avionics","Battery","Battery","Body","Gun","Sight","Turret","Control","Door","Door","Door","Door","Duke","Duke","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel Tank","Fuel Tank","Fuel Tank","Gear","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Gun","Gun","Gun","Gun","Gun","Gun","Gun","Gun","Gun","Gun","Hood","Rotor","Stabilizer","Hull","Hull","Hydraulics","Aileron","Aileron","Launcher","Wheel","Elevator","Rudder","Wheel","Wheel","Glass","Light","Light","Light","Light","Light","Wheel","Wheel","Track","Sight","Missiles","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Aileron","Aileron","Wheel","Elevator","Wheel","Wheel","Wheel","Glass","Rudder","Wheel","Rotor","Rotor","Rotor","Rotor","Rotor","Rotor","Rotor","Rotor","Rudder","Track","Searchlight","Spare","Starter","Starter","Starter","Tail","Transmission","Turret","Turret","Turret","Turret","Turret","Turret","Turret","Turret","Turret","Turret","Rotor","Stabilizer","Winch","Windshield","Hydraulics","Hydraulics","Indicator Engine","Indicator Engine","Indicator Oil","Indicator Oil","Spare","Aileron","Elevator"];

// Remove repairer NVGoggles
_pRepairer unassignitem "nvgoggles";
_pRepairer removeitem "nvgoggles";

if (_addRefuelItems) then {
	_dir = getDir _pRepairer;
	_fptruckpos = _npHeliPad modeltoworld [21.8721,-1.82813,0];
	_fptruck = createvehicle ["C_Van_01_fuel_F", _fptruckpos, [], 0, "CAN_COLLIDE"];
	_fptruck setpos _fptruckpos;
	_fptruck setdir (_fptruck getdir _npHeliPad)-180;
	_fptruck setposatl (getpos _fptruck);
	_fptruck enableSimulationGlobal false;

	// White spotlight rear of Ftruck
	_wplight = "Reflector_Cone_01_narrow_white_F" createVehicle [0,0,0];
	_wplight setpos (_fptruck modelToWorld [-0.1,-3.48,0.855]);
	_wplight setdir (_wplight getdir _npHeliPad);
	_wplight hideObjectGlobal true;

	sleep 1;
	_refueler = "B_engineer_F" createvehicle [0,0,0];
	_refueler setpos (_fptruck modeltoworld [2.5,-2.5,-1.7]);
	_refueler setdir (_refueler getdir _npHeliPad);
	[_refueler, "Acts_CivilIdle_1"] remoteExec ["switchMove", _refueler];

	// Place white light in front or refueler
	_lightp = "#lightpoint" createVehicleLocal [0,0,0];
	_lightp setLightBrightness 0.1;
	_lightp setLightColor[1, 1, 1];
	_lightp lightAttachObject [_refueler, [0,0.7,0.7]];

	removeAllWeapons _refueler;
	removeAllItems _refueler;
	removeAllAssignedItems _refueler;
	removeVest _refueler;
	removeBackpack _refueler;
	removeHeadgear _refueler;
	_refueler addVest "V_DeckCrew_violet_F";
	_refueler addHeadgear "H_MilCap_gry";
	_refueler disableAI "move";
	_refueler setBehaviour "careless";
};

// Create fuel pipes
ROS_PlaneFuelPipes_Fnc = {
	params ["_veh"];
	PhoseV = createVehicle ["LayFlatHose_01_StraightShort_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	Phose0 = createVehicle ["LayFlatHose_01_CurveShort_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	Phose1 = createvehicle ["LayFlatHose_01_CurveLong_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	Phose2 = createvehicle ["LayFlatHose_01_SBend_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	Phose3 = createvehicle ["LayFlatHose_01_SBend_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	Phose4 = createvehicle ["LayFlatHose_01_SBend_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	Phose5 = createVehicle ["LayFlatHose_01_CurveShort_F", [0,0,0], [], 0, "CAN_COLLIDE"];

	Phose2 attachto [Phose1,[-0.55,-5,0]];
	Phose3 attachto [Phose2,[0.86,-5,0]];
	Phose4 attachto [Phose3,[0.86,-5,0]];
	Phose1 setdir (getdir _fptruck +180);
	Phose5 attachto [Phose4,[0.43,-3.1,0.47]];
	Phose5 setdir (getdir Phose4-140);
	Phose5 setvectorup [1,0,0];
	Phose0 attachto [Phose1,[1.4,2.9,0.47]];
	Phose0 setvectorUp [-0.5,0.5,0];
	Phose0 setvectorDir [0.149259,0.988798,0];
	if (!(typeof _veh find "I_C_Plane_Civil_01" >-1) or (typeof _veh find "C_Plane_Civil_01_F" >-1)) then {
		PhoseV attachto [Phose0,[1,0.63,0]];
		PhoseV setvectordirandup [[1,0,0],[1,1,0]];
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

ROS_Repair_plane_fnc_completed = false;
publicVariable "ROS_Repair_plane_fnc_completed";

ROS_Repair_plane_fnc = {
	params ["_pRepairer", "_veh", "_initPos,", "_hitpartType", "_hitpartText", "_npHeliPad", "_addRefuelItems", "_fptruck", "_wplight"];

	_rdist = 0;
	_pilot = driver _veh;
	_hitpartDesc = "";
	_allHPvalues = [];
	_pweldingrod = objnull;
	_pweldingCart = objNull;
	_prepaircase = objNull;

	// Switch on rotating orange pad light
	ROS_rotpBeaconOn = true;
	publicVariable "ROS_rotpBeaconOn";

	// Repair the PLANE
	[""] remoteExec ["hint", _pilot];

	// Create Repaircase
	_prepaircase = "Land_PlasticCase_01_small_F" createVehicle (getPosATL _pRepairer);
	_prepaircase enableSimulationGlobal false;
	_prepaircase setposatl (_pRepairer modelToWorld [0.5,-0.2,-0.5]);
	_prepaircase setdir (getdir _pRepairer +10);

	//Switch engine off
	_timer = time +8;

	[[_veh, _pilot], ["exitvehicle", 50]] remoteExec ["say3D", _pilot];

	[_veh, false] remoteExec ["engineOn", _veh];

	waitUntil {
		_veh setVelocity [0,0,0];
		// Some aircrafts have strange damage configs and may explode when force stopped
		if (damage _veh > 0.8) then {_veh setDamage 0.7;};
		(time >_timer);
	};

	[_veh, false] remoteExec ["setPilotLight", _veh];

	[""] remoteExec ["hint", _pilot];

	sleep 2;

	waitUntil {speed _veh <0.1};

	// if vehicle overruns helipad force it back on pos
	if (_veh distance _npHeliPad >1) then {
		_veh setPosATL (getPosATL _npHeliPad);
		sleep 0.25;
		_veh setPosATL (getPosATL _veh);
		if (damage _veh > 0.8) then {_veh setDamage 0.7;};
	};

	// Kick player
	if (isplayer _pilot && vehicle _pilot == _veh) then {
		[_pRepairer, "If the engine and lights are still on switch them off and Exit the vehicle."] remoteExec ["sidechat", _pilot];
		["If the engine and lights are still on\nswitch them off and Exit the vehicle."] remoteExec ["hint", _pilot];
		_pilot action ["getOut", _veh];
		waitUntil {vehicle _pilot == _pilot};
		sleep 1;
		[""] remoteExec ["hint", _pilot];
	};

	// Lock Vehicle
	if (isPlayer _pilot && !(vehicle _pilot == _pilot)) then {[_veh, true] remoteExec ["lock", _veh]};

	_pRepairer setBehaviour "careless";
	_pRepairer setspeedMode "limited";
	_pRepairer allowFleeing 0;
	_pRepairer allowDamage false;

	// [hitpointsNamesArray, selectionsNamesArray, damageValuesArray]
	_allHPnames = ((getAllHitPointsDamage _veh) select 0);
	_allHPvalues = ((getAllHitPointsDamage _veh) select 2);
	_numDamHP = {_x >0} count _allHPvalues;

	sleep 1;

	// Attach repair case to repairer's hand
	_prepaircase setdir (getdir _pRepairer -5);
	_prepaircase attachto [_pRepairer,[0.01,-0.06,-0.21],"RightHandMiddle1"];

	// Get approx size of hull
	_bbr = 0 boundingBoxReal _veh;
	_ba1 = _bbr select 0;
	_ba2 = _bbr select 1;
	_bsd = _bbr select 2; // sphere diameter
	_maxW = abs ((_ba2 select 0) - (_ba1 select 0));
	_maxL = abs ((_ba2 select 1) - (_ba1 select 1));

	if (_maxL > _maxW) then {_maxW = _maxL};

	_repposp = [0,0,0];
	_xoffSet = 0;

	// Create moveto positions
	_firstposp = _veh getPos [_maxW-3, (getdir _veh)+70];

	// A3 / RHS / FIR / SOG (CUP planes without HP are not supported)
	if ("B_Plane_CAS_01" in typeof _veh) then {_xoffSet =2.2;};
	if ("B_Plane_Fighter_01" in typeof _veh) then {_xoffSet =2;};
	if ("A10" in typeof _veh) then {_xoffSet =2.2;};
	if ("F22" in typeof _veh or "F23A" in typeof _veh or "F35" in typeof _veh or "F14" in typeof _veh or "F15" in typeof _veh or "F16" in typeof _veh or "F18" in typeof _veh or "FA18" in typeof _veh or "SU34" in typeof _veh or "FIR_AV8B" in typeof _veh or "JAS39" in typeof _veh) then {
		_xoffSet =1.85;
		_firstposp = _veh getPos [10, (getdir _veh)+70];
	};
	if ("Su25" in typeof _veh) then {
		_xoffSet =2; xoffset = _xoffSet; //remove
		_firstposp = _veh getPos [10, (getdir _veh)+70];
	};
	if ("F2A" in typeof _veh) then {
		_xoffSet =2;
		_firstposp = _veh getPos [8, (getdir _veh)+70];
	};
	if ("AN2" in typeof _veh) then {
		_xoffSet = 2.5;
		_firstposp = _veh getPos [9, (getdir _veh)+70];
	};
	if ("vn_b_air_f4b" in typeof _veh) then {_xoffSet =2.4;};
	if ("vn_b_air_f4c" in typeof _veh) then {_xoffSet =2;};
	if ("O_Plane_CAS_02" in typeof _veh) then {_xoffSet =2;};
	if ("O_Plane_Fighter" in typeof _veh) then {_xoffSet =2.1;};
	if ("O_T_VTOL_02" in typeof _veh) then {_xoffSet =2.5;};
	if ("I_Plane_Fighter_03" in typeof _veh) then {_xoffSet =2;};
	if ("I_Plane_Fighter_04" in typeof _veh) then {_xoffSet =2;};
	if ("I_C_Plane_Civil_01" in typeof _veh) then {_xoffSet =2.2;};
	if ("C_Plane_Civil" in typeof _veh or "I_Plane_ION" in typeOf _veh or "C_Plane_Orbit" in typeOf _veh) then {_xoffSet = 2.2;};
	if ("C130J" in typeof _veh) then {
		_xoffSet =3.5;
		_firstposp = _veh getPos [18, (getdir _veh)+70];
	};
	if ("B_T_VTOL_01" in typeof _veh) then {
		_xoffSet = 4;
		_firstposp = _veh getPos [18, (getdir _veh)+70];
	};
	if ("c17" in typeof _veh or "c-17" in typeof _veh) then {
		_xoffSet = 4;
		_firstposp = _veh getPos [18, (getdir _veh)+70];
	};

	_vehLen = 0 boundingBoxReal _veh select 1 select 1;

	if (_xoffSet >=0) then {
		_pos = _veh modelToWorld [_xoffSet,(_vehLen)*0.5,0];
		_repposp = [_pos select 0, _pos select 1, 0];
	} else {
		_pos = _veh modelToWorld [(_maxW/3.6),(_vehLen)*0.6,0];
		_repposp = [_pos select 0, _pos select 1, 0];
	};

	// Move to first pos
	_pRepairer enableai "move";
	_pRepairer domove _firstposp;

	waitUntil {_pRepairer distance _firstposp <3.5};

	_pRepairer setdir (getdir _veh)-90;
	_pRepairer disableAI "anim";
	_pRepairer setDir (_pRepairer getDir _repposp);

	// Forced walk to reppos
	_maxD = (_firstposp distance _repposp);
	while {_pRepairer distance _repposp >0.1 && alive _veh && !(_pRepairer distance _firstposp > _maxD)} do {
		_pRepairer playMoveNow "amovpercmwlksnonwnondf";
		sleep 0.0001;
	};

	_pRepairer setdir (_pRepairer getdir _veh)+40;

	_pRepairer switchMove "";
	_pRepairer setposatl _repposp;

	// Place Toolbox
	_pRepairer playactionnow "takeflag";
	sleep 0.5;
	detach _prepaircase;
	_pRepairer playMoveNow "amovpercmstpsnonwnondnon";
	_prepaircase setposatl (_pRepairer modelToWorld [0.5,0.1,0]);
	_prepaircase setdir (getdir _pRepairer +10);
	_prepaircase enableSimulationGlobal false;

	sleep 1;

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// Start REPAIR AND OR REFUEL
	if (selectMax _allHPvalues >=0.1 or damage _veh >0.05) then {

		// Create welding cart
		_pweldingCart = createVehicle ["Land_WeldingTrolley_01_F", (position _pRepairer), [], 0, "CAN_COLLIDE"];
		_pweldingCart setposatl (_pRepairer modelToWorld [-1,-0.2,0]);

		_pweapon = primaryWeapon _pRepairer;
		_sweapon = secondaryWeapon _pRepairer;
		{_pRepairer removeWeapon _x} foreach [_pweapon,_sweapon];

		sleep 2;

		// Create welding tool
		_pweldingRod = createVehicle ["Land_TorqueWrench_01_F", (position _pRepairer), [], 0, "NONE"];
		_pweldingRod attachto [_pRepairer,[-0.05,0.15,-0.02],"RightHandMiddle1"];
		_pweldingRod setVectorDirAndUp [[0,-0.1,1],[1,0,0]];
		_pRepairer disableai "anim";
		_pRepairer switchmove "Acts_Examining_Device_Player";

		// Repair - welding effects exec on all machines except ded server
		[[_pilot, _pRepairer, _veh, _pweldingRod, _pweldingCart, _prepaircase],"ROS_PlaneRepair\scripts\ROS_Pwelder.sqf"] remoteExec ["BIS_fnc_execVM", [0,-2] select isDedicated, true];

		sleep 8;

		// Delay for repairing HP type
		_aveSecPerHP = 1.5;
		_secEngine = 4;
		_secFuel = 2;
		_secRotor = 3;
		_secHull = 5;
		_secGlass = 2;
		_delay = _aveSecPerHP;

		// Repair HPs
		for "_i" from 0 to (_numDamHP-1) do {
			_hp = _allHPnames select _i;
			if ("engine" in _hp) then {_delay = _secEngine};
			if ("fuel" in _hp) then {_delay = _secFuel};
			if ("rotor" in _hp) then {_delay = _secRotor};
			if ("hull" in _hp) then {_delay = _secHull};
			if ("glass" in _hp) then {_delay = _secGlass};
			if (!("engine" in _hp) && !("fuel" in _hp) && !("rotor" in _hp) && !("hull" in _hp) && !("glass" in _hp)) then {_delay = _aveSecPerHP};

			_hpdamage = _allHPvalues select _i;
			{if (_hpdamage>0 && _hp find _x>-1) then {_hitpartDesc = toUpper (_hitpartText select _foreachindex)}} foreach _hitpartType;

			if (_hpdamage >0) then {
				if (isplayer _pilot) then {[format ["Repairing: %1", _hitpartDesc]] remoteExec ["hint", _pilot]};
			};
			[_veh, _hp, 0, true] call BIS_fnc_setHitPointDamage;
			if (_i == _numDamHP-1) exitWith {
				_veh setdamage 0;
				sleep 0.3;
				// Kill sound obj
				deletevehicle _pweldingCart;
				_snd = nearestObject [_pRepairer, "#soundonvehicle"];
				deleteVehicle _snd;
				{if (typeOf _x == "#particlesource") then {deleteVehicle _x}} forEach (_veh nearObjects 7);
				ROSPlaneRepaired = true;
				publicVariable "ROSPlaneRepaired";
			};
			sleep _delay;
		};

		if (isplayer _pilot) then {["Repair completed"] remoteExec ["hint", _pilot];};

		sleep 1.5;

		// Remove weldingrod
		_pweldingrod = (attachedObjects _pRepairer) select 1;
		if(!isnull _pweldingrod) then {deleteVehicle _pweldingrod};

		_pRepairer playMoveNow "amovpercmstpsnonwnondnon";

		sleep 2;
	}; // end Repair

	/////////////////////////////////////////////////////////////////////////////////////////////////////

	// Start Refuel
	_fInc = 0;
	_fveh = fuel _veh;

	sleep 1;

	[_pRepairer, "Acts_JetsCrewaidLCrouch_in"] remoteExec ["switchMove", 0];

	if (fuel _veh <=0.9) then {
		if (_addRefuelItems) then {
			sleep 0.5;
			Phose1 setpos (_fptruck modelToWorld [2.9,-16.2,-1.84]);
		};

		sleep 1;

		if (isplayer _pilot) then {["The vehicle is being refueled Sir"] remoteExec ["hint", _pilot]};
		[[Phose1, _pilot], ["refuel_startP", 50]] remoteExec ["say3D", 0];
		sleep 2;
		for "_i" from _fveh to 1 step 0.1 do {
			[[Phose1, _pilot], ["refuel_loopP", 50]] remoteExec ["say3D", 0];
			sleep 5;
			if (isplayer _pilot) then {[format ["Refueling: %1 %2", ((fuel _veh)*100) toFixed 1, '%']] remoteExec ["hint", _pilot]};
			if (_i<1) then {[_veh, ((fuel _veh)+0.1)] remoteExec ["setfuel", _veh]};
		};
		[[Phose1, _pilot], ["refuel_endP", 50]] remoteExec ["say3D", 0];
		if (isplayer _pilot) then {["Refueled: 100.0"] remoteExec ["hint", _pilot]};
		[_veh, 1] remoteExec ["setfuel", _veh];
	} else {
		// Top up
		[_veh, 1] remoteExec ["setfuel", _veh];
	}; // end fuel < 0.9

	sleep 1;

	ROSPlaneRefueled = true;
	publicVariable "ROSPlaneRefueled";

	sleep 1;

	/////////////////////////////////////////////////////////////////////////////////////////////////////

	// Clean up
	if (_addRefuelItems && !isNull Phose1) then {
		{deleteVehicle _x; sleep 0.1;} forEach [PhoseV,Phose0,Phose1,Phose2,Phose3,Phose4,Phose5];
	};

	waitUntil {isnull Phose5};

	deleteVehicle _prepaircase;

	[_pRepairer, "Acts_JetsCrewaidLCrouch_out"] remoteExec ["switchMove", 0];

	sleep 2;

	[_pRepairer, "amovpercmstpsnonwnondnon"] remoteExec ["switchMove", 0];

	_nWeldingRod = nearestObject [_pRepairer, "Land_TorqueWrench_01_F"];
	_nWeldingCart = nearestObject [_pRepairer, "Land_WeldingTrolley_01_F"];
	if (!isNull _nWeldingRod) then {deleteVehicle _nWeldingRod};
	sleep 1;
	if (!isNull _nWeldingCart) then {deleteVehicle _nWeldingCart};
	sleep 1;

	[[_pRepairer, _pilot], ["RepairedSirP", 20]] remoteExec ["say3D", 0];
	_vehType = getText(configFile>>"CfgVehicles">>(typeOf _veh)>>"DisplayName");
	if (isplayer _pilot) then {
		[_pRepairer, true] remoteExec ["setRandomLip", 0];
		// Turn to face player
		_pRepairer disableAI "move";
		_tb = _pRepairer getdir _pilot;
		_cb = getdir _pRepairer;
		_ad = round (_tb - _cb + 540) mod 360 -180;
 		_inc = 0;
		if (_ad <0) then {_inc -1} else {_inc =1};
	   	for "i" from 0 to _ad step _inc do {
	   		_pRepairer setdir (_cb + i);
	    	sleep 0.001;
	    };

		[_veh, format ["%1 has been repaired and refueled Sir", _vehType]] remoteExec ["sidechat", _pilot];
		[format ["%1 has been\nrepaired and refueled Sir", _vehType]] remoteExec ["hint", _pilot];
		sleep 0.7;
		[_pRepairer, false] remoteExec ["setRandomLip", 0];
		_pRepairer enableAI "move";
		["Wait until repair personnel\nhave cleared the repair area."] remoteExec ["hint", _pilot];
	};

	// Unlock Vehicle
	if (isPlayer _pilot) then {[_veh, false] remoteExec ["lock", _veh]};

	_pRepairer enableai "anim";
	_pRepairer enableai "move";

	_wp0 = (group _pRepairer) addWaypoint [_initPos, 0];
	_wp0 setWaypointType "MOVE";
	_pRepairer setspeedMode "limited";

	waitUntil {_pRepairer distance _initPos <3};
	[""] remoteExec ["hint", _pilot];
	sleep 1;

	_pRepairer setdir (_pRepairer getdir _npHeliPad);
	_pRepairer disableAI "MOVE";

	ROSPlaneRefueled = true;
	publicVariable "ROSPlaneRefueled";
	ROSPlaneRepaired = true;
	publicVariable "ROSPlaneRepaired";

	// Switch off Fuel truck spotlight and rot orange light when no near heli
	if (vehicle _pilot == _veh) then {
		_wplight hideObjectGlobal true;
		// Switch off orange repair light
		ROS_rotpBeaconOn = false;
		publicVariable "ROS_rotpBeaconOn";
	};

	ROS_Repair_plane_fnc_completed = true;
	publicVariable "ROS_Repair_plane_fnc_completed";

}; // End ROS_Repair_plane_fnc


/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////


// Find nearest damaged Plane
while {true} do {

	// Is pad clear - if not remove debris
	_neardead = allDead select {_x distance _npHeliPad <20};
	if (count _neardead>0) then {
		["Please hold while we clear the debris"] remoteExec ["hint", (driver _nearestPlane)];
		sleep 5;
		{deletevehicle _x; sleep 1;} foreach _neardead;
	};

	// Look for planes nearby and repair them
	_nPlanes = nearestObjects [_pRepairer,["plane"],100];
	if (count _nPlanes >0) then {
		_nearestPlane = _nPlanes select 0;
	} else {
		_nearestPlane == objNull;
	};

	_nhangarObjects = nearestObjects [_npHeliPad,[
		"Land_vn_airport_02_hangar_left_f","Land_vn_airport_02_hangar_right_f","Land_Hangar_F","Land_TentHangar_V1_F","Land_Airport_01_hangar_F","Land_Ss_hangard","Land_Ss_hangar","Land_vn_airport_01_hangar_f","Land_vn_usaf_hangar_01","Land_vn_usaf_hangar_02","Land_vn_usaf_hangar_03"],30];

	// Exit if plane too large and repair bay in hangar - rotate 180 - stop hangar block
	if (!isNull _nearestPlane && isTouchingGround _nearestPlane && 0 boundingBoxReal _nearestPlane select 2 >20) then {
		if (count _nhangarObjects>0) exitWith {
			["STOP !","This plane is too large to enter the hangar!"] remoteExec ["hintC", (driver _nearestPlane)];

			["Vehicle Rotating ..."] remoteExec ["hint", (driver _nearestPlane)];
			// Rotate plane
			[_nearestPlane, false] remoteExec ["engineOn", _nearestPlane];
			_nearestPlane setPosATL (getPosATL _nearestPlane);
			[_nearestPlane, false] remoteExec ["allowDamage", _nearestPlane];
			_sdir = getdir _nearestPlane;
			_edir = (getdir _nearestPlane +180);
			for "_i" from _sdir to _edir do {
				_nearestPlane setdir _i;
				sleep 0.01;
			};
			sleep 1;
			[_nearestPlane, true] remoteExec ["allowDamage", _nearestPlane];
		};
	};

	if (!isNull _nearestPlane && isTouchingGround _nearestPlane) then {

		if (getAllHitPointsDamage _nearestPlane isEqualTo []) then {["This plane does not have hitpoints\nand is therefore not supported."] remoteExec ["hint", (driver _nearestPlane)]};

		// special cases where getAllHitPointDamage returns [];
		if (getAllHitPointsDamage _nearestPlane isEqualTo []) then {
			_planeDamage = damage _nearestPlane;
		} else {
			_planeDamage = selectMax ((getAllHitPointsDamage _nearestPlane) select 2);
		};

		_planeFuel = fuel _nearestPlane;

		// Max allowed distance from helipad center (cannot be too large - allow for repairer pathing)
		_pDist = 12;

		if (_planeFuel <0.9 or _planeDamage >=0.1) then {
			if (isplayer (driver _nearestPlane)) then {
				[format ["Bay distance: %1m Target %2m", (round (_nearestPlane distance _npHeliPad)), _pDist]] remoteExec ["hint" , (driver _nearestPlane)];
			};
			if !(_cta) then {
				if (isPlayer (driver _nearestPlane)) then {
					[[_nearestPlane, (driver _nearestPlane)], ["ClearedApproach", 50]] remoteExec ["say3D", (driver _nearestPlane)];
					sleep 0.5;
					_cta =true;
				};
			};
		};

		if (_planeFuel >=0.9 && (_planeDamage <0.1 or damage _nearestPlane <0.1)) then {
			if (_nearestPlane distance _npHeliPad <= _pDist) then {
				if (isplayer (driver _nearestPlane)) then {
					["This vehicle does not need\nto be repaired or refueled.\nPlease vacate the repair bay.\nThank you!"] remoteExec ["hint", (driver _nearestPlane)]
				};
				sleep 2;
				// Rotate if in hangar
				if (count _nhangarObjects>0) then {
					if (vehicle (driver _nearestPlane) == (driver _nearestPlane)) then {
						["Please board your vehicle\nVehicle will then be rotated\n\nDO NOT MOVE THE VEHICLE\nUNTIL ROTATION COMPLETE."] remoteExec ["hint", (driver _nearestPlane)];
					} else {
						["Vehicle rotation will now commence.\n\nDO NOT MOVE THE VEHICLE\nUNTIL ROTATION COMPLETE."] remoteExec ["hint", (driver _nearestPlane)];
					};
					waitUntil {vehicle (driver _nearestPlane) == _nearestPlane};
					sleep 3;
					0 fadeSpeech 2;
					[[_planePadlamp, (driver _nearestPlane)], ["rotate", 50]] remoteExec ["say3D", 0];
					hint "Vehicle Rotating ...";
					[_nearestPlane, false] remoteExec ["engineOn", _nearestPlane];
					[_nearestPlane, true] remoteExec ["enableSimulationGlobal", 2];
					_nearestPlane setPosATL (getPosATL _npHeliPad);
					sleep 0.3;
					_sdir = getdir _nearestPlane;
					_edir = getdir _pRepairer +8;
					for "_i" from _sdir to _edir step 0.5 do {
						_nearestPlane setdir _i;
						sleep 0.01;
					};
					0 fadeSpeech 2;
					waitUntil {isengineOn _nearestPlane};
				};
				_nearestPlane setdamage 0;
				[_nearestPlane, 1] remoteExec ["setfuel", _nearestPlane];
				sleep 2;
				hint "Good day!";
				[[_nearestPlane, (driver _nearestPlane)], ["hangarcomms", 50]] remoteExec ["say3d", (driver _nearestPlane)];
				waitUntil {vehicle (driver _nearestPlane) == _nearestPlane};
				sleep 5;
				// Switch off orange repair light
				ROS_rotpbeaconOn = false;
				publicVariable "ROS_rotpbeaconOn";
				[""] remoteExec ["hint", (driver _nearestPlane)];
			};
		}; // plane not damaged / doesnt need fuel > exit

		// Slow plane down and stop
		if (_nearestPlane distance _npHeliPad >= (_pDist*2) && (_planeFuel <0.9 or _planeDamage >=0.1)) then {
			waitUntil {
				_nearestPlane limitSpeed 5;
				(_nearestPlane distance _npHeliPad <= _pDist)
			};
			_nearestPlane setVelocity [0,0,0];
		};

		//Switch on spotlight on rear of fuel truck
		if (isObjectHidden _wplight && _addRefuelItems) then {_wplight hideObjectGlobal false;};

		// Prepare fuel pipes
		[_nearestPlane] call ROS_PlaneFuelPipes_Fnc;

		// Start repair/refuel if fuel (<0.9) or vehicle damage (any hp>0.1)
		if (_nearestPlane distance _npHeliPad <= _pDist && (_planeFuel <0.9 or _planeDamage >=0.1)) then {
			if (isplayer (driver _nearestPlane)) then {["Aligning with repair bay"] remoteExec ["hint", (driver _nearestPlane)]};
			// Force stop and engine off
			[_nearestPlane, false] remoteExec ["engineOn", _nearestPlane];
			[_nearestPlane, false] remoteExec ["enableSimulationGlobal", 2];
			sleep 2;
			[_nearestPlane, true] remoteExec ["enableSimulationGlobal", 2];
			_nearestPlane setPos (getPos _npHeliPad);
			[_pRepairer, _nearestPlane, _initPos, _hitpartType, _hitpartText, _npHeliPad, _addRefuelItems, _fptruck, _wplight] call ROS_Repair_plane_fnc;
			_cta = false;

			// Switch off orange repair light
			ROS_rotpBeaconOn = false;
			publicVariable "ROS_rotpBeaconOn";
		};

		waitUntil {ROS_Repair_plane_fnc_completed};

	}; // !isnull nearestheli


	sleep 1;

}; // end while
