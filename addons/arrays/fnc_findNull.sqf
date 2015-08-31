/* ----------------------------------------------------------------------------
Function: CBA_fnc_findNull

Description:
    A function that returns the index of the first null entry in an array.

Parameters:
    The array to search in.

Example:
    (begin example)
    _index = ["", Player, "test", objNull, VARIABLE] call CBA_fnc_findNull
    (end)

Returns:
    Index of the first null entry in the array. If there is no null entry, the function returns -1

Author:
    joko // Jonas
---------------------------------------------------------------------------- */
#include "script_component.hpp"

if (typeName _this != "ARRAY") exitWith {-1};

scopeName "main";

private "_checkableTypes";

_checkableTypes = ["OBJECT", "CONTROL", "DISPLAY", "GROUP", "LOCATION", "TASK", "SCRIPT"];

{
    if (typeName _x in _checkableTypes && {isNull _x}) then {
        _forEachIndex breakOut "main";
    };
} forEach _this;

-1
