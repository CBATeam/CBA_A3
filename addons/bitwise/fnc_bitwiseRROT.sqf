/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseRROT

Description:
    Performs a bitwise RIGHT-ROTATE-NO-CARRY operation on a given number.

    * This function converts all inputs into positive integers.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will cause unexpected behavior.

Parameters:
    _num    -   the number to rotate <NUMBER>
    _numRot -   the number of rotations to perform <NUMBER>

Returns:
    Rotated number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        17 call CBA_fnc_bitwiseRROT; // returns 24
        // 17's set bits                = 10001   (16,1)
        // shift right by 1             = _1000|1
        // move rightmost bit to front  = 11000   (16,8)
        // sum of rotated bits = 24

        [17,2] call CBA_fnc_bitwiseRROT; // returns 12
        // rotates once to  11000 (24)
        // rotates again to 01100 (12)
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BASE2LOG(number) ((ln number)*1.44269502162933349609)
params [["_num",0,[0]],["_numRot",0,[0]]];
_num = floor abs _num;
_numRot = floor abs _numRot;
private _exp = floor BASE2LOG(_num);
private _power = 2^_exp;
if (_numRot > _exp) then {_numRot = _numRot % _exp};
for "_i" from 1 to _numRot do {
	_num = (floor (_num / 2)) + ((_num % 2) * _power);
};
_num

// or 

#define BASE2LOG(number) ((ln number)*1.44269502162933349609)
params [["_num",0,[0]],["_numRot",0,[0]]];
_num = floor abs _num;
_numRot = floor abs _numRot;
private _exp = floor BASE2LOG(_num);
private _power = 2^(_exp+1);
if (_numRot > _exp) then {_numRot = _numRot % _exp};
for "_i" from 1 to _numRot do {
	_num = floor ((_power * (_num % 2) + _num) / 2);
};
_num