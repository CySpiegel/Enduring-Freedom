//Hiding helper objects
{hideObject _x} forEach (allMissionObjects "Sign_Arrow_Direction_Green_F");

BIS_holdActionSFX = (getArray (configFile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0, ""];
BIS_holdActionSFX = BIS_holdActionSFX + ".wss";
BIS_holdActionProgress = 
{
	private _progressTick = _this select 4; 
	if ((_progressTick % 2) == 0) exitwith {}; 

	private _coef = _progressTick / 24; 
	playSound3D [BIS_holdActionSFX, player, false, getPosASL player, 1, 0.9 + 0.2 * _coef];
};

/* //disabled due to pathing issue
["a3\missions_f_orange\video\LAWS_OF_WAR.ogv", localize "STR_A3_Orange_Showcase_LawsOfWar_titlecard"] spawn BIS_fnc_Titlecard;
waitUntil {!(isNil "BIS_fnc_titlecard_finished")};
*/


//Other monitors
{
	private _lightPoint = createVehicle ["#lightpoint", getPosASL _x, [], 0, "CAN_COLLIDE"];
	_lightPoint setLightAmbient [0.1, 0.1, 0.1]; 
	_lightPoint setLightColor [0.8, 0.8, 0.8];
	_lightPoint setLightBrightness 0.3;
	deleteVehicle _x;
} forEach [BIS_light_1, BIS_light_2, BIS_light_3, BIS_light_4, BIS_light_5, BIS_light_6, BIS_light_7, BIS_light_8, BIS_light_9, BIS_light_10];