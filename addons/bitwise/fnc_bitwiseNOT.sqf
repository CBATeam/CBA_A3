/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseNOT

Description:
    Performs a bitwise NOT operation on a number. All bits are flipped.
    
    The _numBits argument is limited to numbers greater the number of bits _num already occupies.

    * This function converts all inputs into positive integers.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _num        -   the number to invert <NUMBER>
    _numBits    -   the number of bits this number should occupy (optional) <NUMBER>

Returns:
    Inverted number on success, -1 otherwise. <NUMBER>

Examples:
    (begin example)
        12 call CBA_fnc_bitwiseNOT; // returns 1
        // 12's set bits = 110 (8,4)
        // flip all bits = 001 (1)
        // sum of bits = 1

        [12,6] call CBA_fnc_bitwiseNOT; // returns 57
        // 12's set bits = 000110 (8,4)
        // flip all bits = 111001 (32,16,8,1)
        // sum of bits = 57
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)

params [["_num",1,[0]],"_numBits"];

_num = floor abs _num;

private _bitCount = floor BASE2LOG(_num) + 1;
if (!isNil "_numBits" && {_numBits isEqualType 0 && {_numBits > _bitCount}}) then {_bitCount = floor abs _numBits};
if (_bitCount > 24) exitWith {-1};

(2^_bitCount)-1-_num
