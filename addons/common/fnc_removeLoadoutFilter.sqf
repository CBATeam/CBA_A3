#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeLoadoutFilter
Description:
    Remove a handler that you have added using CBA_fnc_addLoadoutFilter.
Parameters:
    _handle - The function handle you wish to remove. <NUMBER>
Returns:
    Nothing
Examples:
    (begin example)
        _handle = [myLoadoutFilter] call CBA_fnc_addLoadoutFilter;
        sleep 10;
        [_handle] call CBA_fnc_removeLoadoutFilter;
    (end)
Author:
    SynixeBrett
---------------------------------------------------------------------------- */

params [["_handle", -1, [0]]];

if (_handle isEqualTo -1) exitWith {-1};

GVAR(loadoutFilters) setVariable [str _handle, nil];
