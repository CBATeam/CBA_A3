#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_selectRandom

Description:
    Select a specified amount of elements from an array without picking the same element multiple times.

Parameters:
    _array - Input Array <ARRAY>
    _amount - Block <NUMBER>

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

if (_amount >= count _array) exitWith { _array };
if (_amount <= 0) exitWith { [] };

private _result = [];

for "" from 0 to _amount - 1 do {
    _result pushBack (_array deleteAt (floor random (count _array)))
};

_result
