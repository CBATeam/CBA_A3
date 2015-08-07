/* ----------------------------------------------------------------------------
Function: CBA_fnc_nearPlayer

Description:
    Check whether these are any players within a certain distance of a unit.

Parameters:
    _unit:       the unit to check the distance from. [Object]
    _distance:   the desired distance. [Number]

Returns:
    Boolean - true if there are any players within the given
                  distance of the unit, false if there aren't.


Examples:
    (begin example)
    [unit, distance] call CBA_fnc_nearPlayer
    (end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(nearPlayer);

params ["_unit","_distance"];

private "_position";
_position = _unit call CBA_fnc_getpos;
{
    if ((_position distance _x) < _distance) exitWith { true };
    false;
} forEach ([] call CBA_fnc_players);
