/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseOR

Description:
    Performs a bitwise OR operation between two numbers. Bits that are both zero are not summed.

    * This function returns a non-negative integer.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _num1   -   a number <NUMBER>
    _num2   -   another number to compare to the first <NUMBER>

Returns:
    Resulting number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        [55,15] call CBA_fnc_bitwiseOR; // returns 63
        // 55's set bits = 110111 (32,16,4,2,1)
        // 15's set bits = 001111 (8,4,2,1)
        // all set bits  = 111111 (32,16,8,4,2,1)
        // sum of all set bits = 63
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BITREP(num,pow) ((floor (num / pow)) mod 2)
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)
_this = _this apply {floor abs _x};
_this sort true;
params [["_min",0,[0]],["_max",1,[0]]];
private _end = BASE2LOG(_max); //1/ln(2) = 1.44269502162933349609
if (_end >= 24) exitWith {false}; // precision drop after 2^24 (16777216)
private _power = 0;
private _return = 0;
private _maxBit = 0;
private _minBit = 0;
for "_i" from 0 to _end do { 
	_power = 2^_i;
	_maxBit = BITREP(_max,_power);
	_minBit = BITREP(_min,_power);
	_return = _return + (_power * ((_maxBit + _minBit) - (_maxBit * _minBit)));
};
_return