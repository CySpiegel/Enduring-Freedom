// Part of ROS_PlaneRepair v1.5
// [] execvm "ROS_PlaneRepair\scripts\ROS_pOlight.sqf";

params ["_planePadlamp"];

if (isnil "ROS_rotpBeaconOn") then {
	ROS_rotpBeaconOn = false;
	publicVariable "ROS_rotpBeaconOn";
};

_rotpOlight = "Reflector_Cone_01_narrow_orange_F" createVehicleLocal [0,0,0];
_rotpOlight setPosATL (_planePadlamp modelToWorld [0,0,0.12]);

sleep 1;

while {true} do {

	if (ROS_rotpBeaconOn) then {
		if (isObjectHidden _rotpOlight) then {_rotpOlight hideObject false};
	} else {
		if !(isObjectHidden _rotpOlight) then {_rotpOlight hideObject true};
	};

	_rotpOlight setdir (getdir _rotpOlight +2);
	sleep 0.01;
};
