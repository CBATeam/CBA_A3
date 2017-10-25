/* -----------------------------------------------------------------------------
Function: CBA_fnc_formatNumber

Description:
    Formats a number to a minimum integer width and to a specific number of
    decimal places.

    The formatting includes padding with 0s and correct rounding. Numbers
    are always displayed fully, never being condensed using an exponent (e.g.
    the number 1.234e9 would be given as "1234000000").

    Additionally, if required, it will separate the integer part of the number
    with the appropriate thousands seperators as, for example,
    "21,002" or "1,000,000".

Limitations:
    Although the function works up to a point and will display the passed
    number correctly, due to the extremely limited accuracy of floating point
    values used within ArmA (presumably just single-precision / 32 bit), the
    output might not be as EXPECTED after about eight significant figures.

Parameters:
    _number - Number to format [Number]
    _integerWidth - Minimum width of integer part of number, padded with 0s,
        [Number: >= 0, defaults to 1]
    _decimalPlaces - Number of decimal places, padded with trailing 0s,
        if necessary [Number: >= 0, defaults to 0]
    _separateThousands - True to separate each three digits with a comma
        [Boolean, defaults to false]

Returns:
    The number formatted into a string.

Examples:
    (begin example)
        // Assumes English formatting.
        [0.0001, 1, 3] call CBA_fnc_formatNumber;               // => "0.000"
        [0.0005, 1, 3] call CBA_fnc_formatNumber;               // => "0.001"

        [12345, 1, 0, true] call CBA_fnc_formatNumber;          // => "12,345"
        [1234567, 1, 0, true] call CBA_fnc_formatNumber;        // => "1,234,567"

        [12345.67, 1, 1, true] call CBA_fnc_formatNumber;       // => "12,345.7"
        [1234, 1, 3, true] call CBA_fnc_formatNumber;           // => "1,234.000"

        [0.1, 1] call CBA_fnc_formatNumber;                     // => "0"
        [0.1, 3, 1] call CBA_fnc_formatNumber;                  // => "000.1"
        [0.1, 0, 2] call CBA_fnc_formatNumber;                  // => ".10"
        [12, 0] call CBA_fnc_formatNumber;                      // => "12"
        [12, 3] call CBA_fnc_formatNumber;                      // => "012"

        [-12] call CBA_fnc_formatNumber;                        // => "-12"
    (end)

Author:
    Spooner, PabstMirror
---------------------------------------------------------------------------- */
#define DEBUG_MODE_NORMAL
#include "script_component.hpp"

#define DEFAULT_INTEGER_WIDTH 1
#define DEFAULT_DECIMAL_PLACES 0
#define DEFAULT_SEPARATE_THOUSANDS false

SCRIPT(formatNumber);

params ["_number", ["_integerWidth", DEFAULT_INTEGER_WIDTH], ["_decimalPlaces", DEFAULT_DECIMAL_PLACES], ["_separateThousands", DEFAULT_SEPARATE_THOUSANDS]];

private _isNegative = _number < 0;
private _return = (abs _number) toFixed _decimalPlaces;
private _dotIndex = if (_decimalPlaces == 0) then {count _return} else {_return find "."};


while {_integerWidth > _dotIndex} do { // pad with leading zeros
    _return = "0" + _return;
    _dotIndex = _dotIndex + 1;
};
if ((_integerWidth == 0) && {_return select [0, 1] == "0"}) then {
    _return = _return select [1]; // toFixed always adds zero left of decimal point, remove it
};
if (_separateThousands) then { // add localized thousands seperator "1,000"
    private _thousandsSeparator = localize "STR_CBA_FORMAT_NUMBER_THOUSANDS_SEPARATOR";
    for "_index" from (_dotIndex - 3) to 1 step -3 do {
        _return = (_return select [0, _index]) + _thousandsSeparator + (_return select [_index]);
        _dotIndex = _dotIndex + 1;
    };
};

if (_isNegative) then {_return = "-" + _return;}; // re-add negative sign

_return