#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_sortNestedArray

Description:
    Sorts the given nested array in either ascending or descending order based on the
    numerical value at specified index of sub arrays.

    Optionally, the current ordering (relative to each other) of array elements with
    the same numerical sorting value can be preserved.

    Original array is modified.

Parameters:
    _array - Nested array to be sorted <ARRAY>
    _index - Sub array item index to be sorted on <NUMBER>
    _order - true: ascending, false: descending (optional, default: true) <BOOLEAN>
    _preserve - Preserve current order of items with the same sorting value (optional, default: false) <BOOLEAN>

Example:
    (begin example)
        _array = [_array, 1] call CBA_fnc_sortNestedArray
    (end)

Returns:
    Sorted array <ARRAY>

Author:
    commy2, mharis001
---------------------------------------------------------------------------- */
SCRIPT(sortNestedArray);

params [["_array", [], [[]]], ["_index", 0, [0]], ["_order", true, [false]], ["_preserve", false, [false]]];

private _helperArray = _array apply {
    [_x select _index, 0, _x]
};

if (_preserve) then {
    private _coefficient = [-1, 1] select _order;

    {
        _x set [1, _coefficient * _forEachIndex];
    } forEach _helperArray;
};

_helperArray sort _order;

{
    _array set [_forEachIndex, _x select 2];
} forEach _helperArray;

_array
