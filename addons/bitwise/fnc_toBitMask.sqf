#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_toBitMask
Description:
    Convert an array of booleans into a number.
    Takes Input <ARRAY of BOOLs> (limited to float precision)

Parameters:
    _input - Boolean (least significant bit) <BOOL>

Returns:
    Bitmask <NUMBER>

Examples
    (begin example)
        [[true, false]] call CBA_fnc_toBitmask
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(toBitMask);
params [["_input", [], [[]]]];

private _result = 0;
{
    if (_x) then {_result = _result + 2 ^ _forEachIndex};
} forEach _input;

_result;
