/*
This script is part of ROS_PlaneRepair - by RickOshay

LEGAL STUFF
Credit must be given in your mission and on the Steam Workshop if this script is used in any mission or
derivative works. There are three dependent scripts: ROS_PlaneRepair.sqf, ROS_Welder.sqf, ROSWaveinPlane.sqf.
They must be kept together.

Place a unit 30m behind a helipad (center) facing the direction the plane will approach from.

👨 Repairer  👨 wave in unit

        	  ↑ 30m

       		  □ helipad

       		  ↑
       		 🛧 inbound plane

There must be a square heli pad placed >=30m in front of the 'wavein' unit.
Copy the ROS_PlaneRepair folder to your mission root.
Place the following line in the wavein units init field:
[this] execvm "ROS_PlaneRepair\scripts\ROS_waveinPlane.sqf";

*/

_waveinPunit = _this select 0;

if !(local _waveinPunit) exitWith {};

// Suported helipad must be "Land_HelipadSquare_F" or it will be auto replaced

_nHeliPads = [];
_nHeliPad = objNull;
_maxHPvalue = 0;
_vehDamage = 0;
_vehFuel = 0;

_clLH = objNull;
_clRH = objNull;
_wiLightsAdded = false;
_waveOutP = false;

if (count units group _waveinPunit >1) then {_waveinPunit join grpNull};

_nHeliPads = nearestObjects [_waveinPunit, ["HeliH"], 35];
if (count _nHeliPads >0) then {_nHeliPad = _nHeliPads select 0}; nHeliPad = _nHeliPad; // remove
// If wrong helipad - replace it
if (typeOf _nHeliPad != "Land_HelipadSquare_F") then {
	_pos = getposatl _nHeliPad;
	_dir = _nHeliPad getdir _waveinPunit;
	deleteVehicle _nHeliPad;
	_nHeliPad = "Land_HelipadSquare_F" createVehicle _pos;
	_nHeliPad setDir _dir;
};
if (isNull _nHeliPad) exitWith {hint "There is no nearby helipad within (~30m) of the repair unit";};

_dir = _waveinPunit getDir _nHeliPad;
_pos = _nHeliPad getPos [-30, _dir];
_waveinPunit setPosATL _pos;
_waveinPunit setdir (_waveinPunit getDir _nHeliPad);

_nearestPlane = objNull;
_nearestPlanes = [];

_waveinPunit setUnitPos "up";
_pwep = primaryWeapon _waveinPunit;
_waveinPunit removeWeapon _pwep;
_waveinPunit setBehaviour "careless";
_waveinPunit disableaI "move";
_waveinPunit disableAI "anim";
[_waveinPunit, "amovpercmstpsnonwnondnon"] remoteExec ["switchMove", 0];
[_waveinPunit, false] remoteExec ["allowDamage",0];

// Place red light on vest
_c1 = "Chemlight_red" createVehicle [0,0,0];
_c1 attachTo [_waveinPunit, [0,0,1]];

// Place white light in front
_lightw = "#lightpoint" createVehicleLocal [0,0,0];
_lightw setLightBrightness 0.1;
_lightw setLightColor[1, 1, 1];
_lightw lightAttachObject [_waveinPunit, [0,0.7,0.7]];

ROS_addlights_Fnc = {
	params ["_waveinPunit"];
	if (!_wiLightsAdded) then {
		// Add red lights to hands
		_clLH = "Chemlight_red" createVehicle [0,0,0];
		_clRH = "Chemlight_red" createVehicle [0,0,0];
		_clLH attachTo [_waveinPunit, [0,-0.01,0.08], "Lefthand"];
		_clRH attachTo [_waveinPunit, [-0.03,-0.01,0.04], "Righthand"];
		_clLH setVectorDirAndUp [[0,0,-1],[0,1,0]];
		_clRH setVectorDirAndUp [[0,0,-1],[0,1,0]];
		_wiLightsAdded = true;
	};
	true
};

while {true} do {
	// Look for planes nearby and wave them in
	_nearestPlanes = nearestObjects [_waveinPunit,["plane"],70];
	if (count _nearestPlanes >0) then {
		_nearestPlane = _nearestPlanes select 0; nplane = _nearestPlane; // remove
	} else {
		_nearestPlane == objNull;
	};

	if (!isnull _nearestPlane) then {
		if !(getAllHitPointsDamage _nearestPlane isEqualTo []) then {
			_vehDamage = selectMax ((getAllHitPointsDamage _nearestPlane) select 2);
			_vehFuel = fuel _nearestPlane;
		} else {
			_vehDamage = 0;
			_nearestPlane setfuel 1;
			_vehFuel =1;
		};

		if (isTouchingGround _nearestPlane && _nearestPlane distance _waveinPunit <= 70) then {

			// Wave In
			if (_nearestPlane distance _nHeliPad > 10) then {
				_waveOutP = false;
			} else {
				_waveOutP = true;
			};

			if !(_waveOutP) then {
				if (_nearestPlane distance _nHeliPad > 10 && [position _nearestPlane, getDir _nearestPlane, 30, position _nHeliPad] call BIS_fnc_inAngleSector) then {
					[_waveinPunit] call ROS_addlights_Fnc;
					_waveinPunit setdir (_waveinPunit getdir _nearestPlane);
					[_waveinPunit, "Acts_JetsMarshallingStraight_loop"] remoteExec ["switchMove", 0];
					sleep 2;
				};
			} else {
				// Force stop and engine off
				[_nearestPlane, false] remoteExec ["engineOn", player];
				[_nearestPlane, false] remoteExec ["enableSimulationGlobal",2];
				_nearestPlane setVelocity [0, 0, 0];
				sleep 1;
				_nearestPlane setPos (getpos _nHeliPad);
				_nearestPlane setPosATL (getPosATL _nearestPlane);
				// Wave Out
				[_waveinPunit, "Acts_NavigatingChopper_out"] remoteExec ["switchMove", 0];
				sleep 5;
				_waveinPunit doWatch _nearestPlane;
				// Remove red lights
				_nearestClights = nearestObjects [_waveinPunit,["Chemlight_red"],2];
				if (count _nearestClights >0) then {{deleteVehicle _x} foreach _nearestClights};
				ROS_WiLightsAdded = false;
				[_waveinPunit, ""] remoteExec ["switchMove", 0];
				sleep 0.3;
				[_nearestPlane, true] remoteExec ["enableSimulationGlobal",2];
				if (getAllHitPointsDamage _nearestPlane isEqualTo []) then {hint "This plane is not supported\nit has no damage hitpoints!";};
				waitUntil {_nearestPlane distance _nHeliPad > 10};
			};
		};
	};
	sleep 1;
};

