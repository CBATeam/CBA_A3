#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_randPos

Description:
    A function used to randomize a position around a given center

Parameters:
    _position  - <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
    _radius    - random Radius <NUMBER>
    _direction - randomization direction (optional, default: 0) <NUMBER>
    _angle     - the angle of the circular arc in which the random position will end up. (optional, default: 360) <NUMBER>

Example:
    (begin example)
        _position =  [position, radius] call CBA_fnc_randPos
    (end)

Returns:
    Position - [X,Y,Z]

Author:
    Rommel, commy2
---------------------------------------------------------------------------- */
SCRIPT(randPos);

params [
    ["_entity", objNull, [objNull, grpNull, "", locationNull, taskNull, []]],
    ["_radius", 0, [0]],
    ["_direction", 0, [0]],
    ["_angle", 360, [0]]
];

private _position = _entity call CBA_fnc_getPos;
private _doResize = _position isEqualTypeArray [0,0];

_position = _position getPos [_radius * sqrt random 1, _direction - 0.5*_angle + random _angle];

if (_doResize) then {
    _position resize 2;
};

_position
