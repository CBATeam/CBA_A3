/* ----------------------------------------------------------------------------
Function: CBA_fnc_findTypeName

Description:
    A function that returns the index of the first entry of the given type in an array.

Parameters:
    0: Entry type to search for. Was not a string with a known type name it take the typeName from the input.
    1: A Array with Any type of Variable

Example:
    (begin example)
    _index = ["OBJECT",["", Player, "test", nil, VARIABLE, nil]] call CBA_fnc_findTypeName
    (end)

Returns:
    Index of the first entry of the indicated type in the array or -1 if no entry of the type could be found.

Author:
    joko // Jonas
---------------------------------------------------------------------------- */
#include "script_component.hpp"

scopeName "main";

params ["_typeName", "_array"];
_typeName = toUpper _typeName;
if !(_typeName in ["ARRAY", "BOOL", "CODE", "CONFIG", "CONTROL", "DISPLAY", "LOCALTION", "OBJECT", "SCALAR", "SCRIPT", "SIDE", "STRING", "TEXT", "TEAM_MEMBER", "NAMESPACE"]) then {
    _typeName = typeName _typeName;
};

{
    if (typeName _x == _typeName) then {
        _forEachIndex breakOut "main";
    };
} forEach _array;

-1
