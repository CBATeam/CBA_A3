#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_findNil

Description:
    A function that returns the index of the first empty (nil) entry in an array.

Parameters:
    _array: to search in. <ARRAY>

Returns:
    Index of the first nil entry in the array. If there is no nil entry, the function returns -1 <NUMBER>

Example:
    (begin example)
    _index = ["", player, "test", nil, _variable, nil] call CBA_fnc_findNil
    (end)

Author:
    joko // Jonas
---------------------------------------------------------------------------- */

[_this] params [["_array", [], [[]]]];

scopeName "main";

{
    if (isNil "_x") then {
        _forEachIndex breakOut "main";
    };
} forEach _array;

-1
