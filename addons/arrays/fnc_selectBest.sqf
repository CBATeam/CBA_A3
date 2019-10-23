#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_selectBest

Description:
    Select best element from an array

Parameters:
    _array - Input Array [Array]
    _criteria - Code that is passed element and should return an integer value [Code]
    _return - default return value if array is empty (optional, default nil) [Any]

Returns:
    Element that scores the highest [Any]

Example:
    (begin example)
        _result = [[2, -6, 4], {abs _x}] call CBA_fnc_selectBest;
        // _result => -6
        _result =  [[q1, q2], {-(t1 distance _x)}, objNull] call CBA_fnc_selectBest; // selects closest target (negative distance)
        // _result => q1
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
SCRIPT(selectBest);

params ["_array", "_criteria", "_return"];

private _bestScore = -1e99;
{
    private _xScore = _x call _criteria;
    if (_xScore > _bestScore) then {
        _return = _x;
        _bestScore = _xScore;
    };
} forEach _array;

_return
