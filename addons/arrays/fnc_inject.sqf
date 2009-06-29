/* ----------------------------------------------------------------------------
Function: CBA_fnc_inject

Description:
	Accumulates a value by passing elements through a function.

	Data passed to the code on each iteration via _x: [_memoryValue, _element]
	
Parameters:
	_array - Array of key-value pairs to create Hash from [Array]
	_seed - Initial value to pass into the function [Any]
	_function - Code to pass values to [Function]

Returns:
	Last returned value [Any]
	
Examples:
	(begin example)
		_result = [[1, 2, 3], "", { (_x select 0) + str (_x select 1) }] call CBA_fnc_inject;
		// _result ==> "123"

		_result = [[1, 2, 3], " frogs", { (str (_x select 1)) + (_x select 0) }] call CBA_fnc_inject;
		// _result ==> "321 frogs"

		_result = [[1, 2, 3], 0, { (_x select 0) + (_x select 1) }] call CBA_fnc_inject;
		// _result ==> 6
	(end)
	
Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(inject);

// -----------------------------------------------------------------------------

PARAMS_3(_array,_seed,_function);

private ["_result", "_x"]; 

if (not isNil "_seed") then
{
	_result = _seed;
};

for "_i" from 0 to ((count _array) - 1) do
{
	_x = if (isNil "_result") then
	{
		[nil, _array select _i];
	}
	else
	{
		[_result, _array select _i];
	};
	
	_result = call _function;
};

_result;