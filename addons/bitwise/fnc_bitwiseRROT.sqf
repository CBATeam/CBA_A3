/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseRROT

Description:
    Performs a bitwise RIGHT-ROTATE-NO-CARRY operation on a given number.

    * This function converts all inputs into positive integers.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _num        -   the number to rotate <NUMBER>
    _numRot     -   the number of rotations to perform <NUMBER>
    _numBits    -   the number of bits this number should occupy (optional) <NUMBER>

Returns:
    Rotated number on success, -1 otherwise. <NUMBER>

Examples:
    (begin example)
        17 call CBA_fnc_bitwiseRROT; // returns 24
        // 17's set bits                = 10001   (16,1)
        // shift right by 1             = _1000|1
        // move rightmost bit to front  = 11000   (16,8)
        // sum of rotated bits = 24

        [17,2] call CBA_fnc_bitwiseRROT; // returns 12
        // rotates once to      11000 (24)
        // rotates again to     01100 (12)

        [17,2,7] call CBA_fnc_bitwiseRROT; // returns 36
        // 17's set bits        0010001
        // rotates once to      1001000 (72)
        // rotates again to     0100100 (36)
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BITGRAB(num,pow) ((floor (num / pow)) mod 2)
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)
#define BITQUANT(num) floor BASE2LOG(num) + 1

params [["_num",0,[0]],["_numRot",0,[0]],"_numBits"];

_num = floor abs _num;
_numRot = floor abs _numRot;

private _bitCount = BITQUANT(_num);
if (!isNil "_numBits" && {_numBits isEqualType 0 && {_numBits > _bitCount}}) then {_bitCount = (floor abs _numBits)};
if (_bitCount > 24) exitWith {-1};
if (_numRot > _bitCount) then {_numRot = _numRot % _bitCount;}; // trim excess rotations

private _power = 0;
private _amend = 0;

if (_numRot > (_bitCount / 2)) exitWith {

	_numRot = _numRot - (floor (_bitCount / 2));
	_num = _num * 2^_numRot;

	for "_i" from _bitCount to (_bitCount + _numRot) do { // check bits over limit
	    _power = 2^_i;
	    _amend = _amend + (BITGRAB(_num,_power) * (_power - 2^(_i - _bitCount)));
	};

	_num - _amend
};

for "_i" from 0 to _numRot-1 do {
	_power = 2^_i;
	_amend = _amend + (BITGRAB(_num,_power) * (_power * 2^_numBits)); // _pow * 2^_numBits == 2^(_i + _numBits)
};

floor ((_num + _amend) / 2^_numRot) // sum and bitshift right