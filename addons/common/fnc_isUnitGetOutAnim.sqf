/* ----------------------------------------------------------------------------
Function: CBA_fnc_isUnitGetOutAnim

Description:
    Checks whether a unit is turned out in a vehicle or not.

    DEPRECATED. Use isTurnedOut instead.

Parameters:
    _unit - Unit to check [Object]

Returns:
    "true" for turned out or "false" for not turned out [Boolean]

Examples:
    (begin example)
        if ( [player] call CBA_fnc_isUnitGetOutAnim ) then
        {
            player sideChat "I am turned out!";
        };
    (end)

Author:
    (c) Denisko-Redisko
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(isUnitGetOutAnim);

params ["_unit"];

isTurnedOut _unit
