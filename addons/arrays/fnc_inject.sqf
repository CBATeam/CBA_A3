/* ----------------------------------------------------------------------------
Function: CBA_fnc_inject

Description:
    Accumulates a value by passing elements of an array "through" a function.

    Data passed to the function on each iteration,
    * _accumulator - Value passed from last iteration, set to _initial for the
        first iteration.
    * _x - Element of _array.

Parameters:
    _array - Array of key-value pairs to create Hash from [Array]
    _initial - Initial value to pass into the function as _accumulator [Any]
    _function - Code to pass values to [Function]

Returns:
    Accumlated value [Any]

Examples:
    (begin example)
        _result = [[1, 2, 3], "", {_accumulator + (str _x)}] call CBA_fnc_inject;
        // _result ==> "123"

        _result = [[1, 2, 3], " frogs", {(str _x) + _accumulator}] call CBA_fnc_inject;
        // _result ==> "321 frogs"

        _result = [[1, 2, 3], 0, {_accumulator + _x}] call CBA_fnc_inject;
        // _result ==> 6
    (end)

Author:
    Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(inject);

// -----------------------------------------------------------------------------

params ["_array", "_initial", "_function"];

private "_accumulator";

if (!isNil "_initial") then {
    _accumulator = _initial;
};

{
    _accumulator = call _function;
} forEach _array;

// Return.
if (isNil "_accumulator") then {
    nil;
} else {
    _accumulator;
};
