#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_stdDev

Description:
    Returns the standard deviation, a measure of the spread of a distribution,
    of the array elements.

Parameters:
    _array       - The array from which the standard deviation is computed. <ARRAY>
    _ddof        - The delta degrees of freedom (see description above). [optional] <SCALAR> (default: 0)
                    The population standard deviation is returned for _ddof = 0.
                    The sample standard deviation is returned for _ddof = 1.

Returns:
    _stdDev      - The standard deviation <SCALAR>

Examples:
    (begin example)
    // returns roughly 5.564...
    [[1,4,16,4,1]] call CBA_fnc_stdDev;
    // returns roughly 6.221...
    [[1,4,16,4,1], 1] call CBA_fnc_stdDev;
    (end)

Author:
    Kex
---------------------------------------------------------------------------- */

params [["_array", [], [[]]], ["_ddof", 0, [0]]];

private _N = (count _array) - _ddof;
// Prevent zero division and negative root error
if (_N <= 0) exitWith {0};

private _sqrResSum = 0;
private _mean = _array call BIS_fnc_arithmeticMean;
{
    _sqrResSum = _sqrResSum + (_x - _mean)^2;
} forEach _array;

sqrt (_sqrResSum / _N) // return
