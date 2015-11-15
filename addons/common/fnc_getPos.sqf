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

switch (typename _thing) do {
    case "OBJECT" : {
        getpos _thing
    };
    case "GROUP" : {
        getpos (leader _thing)
    };
    case "STRING" : {
        getmarkerpos _thing
    };
    case "LOCATION" : {
        position _thing
    };
    case "TASK" : {
        taskdestination _thing
    };
    default {_this};
};
