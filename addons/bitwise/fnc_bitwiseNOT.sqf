/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseNOT

Description:
    Performs a bitwise NOT operation on a number. All bits are flipped.
    By default, this function assumes that the largest power of 2 that _num stores is the number of bits it occupies.

    * This function returns a non-negative integer.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _num   -   a number <NUMBER>
    _base  -   the number of bits this number occupies (optional) <NUMBER>

Returns:
    Resulting number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        12 call CBA_fnc_bitwiseNOT; // returns 1
        // 12's set bits = 110 (8,4)
        // flip all bits = 001 (1)
        [12] call CBA_fnc_bitwiseNOT; // returns 1
        // 12's set bits = 110 (8,4)
        // flip all bits = 001 (1)
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)
params [["_num",1,[0]],"_base"];
_num = floor abs _num;
private _exp = floor BASE2LOG(_num);
if (!isNil "_base" && {_base isEqualType 0 && {_base > _exp}}) then {_exp = floor abs _base};
if (_exp >= 24) exitWith {false};
(2^(_exp+1))-1-_num