/* ----------------------------------------------------------------------------
Function: CBA_fnc_getHightestVaule

Description:
    Use to find Hightest value with index in a Array.

Parameters:
    _array: Array with Numbers

Example:
    (begin example)
    _array = [_array,1] call CBA_fnc_sortNestedArray
    (end)

Returns:
    _min: the Max Value
    _index: the Index of the Max Value

Author:
    joko // Jonas

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getLowestValue);
params ["_max"];
_index = -1;

{
    if (_max < _x) then {_max = _x; _index = _forEachIndex};
} forEach _this;

[_max, _index] // Return
