#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addLoadoutGetHandler
Description:
    Add a handler for CBA_fnc_setLoadout.
Parameters:
    _id - The id of the handler. <STRING>
    _function - The function you wish to execute. <CODE>
Passed Arguments:
    _this <ARRAY>
        0: _unit - The unit to set the loadout on. <UNIT>
        1: _loadout - The unit's loadout <ARRAY>
Returns:
    true if a previous handler existed, false otherwise. <BOOLEAN>
Examples:
    (begin example)
        ["earplugs", {
            params ["_unit"];
            [_unit] call my_earplug_mod_fnc_hasEarplugs;
        }] call CBA_fnc_addLoadoutGetHandler;
    (end)
Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params [
    ["_id", "", [""]],
    ["_function", {}, [{}]]
];

if (_id isEqualTo "") exitWith {-1};

GVAR(getHandlers) set [_id, _function];
