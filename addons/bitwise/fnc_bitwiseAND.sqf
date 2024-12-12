/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseAND

Description:
    Performs a bitwise AND operation between two decimal numbers. 

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _num1   -   a number <NUMBER>
    _num2   -   another number to compare to the first <NUMBER>

Returns:
    Resulting number on success, false otherwise. <NUMBER or BOOLEAN>

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
#define BITREP(num,pow) ((floor (num / pow)) mod 2)
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)
_this = _this apply {floor abs _x};
_this sort true;
params [["_min",0,[0]],["_max",1,[0]]];
private _end = floor BASE2LOG(_min); //1/ln(2) = 1.44269502162933349609
if (_end >= 24) exitWith {false}; // precision drop after 2^24 (16777216)
private _power = 0;
private _return = 0;
for "_i" from 0 to _end do {
	_power = 2^_i;
	_return = _return + (_power * (BITREP(_max,_power) * BITREP(_min,_power)));
};
_return