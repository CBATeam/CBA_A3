/* ----------------------------------------------------------------------------
@description Filter each element of an array via a function.

Examples:
  [[1, 2, 3], { (_this select 0) + 1 }] call CBA_fnc_collect;
  ===> [2, 3, 4]
 
Params:
  0: _array - Array of key-value pairs to create Hash from [Array, defaults to []]
  1: _filter - Function to filter each element [Function]
  2: _inPlace - True to alter the array itself, rather than create a new one [Boolean, defaults to false]

Returns:
  Filtered array [Array]
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(collect);

// -----------------------------------------------------------------------------

PARAMS_2(_array,_filter);
DEFAULT_PARAM(2,_inPlace,false);

private "_arrayOut";

if _inPlace then
{
	_arrayOut = _array;
}
else
{
	_arrayOut = [];
	_arrayOut resize (count _array);
};

for "_i" from 0 to ((count _array) - 1) do
{
	_arrayOut set [_i, [_array select _i] call _filter];
};

_arrayOut;