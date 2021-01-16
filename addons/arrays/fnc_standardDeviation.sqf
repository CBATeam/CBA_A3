#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_standardDeviation

Description:
    Returns the standard deviation, a measure of the spread of a distribution,
    of the array elements.

Parameters:
    _numbers - The array from which the standard deviation is computed <ARRAY>
    _ddof    - The delta degrees of freedom [optional] <SCALAR> (default: 0)
               _ddof = 0 - Population standard deviation
               _ddof = 1 - Sample standard deviation

Returns:
    _stdDev - The standard deviation <SCALAR>

Examples:
    (begin example)
    // returns roughly 5.564
    [[1,4,16,4,1]] call CBA_fnc_standardDeviation;
    // returns roughly 6.221
    [[1,4,16,4,1], 1] call CBA_fnc_standardDeviation;
    (end)

Author:
    Kex
---------------------------------------------------------------------------- */

params [["_numbers", [], [[]]], ["_ddof", 0, [0]]];

private _count = count _numbers;
if (_count <= _ddof) exitWith {0};

private _mean = 0;
{_mean = _mean + _x} count _numbers;
_mean = _mean / _count;

private _resSumSqrs = 0;
{
    _resSumSqrs = _resSumSqrs + (_x - _mean)^2;
} count _numbers;

sqrt (_resSumSqrs / (_count - _ddof)) // return
