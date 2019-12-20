if (!isserver) exitwith {};

_shooter = _this select 0;
_victim = _this select 1;

diag_log format ["***TEAMDAMAGE*** - %1 damaged %2 at %3 seconds elapsed with %4", (name _shooter), (name _victim), time, (currentweapon _shooter)];