/* ----------------------------------------------------------------------------
Function: CBA_fnc_setPos

Description:
    A function used to set the position of an entity.

Parameters:
    _entity   - <MARKER, OBJECT, LOCATION, GROUP, TASK>
    _position - <MARKER, OBJECT, LOCATION, GROUP, TASK, POSITION>
    _radius   - random Radius (optional) <NUMBER>

Example:
    (begin example)
        [player, "respawn_west"] call CBA_fnc_setPos
    (end)

Returns:
    Nil

Author:
    Rommel
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(setPos);

params [
    ["_entity", objNull, [objNull, grpNull, "", locationNull, taskNull]],
    ["_position", nil, [objNull, grpNull, "", locationNull, taskNull, []]],
    ["_radius", 0, [0]]
];

if (isNil "_position") exitWith {};

_position = _position call CBA_fnc_getPos;

if (_radius > 0) then {
    _position = [_position, _radius] call CBA_fnc_randPos;
};

switch (typeName _entity) do {
    case "OBJECT" : {
        _entity setPos _position;
    };
    case "GROUP" : {
        private _leaderPos = getPos (leader _entity);

        {
            _x setpos (_position vectorAdd (_x worldToModel _leaderPos));
        } foreach (units _entity);
    };
    case "STRING" : {
        _entity setMarkerPos _position;
    };
    case "LOCATION" : {
        _entity setPosition _position;
    };
    case "TASK" : {
        _entity setSimpleTaskDestination _position;
    };
    default {};
};
