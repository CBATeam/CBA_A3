/* ----------------------------------------------------------------------------
Function: CBA_fnc_findMin

Description:
    Find smallest numeric value with index in an array.

Parameters:
    _array: Array with Numbers

Example:
    (begin example)
    _result = [0,4,3,-2] call CBA_fnc_findMin
    (end)

Returns:
    _min: smallest value in array
    _index: index of the smallest value in array
    nil on failure

Author:
    joko // Jonas, commy2

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(findMin);

[_this] params [["_array", [], [[]]]];

if !(_array isEqualTypeAll 0) exitWith {nil};

private _arraySorted = + _array;
_arraySorted sort true; // true - ascending
_arraySorted params ["_min"];

[_min, _array find _min]
