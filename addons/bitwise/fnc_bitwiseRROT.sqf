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
        [17,1] call CBA_fnc_bitwiseRROT; // returns 24
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
params [["_num",0,[0]],["_numRot",0,[0]],"_numBits"];

_num = floor abs _num;
_numRot = floor abs _numRot;

// minimal number of bits to represent _num (exact, unlike a float logarithm), stops at 25 for oversized inputs
private _bitCount = 1;
while {_bitCount <= 24 && {2^_bitCount <= _num}} do {_bitCount = _bitCount + 1};
if (!isNil "_numBits" && {_numBits isEqualType 0 && {_numBits > _bitCount}}) then {_bitCount = floor abs _numBits};
if (_bitCount > 24) exitWith {-1};
_numRot = _numRot mod _bitCount; // trim excess rotations

// the bottom _numRot bits wrap around to the top, the remaining bits shift right
private _wrap = 2^_numRot;
floor (_num / _wrap) + (_num mod _wrap) * 2^(_bitCount - _numRot)
