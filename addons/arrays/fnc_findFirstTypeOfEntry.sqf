/* ----------------------------------------------------------------------------
Function: CBA_fnc_findFirstTypeOfEntry

Description:
    A function that return the index of the first Type Of Entry in a Array.

Parameters:
    0: TypeOf Return as String
    1: A Array with Any type of Variable

Example:
    (begin example)
    _index = ["OBJECT",["", Player, "test", nil, VARIABLE, nil]] call CBA_fnc_findFirstTypeOfEntry
    (end)

Returns:
    Index that is the first Type Of in the Array if no Empty in retrun 0

Author:
    joko // Jonas
---------------------------------------------------------------------------- */
#include "script_component.hpp"

scopeName "main";

params ["_typeOf", "_array"]
{
    if (typeOf _x == _typeOf) then {
        _forEachIndex breakOut "main";
    };
} forEach _array;

-1
