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

// A regular loadout array was passed in
if (count _loadout == 10) exitWith {
    _unit setUnitLoadout [_loadout, _fullMagazines];
};

_unit setUnitLoadout [_loadout select 0, _fullMagazines];

private _extendedInfo = _loadout select 1;
if (_extendedInfo isEqualType []) then { _extendedInfo = createHashMapFromArray _extendedInfo; };

["CBA_loadoutSet", [_unit, _loadout, _extendedInfo]] call CBA_fnc_localEvent;
