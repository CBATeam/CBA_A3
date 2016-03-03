/* ----------------------------------------------------------------------------
Function: CBA_fnc_nearPlayer

Description:
    Check whether these are any players within a certain distance of a unit.

Parameters:
    _unit     - the entity to check the distance from. <OBJECT>
    _distance - the desired distance. <NUMBER>

Returns:
    true if there are any players within the given distance of the unit, false if there aren't. <BOOLEAN>

Examples:
    (begin example)
        [unit, distance] call CBA_fnc_nearPlayer
    (end)

Author:

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(nearPlayer);

params [["_entity", objNull], ["_distance", 0, [0]]];

private _position = _entity call CBA_fnc_getPos;
private _return = false;

{
    if (_position distance _x < _distance) exitWith {
        _return = true;
    };
} forEach allPlayers;

_return
