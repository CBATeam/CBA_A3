/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseXOR

Description:
    Performs a bitwise XOR operation between two numbers. Bits that are different than each other are summed.

    * This function converts all inputs into positive integers.
    * This function also sorts the input array. Despite the naming of _min and _max, the input array does not have to be presorted.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _min   -   a number <NUMBER>
    _max   -   another number to compare to the first <NUMBER>

Returns:
    Resulting number on success, -1 otherwise. <NUMBER>

Examples:
    (begin example)
        [55,15] call CBA_fnc_bitwiseXOR; // returns 56
        // 55's set bits   = 110111 (32,16,4,2,1)
        // 15's set bits   = 001111 (8,4,2,1)
        // common set bits = 000111 (4,2,1)
        // unique set bits = 111000 (32,16,8)
        // sum of unique bits = 56
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BITGRAB(num,pow) ((floor (num / pow)) mod 2)
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)

private _input = _this;
_input resize 2;
_input = _input apply {floor abs _x};
_input sort true;
_input params [["_min",0,[0]],["_max",1,[1]]];

private _end = floor ((ln _max)*1.44269502162933349609); //1/ln(2) = 1.44269502162933349609
if (_end > 24) exitWith {-1}; // precision drop after 2^24 (16777216)

private _power = 0;
private _return = 0;

for "_i" from 0 to _end do {
	_power = 2^_i;
	_return = _return + (_power * ((BITGRAB(_max,_power) + BITGRAB(_min,_power)) % 2));
};  

_return