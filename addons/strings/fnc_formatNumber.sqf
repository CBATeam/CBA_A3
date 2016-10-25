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
    Spooner
---------------------------------------------------------------------------- */
#define DEBUG_MODE_NORMAL
#include "script_component.hpp"

#define DEFAULT_INTEGER_WIDTH 1
#define DEFAULT_DECIMAL_PLACES 0
#define DEFAULT_SEPARATE_THOUSANDS false

SCRIPT(formatNumber);

// -----------------------------------------------------------------------------

params ["_number", ["_integerWidth",DEFAULT_INTEGER_WIDTH], ["_decimalPlaces",DEFAULT_DECIMAL_PLACES], ["_separateThousands",DEFAULT_SEPARATE_THOUSANDS]];

private ["_integerPart"];

private _decimalPoint = localize "STR_CBA_FORMAT_NUMBER_DECIMAL_POINT";
private _thousandsSeparator = localize "STR_CBA_FORMAT_NUMBER_THOUSANDS_SEPARATOR";

// Start by working out how to display the integer part of the number.
if (_decimalPlaces > 0) then {
    private _basePlaces = 10 ^ _decimalPlaces;
    _number = round(_number * _basePlaces) / _basePlaces;
    _integerPart = floor (abs _number);
} else {
    _integerPart = round (abs _number);
};

private _string = "";
private _numIntegerDigits = 0;

while {_integerPart > 0} do {
    if (_numIntegerDigits > 0 && {(_numIntegerDigits mod 3) == 0} && {_separateThousands}) then {
        _string = _thousandsSeparator + _string;
    };

    _string =  (str (_integerPart mod 10)) + _string;
    _numIntegerDigits = _numIntegerDigits + 1;

    _integerPart = floor (_integerPart / 10);
};

// Pad integer with 0s
while {_numIntegerDigits < _integerWidth} do {
    if (_numIntegerDigits > 0 && {(_numIntegerDigits mod 3) == 0} && {_separateThousands}) then {
        _string = _thousandsSeparator + _string;
    };

    _string = "0" + _string;

    _numIntegerDigits = _numIntegerDigits + 1;
};

// Add a - sign if needed.
if (_number < 0) then {
    _string = "-" + _string;
};

// Add decimal digits, if necessary.
if (_decimalPlaces > 0) then {

    //Use abs to prevent extra `-` signs and so floor doesn't get wrong value
    _number = abs _number;
    // Round number to correct for floating point precision and disable correct value.
    _number = round ((_number - (floor _number)) * (10 ^ _decimalPlaces));
    _string = _string + _decimalPoint;

    private _multiplier = 10;
    for "_i" from _decimalPlaces to 1 step -1 do {
        private _digit = floor ((_number mod (10^_i))/10^(_i -1));

        // If the digit has become infintesimal, pad to the end with zeroes.
        if (!(finite _digit)) exitWith {
            private "_j";

            for "_j" from _decimalPlaces to _i step -1 do {
                _string = _string + "0";
            };
        };

        _string = _string + (str _digit);

        _multiplier = _multiplier * 10;
    };
};

_string; // Return.
