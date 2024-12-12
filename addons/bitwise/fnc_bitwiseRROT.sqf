/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseRROT

Description:
    Performs a bitwise RIGHT-ROTATE-NO-CARRY operation on a given number.

    * This function returns a non-negative integer.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will cause unexpected behavior.

Parameters:
    _num    -   the number to rotate <NUMBER>
    _numRot -   the number of rotations to perform <NUMBER>

Returns:
    Rotated number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        17 call CBA_fnc_bitwiseRROT; // returns 24
        // 17's set bits = 16+1
        // 17's set bits (binary) = 10001
        // shift right by 1, move rightmost bit to front = 11000
        // new bits = (2^4)+(2^3) OR 16+8
        // sum of rotated bits = 24

        [17,2] call CBA_fnc_bitwiseRROT; // returns 12
        // rotates once to 11000 (24)
        // rotates again to 01100 (12)
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
params [["_num",1,[0]],["_numRot",1,[0]]];
_num = floor abs _num;
_numRot = floor abs _numRot;
private _exp = floor((ln _num)*1.44269502162933349609);
if (_numRot > _exp) then {_numRot = _numRot % _exp;};
for "_i" from 1 to _numRot do {
	_num = (floor (_num / 2)) + ((_num % 2) * 2^_exp);
};
_num
// bitwiseRSROT
params [["_num",1,[0]],["_numRot",1,[0]]];
_num = floor abs _num;
_numRot = floor abs _numRot;
private _power = 2^(floor((ln _num)*1.44269502162933349609));
for "_i" from 1 to _numRot do {
	_num = (floor (_num / 2)) + ((_num % 2) * _power);
};
_num