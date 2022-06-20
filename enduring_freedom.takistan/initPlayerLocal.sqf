["acex_fortify_objectPlaced", {
	[ALiVE_SYS_LOGISTICS, "updateObject", [(_this select 2)]] call ALIVE_fnc_logistics;
	["ACE_Fortify_budget_change", []] call CBA_fnc_serverEvent;
}] call CBA_fnc_addEventHandler;

["acex_fortify_objectDeleted", {
	[ALiVE_SYS_LOGISTICS, "removeObject", [(_this select 2)]] call ALIVE_fnc_logistics;
	["ACE_Fortify_budget_change", []] call CBA_fnc_serverEvent;
}] call CBA_fnc_addEventHandler;

_action = ["ASO_Logistics_Update", "Save Position", "", {
	[ALiVE_SYS_LOGISTICS, "updateObject", [_target]] call ALiVE_fnc_logistics;
	hintSilent "Position saved!";
}, {true}] call ace_interact_menu_fnc_createAction;


["Reammobox_F", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;


nul = [player] execVM "scripts\check.sqf";
if (!isServer && (player != player)) then { waitUntil {player == player}; waitUntil {time > 10}; };

[] spawn 
{
    titleText ["Cytreen Spiegel presents...", "BLACK IN",9999];
    0 fadesound 0;

    private ["_cam","_camx","_camy","_camz","_object"];
    _start = time;

    waituntil {(player getvariable ["alive_sys_player_playerloaded",false]) || ((time - _start) > 20)};
    sleep 10;

    _object = player;
    _camx = getposATL player select 0;
    _camy = getposATL player select 1;
    _camz = getposATL player select 2;

    _cam = "camera" CamCreate [_camx -500 ,_camy + 500,_camz+450];

    _cam CamSetTarget player;
    _cam CameraEffect ["Internal","Back"];
    _cam CamCommit 0;

    _cam camsetpos [_camx -15 ,_camy + 15,_camz+3];

    titleText ["A L i V E   |  E N D U R I N G  F R E E D O M", "BLACK IN",10];
    10 fadesound 0.9;
    _cam CamCommit 20;
    sleep 5;
    sleep 15;

    _cam CameraEffect ["Terminate","Back"];
    CamDestroy _cam;

    sleep 1;

    _title = "<t size='1.2' color='#68a7b7' shadow='1'>Mission</t><br/>";
    _text = format["%1<t>Perform recon to gain intelligence and combat the insurgency</t>",_title];

    ["openSideSmall",0.4] call ALIVE_fnc_displayMenu;
    ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

    sleep 15;

    _title = "<t size='1.2' color='#68a7b7' shadow='1'>Group Management</t><br/>";
    _text = format["%1<t>Press U to open Group Manager</t>",_title];

    ["openSideSmall",0.4] call ALIVE_fnc_displayMenu;
    ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

    sleep 15;

    _title = "<t size='1.2' color='#68a7b7' shadow='1'>Sandsotrm Advisory</t><br/>";
    _text = format["%1<t>Wear Eye Protection</t>",_title];

    ["openSideSmall",0.4] call ALIVE_fnc_displayMenu;
    ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;
};