/* ----------------------------------------------------------------------------
Function: CBA_fnc_select

Description:
    Select array elements for which the block returns true

Parameters:
    _array - Array to be filtered <ARRAY>
    _block - Condition <CODE>

Returns:
    New array with elements included for which the block returns true <ARRAY>

Example:
    (begin example)
        _result = [[1,2,3], {_this in [2,3]}] call CBA_fnc_select;
        // _result => [2,3]
    (end)

Author:
    MuzzleFlash
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(select);

// ----------------------------------------------------------------------------

params ["_array", "_filterCode"];

_array select {_x call _filterCode}
