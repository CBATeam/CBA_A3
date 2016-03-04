/* ----------------------------------------------------------------------------
Function: CBA_fnc_randPos

Description:
    A function used to randomize a position around a given center

Parameters:
    _position - <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
    _radius   - random Radius <NUMBER>

Example:
    (begin example)
        _position =  [position, radius] call CBA_fnc_randPos
    (end)

Returns:
    Position - [X,Y,Z]

Author:
    Rommel
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(randPos);

params [
    ["_entity", objNull, [objNull, grpNull, "", locationNull, taskNull, []]],
    ["_radius", 0, [0]]
];

private _position = _entity call CBA_fnc_getPos;

_position vectorAdd [_radius - 2 * random _radius, _radius - 2 * random _radius, 0]
