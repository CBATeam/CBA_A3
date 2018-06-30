#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_select

Description:
    Select array elements for which the block returns true

Parameters:
    _array - Input Array [Array]
    _block - Block [Code]

Returns:
    New array with elements included for which the block returns true [Array]

Example:
    (begin example)
        _result = [[1, 2, 3], {_this in [2, 3]}] call CBA_fnc_select;
        // _result => [2, 3]
    (end)

Author:
    MuzzleFlash
---------------------------------------------------------------------------- */

SCRIPT(select);

// ----------------------------------------------------------------------------

params ["_array", "_filterCode"];

private _result = [];

{
    if (_x call _filterCode) then {
        _result pushBack _x;
    };
} forEach _array;

_result
