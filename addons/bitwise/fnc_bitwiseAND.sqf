/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseAND

Description:
    Performs a bitwise AND operation between two numbers. 

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
        [55,25] call CBA_fnc_bitwiseAND; // returns 17
        // 55's set bits   = 110111 (32,16,4,2,1)
        // 25's set bits   = 011001 (16,8,1)
        // common set bits = 010001 (16,1)
        // sum of common bits = 17
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BITGRAB(num,pow) ((floor (num / pow)) mod 2)
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)

private _input = _this apply {floor abs _x};
_input sort true;
_input params [["_min",0,[0]],["_max",1,[1]]];

private _end = floor BASE2LOG(_min); //1/ln(2) = 1.44269502162933349609
if (_end >= 24) exitWith {-1}; // precision drop after 2^24 (16777216)

private _power = 0;
private _return = 0;

for "_i" from 0 to _end do {
	_power = 2^_i;
	_return = _return + (_power * (BITGRAB(_max,_power) * BITGRAB(_min,_power)));
};

_return