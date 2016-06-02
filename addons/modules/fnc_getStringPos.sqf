/* ----------------------------------------------------------------------------
Function: CBA_fnc_getStringPos

Description:
    A function used to get the position of a string with a passed typeName.

Parameters:
    - Number (Number from 0 to 5)
        0 - Return 0 to decide what to do later in script
        1 - Object or location
        2 - Group
        3 - Array
        4 - Marker
        5 - Task
    - String (XYZ, Object, Location, task, group, or Marker)

Example:
    (begin example)
    [1, "player"] call CBA_fnc_getStringPos;
    (end)

Returns:
    In case of Object, group, array, marker, or task position [x,y,z] is returned,
    otherwise 0 is returned.

Author:
    WiredTiger

---------------------------------------------------------------------------- */

#include "script_component.hpp"

params [
    ["_type",0],
    ["_string",""],
    ["_stringPos",0]
];

switch (_type) do {
    case 1: {getPos (call compile _string);}; // Object/Location
    case 2: {getPos (leader (call compile _string));}; // Group
    case 3: {[_string] call BIS_fnc_parseNumber;}; // Array
    case 4: {getMarkerPos _string;}; // Marker
    case 5: {taskDestination (call compile _string)}; // Task
    default {_stringPos};
};
