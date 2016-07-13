/* ----------------------------------------------------------------------------
Function: CBA_fnc_sortNestedArray

Description:
    Used to sort a nested array from lowest to highest using quick sort.

    Sorting is based on the specified column, which must have numerical data.
    Original array is modified.

Parameters:
    _array - Nested array to be sorted <ARRAY>
    _index - Sub array item index to be sorted on <NUMBER>
    _order - true: ascending, false: descending (optional, default: true) <BOOLEAN>

Example:
    (begin example)
        _array = [_array, 1] call CBA_fnc_sortNestedArray
    (end)

Returns:
    Sorted array <ARRAY>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(sortNestedArray);

params [["_array", [], [[]]], ["_index", 0, [0]], ["_order", true, [false]]];

private _helperArray = _array apply {
    [_x select _index, _x]
};

_helperArray sort _order;

{
    _array set [_forEachIndex, _x select 1];
} forEach _helperArray;

_array
