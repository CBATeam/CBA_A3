/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseLROT

Description:
    Performs a bitwise LEFT-ROTATE-NO-CARRY operation on a given number. Bits that are both 1 are summed.
    
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
        [25,1] call CBA_fnc_bitwiseLROT; // returns 19
        // 25's set bits                =   11001 (16,8,1) 
        // shift left by 1              =  11001_
        // move leftmost bit to back    =   10011 (16,2,1)
        // sum of rotated bits = 19

        [25,2] call CBA_fnc_bitwiseLROT; // returns 7
        // rotates once to      10011 (19)
        // rotates twice to     00111 (7)

        [25,2,6] call CBA_fnc_bitwiseLROT; // returns 37
        // 25's set bits       011001
        // rotates once to     110010 (50)
        // rotates twice to    100101 (37)
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

// the top _numRot bits wrap around to the bottom, the remaining bits shift left
private _wrap = 2^(_bitCount - _numRot);
floor (_num / _wrap) + (_num mod _wrap) * 2^_numRot
