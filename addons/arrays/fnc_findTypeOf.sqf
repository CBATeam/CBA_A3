/* ----------------------------------------------------------------------------
Function: CBA_fnc_findTypeOf

Description:
   Returns the index of the first entry of a given type in an array.

   The type argument is either an object or a class name string.

Parameters:
    0: Array
    1: Entry type, can be either Object or class name string (as returned by typeOf)

Example:
    (begin example)
    _index = [["", Player, "test", nil, VARIABLE, nil], player] call CBA_fnc_findTypeOf
    (end)

Returns:
    Index of the first entry of the indicated type in the array or -1 if no entry of the type could be found.

Author:
    joko // Jonas
---------------------------------------------------------------------------- */
#include "script_component.hpp"

scopeName "main";

params [["_array", [], [[]]], ["_typeOf", nil, [objNull, ""]]];

if (isNil "_typeOf" || {_array isEqualTo []}) exitWith {-1};

if (IS_OBJECT(_typeOf)) then {
    _typeOf = typeOf _typeOf;
};

{
    if (IS_OBJECT(_x) && {typeOf _x == _typeOf}) then {
        _forEachIndex breakOut "main";
    };
    if (IS_STRING(_x) && {_x == _typeOf}) then {
        _forEachIndex breakOut "main";
    };
} forEach _array;

-1
