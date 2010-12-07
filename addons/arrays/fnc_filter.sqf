/* ----------------------------------------------------------------------------
Function: CBA_fnc_filter

Description:
	Filter each element of an array via a function.

	Data passed to the function on each iteration,
	* _x - Element of _array.

Parameters:
	_array - Array of key-value pairs to create Hash from [Array, defaults to []]
	_filter - Function to filter each element [Function]
	_inPlace - True to alter the array itself, rather than create a new one [Boolean, defaults to false]

Returns:
	Filtered array [Array]

Examples:
	(begin example)
		// Filter to create a new array.
		_original = [1, 2, 3];
		_filtered = [_original, { _x + 1 }] call CBA_fnc_filter;
		// _original ==> [1, 2, 3]
		// _filtered ==> [2, 3, 4]

		// Filter original array in place.
		_original = [1, 2, 3];
		[_original, { _x * 10 }, true] call CBA_fnc_filter;
		// _original ==> [10, 20, 30]
	(end)

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(filter);

// -----------------------------------------------------------------------------

PARAMS_2(_array,_filter);
DEFAULT_PARAM(2,_inPlace,false);

private ["_arrayOut", "_x"];

if _inPlace then
{
	_arrayOut = _array;
} else {
	_arrayOut = [];
	_arrayOut resize (count _array);
};

for "_i" from 0 to ((count _array) - 1) do
{
	_x = _array select _i;
	_arrayOut set [_i, call _filter];
};

_arrayOut;
