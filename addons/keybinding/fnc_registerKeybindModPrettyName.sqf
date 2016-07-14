/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerKeybindModPrettyName

Description:
 Associates a pretty name to a keybinding mod entry.

Parameters:
 _modName            - Name of the registering mod [String]
 _prettyName        - Pretty name of the mod (localized, etc) [String]

Returns:

Examples:
    (begin example)
 ["mymod", "My Cool Mod!"] call CBA_fnc_registerKeybindModPrettyName;
    (end example)

Author:
 Nou
---------------------------------------------------------------------------- */
#include "script_component.hpp"
params ["_mod","_prettyName"];

private ["_modIndex"];

_modIndex = (GVAR(modPrettyNames) select 0) find _mod;
if(_modIndex == -1) then {
    _modIndex = (GVAR(modPrettyNames) select 0) pushBack _mod;
};

(GVAR(modPrettyNames) select 1) set[_modIndex, _prettyName];

true
