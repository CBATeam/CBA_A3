/* ----------------------------------------------------------------------------
Function: CBA_fnc_findTypeName

Description:
    A function that returns the index of the first entry of the given type in an array.

Parameters:
    0: Array
    1: TypeName, if parameter is a string, that contains a case insensitive typename, it will be used. Otherwise typename of the variable will be used.

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

#define TYPENAMES ["ARRAY", "BOOL", "CODE", "CONFIG", "CONTROL", "DISPLAY", "GROUP", "LOCATION", "OBJECT", "SCALAR", "SCRIPT", "SIDE", "STRING", "TASK", "TEXT", "TEAM_MEMBER", "NAMESPACE"]

scopeName "main";

params [["_array", [], [[]]], "_typeName"];

if (isNil "_typeName" || {_array isEqualTo []}) exitWith {-1};

// If a string is given, convert to uppercase for type matching
if (IS_STRING(_typeName)) then {
    _typeName = toUpper _typeName;
};

// If _typeName is not a typename description, use the type of that value
if !(_typeName in TYPENAMES) then {
    _typeName = typeName _typeName;
};

{
    if (typeName _x == _typeName) then {
        _forEachIndex breakOut "main";
    };
} forEach _array;

-1
