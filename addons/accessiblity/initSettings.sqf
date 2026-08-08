[
QGVAR(red), "COLOR",
["str_team_red"],
["CBA Accessiblity"],
[0.9, 0, 0, 1],
2, // setting can't be overwritten
{TRACE_1("red",_this);}
] call CBA_settings_fnc_init;

[
QGVAR(blue), "COLOR",
["str_team_blue"],
["CBA Accessiblity"],
[0, 0, 1, 1],
2, // setting can't be overwritten
{TRACE_1("blue",_this);}
] call CBA_settings_fnc_init;

[
QGVAR(green), "COLOR",
["str_team_green"],
["CBA Accessiblity"],
[0, 0.8, 0, 1],
2, // setting can't be overwritten
{TRACE_1("green",_this);}
] call CBA_settings_fnc_init;
