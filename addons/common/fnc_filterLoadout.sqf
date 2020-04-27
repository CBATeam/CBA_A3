#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_filterLoadout
Description:
    Used to filter a getUnitLoadout array.
Parameters:
    _loadout - getUnitLoadout array <ARRAY>
Example:
    (begin example)
        _loadout = [getUnitLoadout player] call CBA_fnc_filterLoadout;
    (end)
Returns:
    filtered getUnitLoadout array <ARRAY>
Author:
    SynixeBrett
---------------------------------------------------------------------------- */
SCRIPT(filterLoadout);

params [["_loadout", [], [[]]]];

{
    _loadout = [_loadout] call _x;
} forEach GVAR(loadoutFilters);

_loadout
