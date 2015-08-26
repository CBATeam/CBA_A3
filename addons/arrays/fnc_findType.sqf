/* ----------------------------------------------------------------------------
Function: CBA_fnc_findType

Description:
    A function that returns the index of the first entry of the given type in an array.

Parameters:
    0: Entry type to search for. Possible vales are those that the typeOf command returns
    1: A Array with Any type of Variable

Example:
    (begin example)
    _index = ["OBJECT",["", Player, "test", nil, VARIABLE, nil]] call CBA_fnc_findType
    (end)

Returns:
    Index of the first entry of the indicated type in the array or -1 if no entry of the type could be found.

Author:
    joko // Jonas
---------------------------------------------------------------------------- */
#include "script_component.hpp"

scopeName "main";

params ["_typeOf", "_array"];
{
    if (typeOf _x == _typeOf) then {
        _forEachIndex breakOut "main";
    };
} forEach _array;

-1
