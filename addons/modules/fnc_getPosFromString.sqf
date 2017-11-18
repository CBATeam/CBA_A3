/* ----------------------------------------------------------------------------
Function: CBA_fnc_getPosFromString

Description:
    A function used to get the position of an item when passed as a string.

    Designed with modules in mind since information can, presently, only be passed as a string
    or scalar. The type name needs to be passed along with the item so the function knows
    how to extract the desired position.

Parameters:
    - _type (String)
        "OBJECT", "GROUP", "ARRAY", "MARKER", "TASK", or ""
    - _string (String)

Example:
    (begin example)
    ["OBJECT", "player"] call CBA_fnc_getPosFromString;
    ["MARKER", "myMarker"] call CBA_fnc_getPosFromString;
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
