#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getUnitLoadout

Description:
    Return the loadout of a unit with CBA_fnc_filterLoadout applied.

Parameters:
    _unit - Unit to get loadout of <OBJECT>

Returns:
    _loadout - `getUnitLoadout` array <ARRAY>

Examples:
    (begin example)
        private _loadout = [player] call CBA_fnc_getUnitLoadout;
    (end)

Author:
    SynixeBrett
---------------------------------------------------------------------------- */
SCRIPT(getUnitLoadout);

params [["_unit", objNull, [objNull]]];

if (_unit isEqualTo objNull) exitWith {[]};

[getUnitLoadout _unit] call CBA_fnc_filterLoadout
