/* ----------------------------------------------------------------------------
Function: CBA_fnc_formatVersionNumber

Description:
    Converts array to pretty version number.

Parameters:
    _versionNumber - Array with numbers representing a version number <ARRAY>

Example:
    (begin example)
        [3,5,1] call CBA_fnc_formatVersionNumber
        -> "v.3.5.1"
    (end)

Returns:
    _versionNumber - formatted version number <STRING>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(formatVersionNumber);

[_this] params [["_versionAr", [], [[]]]];

"v" + ((_versionAr apply {_x call CBA_fnc_formatNumber}) joinString ".")
