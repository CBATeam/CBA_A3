/* ----------------------------------------------------------------------------
Function: CBA_fnc_compareVersions

Description:
    Compares two version numbers.

Parameters:
    _expectedVersion - Expected version number <ARRAY>
    _localVersion    - Current version number <ARRAY>

Example:
    (begin example)
        [[3,4,3], [3,5,0]] call CBA_fnc_compareVersions // true
        [[3,5,0], [3,5,0]] call CBA_fnc_compareVersions // true
        [[3,5,1], [3,5,0]] call CBA_fnc_compareVersions // false
    (end)

Returns:
    _success - true: local version is at least the expected version, false: local version is older than the expected version <BOOLEAN>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(compareVersions);

params [["_expectedVersion", [], [[]]], ["_localVersion", [], [[]]]];

private _return = true;

{
    private _y = _localVersion param [_forEachIndex, 0];

    if (_x < _y) exitWith {}; // passed
    if (_x > _y) exitWith { // failed
        _return = false;
    };
} forEach _expectedVersion;

_return
