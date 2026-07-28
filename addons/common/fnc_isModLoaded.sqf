#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_isModLoaded
Description:
    Check in CfgPatches if an addon is loaded

Parameters:
    _modName - Classname of the mod in CfgPatches <STRING>

Returns:
    True if addon is loaded, otherwise false <BOOL>

Examples
    (begin example)
        "class" call CBA_fnc_isModLoaded
    (end)

Authors:
    Glowbal, Grim
---------------------------------------------------------------------------- */
SCRIPT(isModLoaded);
params [["_modName", "", [""]]];

GVAR(isModLoadedCache) getOrDefaultCall [toLowerANSI _modName, { isClass (configFile >> "CfgPatches" >> _modName) }, true]
