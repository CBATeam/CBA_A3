#include "script_component.hpp"
SCRIPT(XEH_preInit);

LOG(MSG_INIT);

ADDON = false;

[QGVAR(debug), {_this call CBA_fnc_debug}] call CBA_fnc_addEventHandler;

ADDON = true;
