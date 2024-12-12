/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseXOR

Description:
    Performs a bitwise XOR operation between two numbers. Bits that are different than each other are summed.

    * This function returns a non-negative integer.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _num1   -   a number <NUMBER>
    _num2   -   another number to compare to the first <NUMBER>

Returns:
    Sum of set bits as a decimal number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        captive addaction ["rescue",CBA_fnc_actionargument_path,[[],{[_target] join (group _caller)},true]] //captive joins action callers group, action is removed (true)
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
_this sort true;
params [["_min",0,[0]],["_max",1,[0]]];
_min = floor abs _min;
_max = floor abs _max;
private _end = floor ((ln _max)*1.44269502162933349609); //1/ln(2) = 1.44269502162933349609
if (_end >= 24) exitWith {false}; // precision drop after 2^24 (16777216)
private _power = 0;
private _return = 0;
for "_i" from 0 to _end do {
	_power = 2^_i;
	_return = _return + (_power * ((((floor (_max / _power)) % 2) + ((floor (_min / _power)) % 2)) % 2));
};  
_return