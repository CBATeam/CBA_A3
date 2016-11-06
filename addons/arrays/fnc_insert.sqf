/* ----------------------------------------------------------------------------
Function: CBA_fnc_insert

Description:
    Inserts an element to the specified index of given array.

    Modifies the original array (Thanks BaerMitUmlaut)

Parameters:
    _array   - Array to insert at <ARRAY>
    _index   - Index of the insertion <NUMBER>
    _element - Element to be inserted <ANY>

Returns:
    The modified array. Empty array in case of errors <ARRAY>

Examples:
    (begin example)
        _arr = ["a", "b", "d", "e"];
        [_arr, 2, "c"] call CBA_fnc_insert;
        // _arr is now ["a", "b", "c", "d", "e"]
    (end)

Author:
    654wak654
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(insert);

params ["_array", "_index", "_element"];

private _size = count _array;
if (_index >= _size || {_index < 0}) exitWith {[]};

_right = _array select [_index, _size];
_array deleteRange [_index, _size];
_array pushBack _element;
_array append _right;
_array
