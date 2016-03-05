/* ----------------------------------------------------------------------------
Function: CBA_fnc_getNearest

Description:
    A function used to find out the nearest entity parsed in an array to a position. Compares the distance between entity's in the parsed array.

Parameters:
    _position - <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
    _array    - <ARRAY> of <MARKER, OBJECT, LOCATION, GROUP, TASK and/or POSITION>
    _radius   - Maximum distance from _position <NUMBER>
    _code     - Condition to meet, object is stored in _x variable <CODE>

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
SCRIPT(getNearest);

params [
    ["_position", objNull, [objNull, grpNull, "", locationNull, taskNull, []]],
    ["_array", [], [[]]],
    ["_radius", 1E5, [0]],
    ["_code", {}, [{}]]
];

private _return = [[], objNull] select (isNil {param [2]});

{
    _distance = [_position, _x] call CBA_fnc_getDistance;

    if (_distance < _radius) then {
        if !(call _code) exitWith {}; // don't move up. condition has to return false, vs. has to return true. Can be nil!

        if !(_return isEqualType objNull) then {
            _return pushBack _x;
        } else {
            _radius = _distance;
            _return = _x;
        };
    };
} forEach _array;

_return
