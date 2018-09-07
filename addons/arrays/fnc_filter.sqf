#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_filter

Description:
    Filter each element of an array via a function.

    Data passed to the function on each iteration,
    * _x - Element of _array.

Parameters:
    _array   - Array <ARRAY>
    _filter  - Function to filter each element <CODE>
    _inPlace - true: alter array, false: copy array (optional, default: false) <BOOLEAN>

Returns:
    Filtered array <ARRAY>

Examples:
    (begin example)
        // Filter to create a new array.
        _original = [1, 2, 3];
        _filtered = [_original, {_x + 1}] call CBA_fnc_filter;
        // _original ==> [1, 2, 3]
        // _filtered ==> [2, 3, 4]

        // Filter original array in place.
        _original = [1, 2, 3];
        [_original, {_x * 10}, true] call CBA_fnc_filter;
        // _original ==> [10, 20, 30]
    (end)

Author:
    Spooner, commy2
---------------------------------------------------------------------------- */
SCRIPT(filter);

params [["_array", [], [[]]], ["_filter", {_x}, [{}]], ["_inPlace", false, [false]]];

if (_inPlace) then {
    {
        _array set [_forEachIndex, call _filter];
    } forEach _array;

    _array // return
} else {
    _array apply _filter // return
};
