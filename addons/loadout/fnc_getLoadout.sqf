#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getLoadout
Description:
    Get a unit's extended loadout
Parameters:
    _unit - The unit to set the loadout on. <UNIT>
Returns:
    Extended Loadout <ARRAY>
Examples:
    (begin example)
        [player] call CBA_fnc_getLoadout
    (end)
Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

if (_unit isEqualTo objNull) exitWith {[]};

private _loadout = getUnitLoadout _unit;
private _extendedInfo = createHashMap;

{
    private _info = [_unit, _loadout] call _y;
    if !(isNil "_info") then {
        _extendedInfo set [_x, _info];
    };
} forEach GVAR(getHandlers);

[
    _loadout,
    _extendedInfo
]
