/* ----------------------------------------------------------------------------
Function: CBA_fnc_findMax

Description:
    Find largest numeric value with index in an array.

Parameters:
    _array: Array with Numbers

Example:
    (begin example)
    _result = [_array] call CBA_fnc_findMax
    (end)

Returns:
    _max: largest value in array
    _index: index of the largest value in array
    nil on failure

Author:
    joko // Jonas

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(findMax);

if (!IS_ARRAY(_this)) exitWith {nil};
if (_this isEqualTo []) exitWith {nil};

params ["_max"];

private _index = 0;

{
    if (isNil "_x" || {(typeName _x) != (typeName 0)}) exitWith {_max = nil; _index = nil;};
    if (_max < _x) then {_max = _x; _index = _forEachIndex};
} forEach _this;

if (isNil "_max") exitWith {nil};
[_max, _index] // Return
