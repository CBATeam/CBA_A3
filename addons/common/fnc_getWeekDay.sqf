#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getWeekDay

Description:
    Calculates date's day of the week using a modified Rata Die method with fractional years.

Parameters:
    _date - Date of [year, month, day]. <ARRAY>

Returns:
    Day of the week (0: Sunday, 6: Saturday, -1: invalid) <NUMBER>

Examples:
    (begin example)
        [systemTimeUTC] call CBA_fnc_getWeekDay;
        [date] call CBA_fnc_getWeekDay;
        [[2022, 2, 16]] call CBA_fnc_getWeekDay;
    (end)

Author:
    Jonpas
---------------------------------------------------------------------------- */

params [["_date", [0, 0, 0], [[]], [3, 4, 5, 6, 7]]];

// Keep only year, month, day if longer date format is given
// Hours and minutes must be given as 0 for dateToNumber to work correctly for this use-case
_date = [_date select 0, _date select 1, _date select 2, 0, 0];

private _yearBefore = ((_date select 0) - 1) max 0;
private _leapYears = floor (_yearBefore / 4);
private _normalYears = _yearBefore - _leapYears;
private _days = _normalYears + (_leapYears * (366 / 365)) + dateToNumber _date;

(round (_days / (1 / 365))) mod 7 // return
