/* ----------------------------------------------------------------------------
@description Accumulates a value by passing elements through a function.

  Data passed to the code on eadch iteration is [_memoryValue, _element]

Examples:
  [[1, 2, 3], "", { (_this select 0) + str (_this select 1) }] call CBA_fnc_inject;
  ===> "123"
  
  [[1, 2, 3], "Frog: ", { (str (_this select 1)) + (_this select 0) }] call CBA_fnc_inject;
  ===> "Frog: 321"
  
  [[1, 2, 3], 0, { (_this select 0) + (_this select 1) }] call CBA_fnc_inject;
  ===> 6
 
Params:
  0: _array - Array of key-value pairs to create Hash from [Array]
  1: _seed - Initial value to pass into the function [Any, except nil]
  2: _function - Code to pass values to [Function]

Returns:
  Newly created Hash [Hash]
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