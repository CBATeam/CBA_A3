/* ----------------------------------------------------------------------------
Function: CBA_fnc_getPos

Description:
    A function used to get the position of an entity.

Parameters:
    Marker, Object, Location, Group or Task

Example:
    (begin example)
    _position = (group player) call CBA_fnc_getPos
    (end)

Returns:
    Position (AGL) - [X,Y,Z]

Author:
    Rommel

---------------------------------------------------------------------------- */

params ["_thing"];

switch (typeName _thing) do {
    case "OBJECT" : {
        getPos _thing
    };
    case "GROUP" : {
        getPos (leader _thing)
    };
    case "STRING" : {
        getMarkerPos _thing
    };
    case "LOCATION" : {
        position _thing
    };
    case "TASK" : {
        taskDestination _thing
    };
    default {_this};
};
