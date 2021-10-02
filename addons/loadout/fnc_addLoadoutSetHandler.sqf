#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addLoadoutSetHandler
Description:
    Add a handler for CBA_fnc_setUnitLoadout.
Parameters:
    _id - The id of the handler. <STRING>
    _function - The function you wish to execute. <CODE>
    _default - The default value when the get handler return nil <ANY>
Passed Arguments:
    _this <ARRAY>
        0: _unit - The unit to set the loadout on. <UNIT>
        1: _params - The parameters stored by CBA_fnc_getLoadout. <ARRAY>
Returns:
    Nothing.
Examples:
    (begin example)
        ["earplugs", {
            params ["_unit", "_state"];
            if (_state) then {
                [_unit] call my_earplug_mod_fnc_giveEarplugs;
            } else {
                [_unit] call my_earplug_mod_fnc_removeEarplugs;
            };
        }] call CBA_fnc_addLoadoutSetHandler;
    (end)
Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params [
    ["_id", "", [""]],
    ["_function", {}, [{}]],
    "_default"
];

if (_id isEqualTo "") exitWith {-1};

if !(_id in (GVAR(setHandlers))) then {
    GVAR(setHandlers) set [_id, []];
};

(GVAR(setHandlers) get _id) pushBack [_function, _default];
