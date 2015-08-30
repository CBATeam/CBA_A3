/* ----------------------------------------------------------------------------
Function: CBA_fnc_getLowestVaule

Description:
    Use to find Hightest value with index in a Array.

Parameters:
    _array: Array with Numbers

Example:
    (begin example)
    _array = [_array,1] call CBA_fnc_sortNestedArray
    (end)

Returns:
    _min: the Min Value
    _index: the Index of the Min Value

Author:
    joko // Jonas

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getLowestValue);
params ["_min"];
_index = -1;

{
    if (_min > _x) then {_min = _x; _index = _forEachIndex};
} forEach _this;

[_min, _index] // Return
