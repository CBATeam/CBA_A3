/* ----------------------------------------------------------------------------
Function: CBA_fnc_inject

Description:
	Accumulates a value by passing elements through a function.

	Data passed to the code on each iteration is [_memoryValue, _element]
   
Examples:
(begin code)
	[[1, 2, 3], "", { (_this select 0) + str (_this select 1) }] call CBA_fnc_inject;
	// ===> "123"

	[[1, 2, 3], " frogs", { (str (_this select 1)) + (_this select 0) }] call CBA_fnc_inject;
	// ===> "321 frogs"

	[[1, 2, 3], 0, { (_this select 0) + (_this select 1) }] call CBA_fnc_inject;
	// ===> 6
(end code)
	
Parameters:
	_array - Array of key-value pairs to create Hash from [Array]
	_seed - Initial value to pass into the function [Any, except nil]
	_function - Code to pass values to [Function]

Returns:
	Last returned value [Any]	
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(inject);

// -----------------------------------------------------------------------------

PARAMS_3(_array,_seed,_function);

private "_result"; 

_result = _seed;

for "_i" from 0 to ((count _array) - 1) do
{
	_result = [_result, _array select _i] call _function;
};

_result;