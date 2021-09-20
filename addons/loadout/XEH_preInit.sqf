#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.sqf"

GVAR(getHandlers) = createHashMap;
GVAR(setHandlers) = createHashMap;

ADDON = true;
