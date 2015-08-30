/* ----------------------------------------------------------------------------
Function: CBA_fnc_findTypeOf

Description:
    A function that returns the index of the first entry of the given type in an array.

Parameters:
    0: Entry type to search for. Object or class name (as returned by the typeOf command).
    1: A Array with Any type of Variable

Example:
    (begin example)
    _index = [Player, ["", Player, "test", nil, VARIABLE, nil]] call CBA_fnc_findTypeOf
    (end)

Returns:
    Index of the first entry of the indicated type in the array or -1 if no entry of the type could be found.

Author:
    joko // Jonas
---------------------------------------------------------------------------- */
#include "script_component.hpp"

scopeName "main";

params ["_typeOf", "_array"];
if (typeName _typeOf == "OBJECT") then {
    _typeOf = typeOf _typeOf;
};

{
    if (_x typeName == "OBJECT" && {typeOf _x == _typeOf}) then {
        _forEachIndex breakOut "main";
    };
    if (_x typeName == "STRING" && {_x == _typeOf}) then {
        _forEachIndex breakOut "main";
    };
} forEach _array;

-1
