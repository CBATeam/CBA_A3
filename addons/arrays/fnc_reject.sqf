/* ----------------------------------------------------------------------------
Function: CBA_fnc_reject

Description:
    Reject array elements for which the block returns true

Parameters:
    _array - Input Array [Array]
    _block - Block [Code]

Returns:
    New array with elements removed for which the block returns true [Array]

Example:
    (begin example)
        _result = [[1,2,3], {_this in [2,3]}] call CBA_fnc_reject;
        // _result => [1]
    (end)

Author:
    MuzzleFlash
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(reject);

// ----------------------------------------------------------------------------

params ["_array", "_filterCode"];

private _result = [];

{
    if !(_x call _filterCode) then {
        _result pushBack _x;
    };
} forEach _array;

_result
