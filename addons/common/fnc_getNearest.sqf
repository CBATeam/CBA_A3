/* ----------------------------------------------------------------------------
Function: CBA_fnc_getNearest

Description:
    A function used to find out the nearest entity parsed in an array to a position. Compares the distance between entity's in the parsed array.

Parameters:
    _position - Marker, Object, Location, Group or Position
    _array - Array of [Marker, Object, Location, Group and or Positions]
    _radius - Maximum distance from _position
    _code - Condition to meet (Code)

Example:
    (begin example)
    _nearestVeh = [player, vehicles] call CBA_fnc_getNearest
    _nearestGroups = [[0,0,0], allGroups, 50, {count (units _x) > 1}] call CBA_fnc_getNearest
    (end)

Returns:
    Nearest given entity or List of entities within given distance

Author:
    Rommel

---------------------------------------------------------------------------- */

#include "script_component.hpp"

PARAMS_2(_position,_array);

DEFAULT_PARAM(2,_radius,10^5);
DEFAULT_PARAM(3,_code,{true});

private "_return";
_return = if (count _this > 2) then {[]} else {objNull};
{
    _distance = [_position,_x] call CBA_fnc_getDistance;
    if (_distance < _radius) then {
        if !(call _code) exitwith {};
        if (count _this > 2) then {
            _return pushBack _x;
        } else {
            _radius = _distance;
            _return = _x;
        };
    };
} foreach _array;
_return
