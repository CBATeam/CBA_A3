/* ----------------------------------------------------------------------------
Function: CBA_fnc_benchmarkFunction

Description:
	Benchmarks a function to see how long it will take to execute.

	Recommended to run with small number of iterations first and build up, to
	prevent locking up the machine.
	
Parameters:
	_function - Function to test [Function]
	_parameters - Parameters to pass to the function on each iteration 
		[Array or nil]
	_iterations - Number of iterations to run, in order to get an accurate
		average time [Number]

Returns:
	Average execution time [Number]
	
Examples:
(begin example)
	// Array creation through use of push.
	_array = [];
	_took = [{ _array set [count _array, 1] }, nil, 1000] call CBA_fnc_benchmarkFunction;
	
	// Array creation through use of concatenation.
	_array = [];
	_took = [{ _array = _array + [1] }, nil, 1000] call CBA_fnc_benchmarkFunction;
	
	// "Null function" to compare to (use as a control vs. operation time
	//	of other functions).
	_array = [];
	_took = [{}, nil, 1000] call CBA_fnc_benchmarkFunction;
(end)

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(benchmarkFunction);

// ----------------------------------------------------------------------------

PARAMS_3(_function,_parameters,_iterations);

private ["_start", "_averageTime"];

_start = diag_tickTime;

if (isNil "_parameters") then
{
	for "_i" from 1 to _iterations do
	{
		call _function;
	};
}
else
{
	for "_i" from 1 to _iterations do
	{
		_parameters call _function;
	};
};

_averageTime = (diag_tickTime - _start) / _iterations;

_averageTime; // Return.
