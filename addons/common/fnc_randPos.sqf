/* ----------------------------------------------------------------------------
Function: CBA_fnc_randPos

Description:
    A function used to randomize a position around a given center

Parameters:
    _position  - <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
    _radius    - random Radius <NUMBER>
    _direction - randomization direction (optional, default: 0) <NUMBER>
    _spreading - spreading around direction (optional, default: 360) <NUMBER>

Example:
    (begin example)
        _position =  [position, radius] call CBA_fnc_randPos
    (end)

Returns:
    Position - [X,Y,Z]

Author:
    Rommel, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(randPos);

params [
    ["_entity", objNull, [objNull, grpNull, "", locationNull, taskNull, []]],
    ["_radius", 0, [0]],
    ["_direction", 0, [0]],
    ["_spreading", 360, [0]]
];

private _position = _entity call CBA_fnc_getPos;
private _doResize = _position isEqualTypeArray [0,0];

_position = _position getPos [_radius * sqrt random 1, _direction - 0.5*_spreading + random _spreading];

if (_doResize) then {
    _position resize 2;
};

_position
