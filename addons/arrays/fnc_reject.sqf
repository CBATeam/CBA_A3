/* ----------------------------------------------------------------------------
Function: CBA_fnc_reject

Description:
	Reject array elements for which the block returns true

Parameters:
	_array - Input Array [Array]
	_block - Block [Code]

Returns:
	New array with elements removed for which the block returns true [String]

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

private "_result";
PARAMS_2(_array,_filterCode);

_result = [];
_result resize (count _array);
_rIdx = 0;
{
	if !(_x call _filterCode) then {
		_result set [_rIdx, _x];
		INC(_rIdx);
	};
} forEach _array;

_result resize _rIdx;

_result;
