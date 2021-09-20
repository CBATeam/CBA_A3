#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeLoadoutSetHandler
Description:
    Remove a handler for CBA_fnc_setUnitLoadout.
Parameters:
    _id - The id of the handler. <STRING>
    _index - The index of the handler. <NUMBER>
Returns:
    Nothing.
Examples:
    (begin example)
        MY_HANDLER = ["earplugs", {
            params ["_unit", "_state"];
            if (_state) then {
                [_unit] call my_earplug_mod_fnc_giveEarplugs;
            } else {
                [_unit] call my_earplug_mod_fnc_removeEarplugs;
            };
            ["earplugs", MY_HANDLER] call CBA_fnc_removeLoadoutSetHandler;
        }] call CBA_fnc_removeLoadoutSetHandler;
    (end)
Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params [
    ["_id", "", [""]],
    ["_index", -1, [0]]
];

if (_id isEqualTo "") exitWith {false};
if (_index isEqualTo -1) exitWith {false};

if !(_id in (GVAR(setHandlers))) exitWith {false};

(GVAR(setHandlers) get _id) set [_index, {}];

true
