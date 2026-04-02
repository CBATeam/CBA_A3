#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_binarizeNumber
Description:
    Get a binary equivalent of a decimal number.

Parameters:
    _number    - Decimal Number <NUMBER>
    _minLength - Minimum length of the returned Array, note: returned array can be larger (optional, default: 8)<NUMBER>

Returns:
    Booleans <ARRAY>

Examples
    (begin example)
        [5, 5] call CBA_fnc_binarizeNumber
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(binarizeNumber);
params [
    ["_number", nil, [0]],
    ["_minLength", 8, [0]]
];

if (isNil "_number") exitWith {};

_number = round _number;

private _array = [];
_array resize _minLength;

for "_index" from 0 to (_minLength - 1) do {
    _array set [_index, false];
};

private _index = 0;

while {_number > 0} do {
    private _rest = _number mod 2;
    _number = floor (_number / 2);

    _array set [_index, _rest == 1];
    _index = _index + 1;
};

_array;
