if (isdedicated) exitwith {};

_shooter = _this select 0;
_victim = _this select 1;

if !(_shooter == player) exitwith {};

_shooter groupchat format ["TEAM DAMAGE - YOU DAMAGED %1",(name _victim)];