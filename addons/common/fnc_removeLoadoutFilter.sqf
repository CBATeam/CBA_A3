#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeLoadoutFilter

Description:
    Remove a handler that you have added using CBA_fnc_addLoadoutFilter.

Parameters:
    _handle - The function handle you wish to remove. <NUMBER>

Returns:
    true if removed successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _handle = [myLoadoutFilter] call CBA_fnc_addLoadoutFilter;
        sleep 10;
        [_handle] call CBA_fnc_removeLoadoutFilter;
    (end)

Author:
    Nou & Jaynus, SynixeBrett
---------------------------------------------------------------------------- */

params [["_handle", -1, [0]]];

[{
    params ["_handle"];

    private _index = GVAR(filterLoadoutHandles) param [_handle];
    if (isNil "_index") exitWith {false};

    GVAR(filterLoadoutHandles) set [_handle, nil];
    (GVAR(filterLoadoutArray) select _index) set [0, {}];

    if (GVAR(filterLoadoutToRemove) isEqualTo []) then {
        {
            {
                GVAR(filterLoadoutArray) set [_x, objNull];
            } forEach GVAR(filterLoadoutToRemove);

            GVAR(filterLoadoutArray) = GVAR(filterLoadoutArray) - [objNull];
            GVAR(filterLoadoutToRemove) = [];

            {
                _x params ["", "_index"];
                GVAR(filterLoadoutHandles) set [_index, _forEachIndex];
            } forEach GVAR(filterLoadoutArray);
        } call CBA_fnc_execNextFrame;
    };

    GVAR(filterLoadoutToRemove) pushBackUnique _index;
    true
}, _handle] call CBA_fnc_directCall;
