#include "script_component.hpp"
["Initializing...", QUOTE(ADDON), DEBUG_SETTINGS] call CBA_fnc_debug;

[GVAR(debug), { _this call CBA_fnc_debug }] call CBA_fnc_addEventHandler;
