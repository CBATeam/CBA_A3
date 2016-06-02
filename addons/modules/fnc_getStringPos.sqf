/* ----------------------------------------------------------------------------
Function: CBA_fnc_getStringPos

Description:
    A function used to get the position of a string with a passed typeName.

Parameters:
    - _type (String)
        "OBJECT", "GROUP", "ARRAY", "MARKER", "TASK", or ""
    - _string (String)

Example:
    (begin example)
    [1, "player"] call CBA_fnc_getStringPos;
    (end)

Returns:
    Position in XYZ format or Nil

Author:
    WiredTiger

---------------------------------------------------------------------------- */

#include "script_component.hpp"

params [
    ["_type",""],
    ["_string",""]
];

switch (_type) do {
    case "OBJECT": {getPos (call compile _string);};
    case "GROUP": {getPos (leader (call compile _string));};
    case "ARRAY": {[_string] call BIS_fnc_parseNumber;};
    case "MARKER": {getMarkerPos _string;};
    case "TASK": {taskDestination (call compile _string)};
    default {nil};
};
