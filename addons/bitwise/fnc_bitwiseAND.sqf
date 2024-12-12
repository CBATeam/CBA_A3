/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseAND

Description:
    Performs a bitwise AND operation between two decimal numbers. 

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _num1   -   a number <NUMBER>
    _num2   -   another number to compare to the first <NUMBER>

Returns:
    Sum of set bits as a decimal number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        [55,17] call CBA_fnc_bitwiseAND; // returns 17
        // 55's set bits = 32,16,4,2,1
        // 17's set bits = 16,1
        // common bits = 16,1
        // sum of common bits = 17
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
_this = _this apply {floor abs _x};
_this sort true;
params [["_min",0,[0]],["_max",1,[0]]];
private _end = floor ((ln _min)*1.44269502162933349609); //1/ln(2) = 1.44269502162933349609
if (_end >= 24) exitWith {false}; // precision drop after 2^24 (16777216)
private _power = 0;
private _return = 0;
for "_i" from 0 to _end do {
	_power = 2^_i;
	_return = _return + (_power * (((floor (_max / _power)) % 2) * ((floor (_min / _power))) % 2));
};
_return