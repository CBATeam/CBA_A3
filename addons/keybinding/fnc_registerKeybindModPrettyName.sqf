#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerKeybindModPrettyName

Description:
    Associates a pretty name to a keybinding mod entry.

Parameters:
    _addonName  - Name of the registering mod [String]
    _prettyName - Pretty name of the mod (localized, etc) [String]

Returns:

Examples:
    (begin example)
        ["mymod", "My Cool Mod!"] call CBA_fnc_registerKeybindModPrettyName;
    (end example)

Author:
    Nou
---------------------------------------------------------------------------- */

params ["_addonName", "_prettyName"];

if (isNil QGVAR(modPrettyNames)) then {
    GVAR(modPrettyNames) = [] call CBA_fnc_createNamespace;
};

GVAR(modPrettyNames) setVariable [_addonName, _prettyName];

true
