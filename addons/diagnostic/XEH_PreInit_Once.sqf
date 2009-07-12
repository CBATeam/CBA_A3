#include "script_component.hpp"
LOG("Initializing: " + QUOTE(ADDON));

[GVAR(debug), { _this call CBA_fnc_debug }] call CBA_fnc_addEventHandler;
