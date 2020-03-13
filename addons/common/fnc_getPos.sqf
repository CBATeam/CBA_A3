#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getPos

Description:
    A function used to get the position of an entity.

Parameters:
    _entity - <MARKER, OBJECT, LOCATION, GROUP, TASK, WAYPOINT or POSITION>

Example:
    (begin example)
        _position = (group player) call CBA_fnc_getPos
    (end)

Returns:
    Position (AGLS) - [X,Y,Z]
    Z will always be 0 for MARKER, LOCATION and TASK.
    If entity is GROUP, the position of the group leader will be reported.
    For OBJECT and GROUP, the z will be relative to the first RoadWay LOD
    below the object (AGLS format).
    If POSITION was provided, the position array will be copied.
    Defaults to [0,0,0] if the entity is null or undefined.

Author:
    Rommel
---------------------------------------------------------------------------- */
SCRIPT(getPos);

params [
    ["_entity", objNull, [objNull, grpNull, "", locationNull, taskNull, [], 0]] // [] and 0 to handle position
];

if (_this isEqualType [] && {_this isEqualTypeArray [grpNull, 0]}) then {
    _entity = _this;
};

switch (typeName _entity) do {
    case "OBJECT": {
        getPos _entity
    };
    case "GROUP": {
        getPos (leader _entity)
    };
    case "STRING": {
        getMarkerPos _entity
    };
    case "LOCATION": {
        position _entity
    };
    case "TASK": {
        taskDestination _entity
    };
    case "ARRAY": {
        if (_entity isEqualTypeArray [grpNull, 0]) then {
            getWPPos _entity
        } else {
            + _entity
        };
    };
    case "SCALAR": { // in case of position being passed not in array
        + _this
    };
};
