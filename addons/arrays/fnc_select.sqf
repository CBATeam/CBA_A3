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
		_result = [[1,2,3], {_this in [2,3]}] call CBA_fnc_select;
		// _result => [2,3]
	(end)

Author:
	MuzzleFlash
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(select);

// ----------------------------------------------------------------------------

private "_result";
PARAMS_2(_array,_filterCode);

_result = [];
_result resize (count _array);
_rIdx = 0;
{
	if (_x call _filterCode) then {
		_result set [_rIdx, _x];
		INC(_rIdx);
	};
} forEach _array;

_result resize _rIdx;

_result;
