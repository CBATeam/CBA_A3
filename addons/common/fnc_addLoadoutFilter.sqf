#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addLoadoutFilter
Description:
    Add a filter for CBA_fnc_getUnitLoadout.
Parameters:
    _function - The function you wish to execute. <CODE>
Passed Arguments:
    _this <ARRAY>
        0: _loadout - A getUnitLoadout array
        1: _handle - A number representing the handle of the function. Same as '_handle' returned by this function. <NUMBER>
Returns:
    _handle - A number representing the handle of the function. Use this to remove the filter. <NUMBER>
Examples:
    Remove the radio from loadouts
    (begin example)
        _handle = [{
            params ["_loadout", "_handle"];
            if ((_loadout select 9) select 2 == "ItemRadio") then {
                (_loadout select 9) set [2, ""];
            };
            _loadout
        }] call CBA_fnc_addLoadoutFilter;
    (end)
Author:
    SynixeBrett
---------------------------------------------------------------------------- */

params [["_function", {}, [{}]]];

if (_function isEqualTo {}) exitWith {-1};

GVAR(loadoutFilterId) = GVAR(loadoutFilterId) + 1;
GVAR(loadoutFilters) setVariable [str GVAR(loadoutFilterId), _function];

GVAR(loadoutFilterId)
