#include "script_component.hpp"
SCRIPT(XEH_preInit);

LOG(MSG_INIT);

ADDON = false;

#include "XEH_PREP.sqf"

[QGVAR(debug), {_this call CBA_fnc_debug}] call CBA_fnc_addEventHandler;

GVAR(projectileData) = [];
GVAR(projectileDrawHandle) = nil;
GVAR(projectileIndex) = 0;
GVAR(projectileMaxLines) = 20;
GVAR(projectileStartedDrawing) = false;
GVAR(projectileTrackedUnits) = [];

ADDON = true;
