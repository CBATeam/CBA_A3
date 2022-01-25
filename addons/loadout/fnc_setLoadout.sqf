#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_setLoadout
Description:
    Set a unit's extended loadout
Parameters:
    _unit - The unit to set the loadout on. <UNIT>
    _loadout - The extended loadout to set. <ARRAY>
    _fullMagazines - Partially emptied magazines will be refilled when the loadout is applied. <BOOL>
Returns:
    Nothing
Examples:
    (begin example)
        [player] call CBA_fnc_setLoadout
    (end)
Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_loadout", [], [[]]],
    ["_fullMagazines", false, [false]]
];

if (isNull _unit) exitWith {};

_unit setUnitLoadout [_loadout select 0, _fullMagazines];

private _extendedInfo = createHashMapFromArray (_loadout select 1);

{
    private _id = _x;
    {
        _x params ["_function", "_default"];
        [_unit, _extendedInfo getOrDefault [_id, _default]] call _function;
    } forEach _y;
} forEach GVAR(setHandlers);
