/* ----------------------------------------------------------------------------
Function: CBA_fnc_insert

Description:
    Inserts an array of elements to given array at the specified index.

    Modifies the original array (Thanks BaerMitUmlaut)

Parameters:
    _array    - Array to insert at <ARRAY>
    _index    - Index of the insertion <NUMBER>
    _elements - Elements to be inserted <ARRAY>

Returns:
    The modified array <ARRAY>

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
#define ARRAY_ELEMENT_LIMIT 1E7
SCRIPT(insert);

params ["_array", "_index", "_elements"];

private _right = _array select [_index, ARRAY_ELEMENT_LIMIT];
_array resize _index;
_array append _elements;
_array append _right;
_array
