#include "script_component.hpp"
["Initializing...", QUOTE(ADDON), DEBUGSETTINGS] call CBA_fnc_Debug;

[GVAR(debug), { _this call CBA_fnc_debug }] call CBA_fnc_addEventHandler;
