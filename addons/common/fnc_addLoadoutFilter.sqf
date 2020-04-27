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
Returns:
    Nothing.
Examples:
    Remove the radio from loadouts
    (begin example)
        [{
            params ["_loadout"];
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

GVAR(loadoutFilters) pushBack [ _function];
