#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_selectRandom

Description:
    Select a specified amount of elements from an array without picking the same element multiple times.

Parameters:
    _array - Input Array <ARRAY>
    _amount - Amount to select <NUMBER>

Returns:
    New array with the specified amount of randomly selected elements <ARRAY>

Example:
    (begin example)
        _result = [[1, 2, 3, 4, 5], 2] call CBA_fnc_selectRandom;
        // _result => [2, 4] (random)
    (end)

Author:
    NeilZar
---------------------------------------------------------------------------- */
SCRIPT(selectRandom);

params [["_array", [], [[]]], ["_amount", 0, [0]]];

_amount = _amount min (count _array);
_array = + _array;

private _result = [];

for "_i" from 1 to _amount do {
    _result pushBack (_array deleteAt floor random count _array)
};

_result
