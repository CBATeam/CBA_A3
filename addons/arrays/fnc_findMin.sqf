/* ----------------------------------------------------------------------------
Function: CBA_fnc_findMin

Description:
    Find biggest numeric value with index in an array.

Parameters:
    _array: Array with Numbers

Example:
    (begin example)
    _result = [_array] call CBA_fnc_findMin
    (end)

Returns:
    _min: smallest value in array
    _index: index of the smallest value in array
    nil on failure

Author:
    joko // Jonas

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(findMin);

private ["_index"];

if (!IS_ARRAY(_this)) exitWith {nil};
if (_this isEqualTo []) exitWith {nil};

params ["_min"];
_index = 0;

{
    if (isNil "_x" || {(typeName _x) != (typeName 0)}) exitWith {_max = nil; _index = nil;};
    if (_min > _x) then {_min = _x; _index = _forEachIndex};
} forEach _this;

if (isNil "_max") exitWith {nil};
[_min, _index] // Return
