/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseNOT

Description:
    Performs a bitwise NOT operation on a number. All bits are flipped.
    This function assumes that the largest power of 2 that _num stores is the number of bits it occupies.

* This function returns a non-negative integer.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _num   -   a decimal number <NUMBER>

Returns:
    Sum of set bits as a decimal number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        captive addaction ["rescue",CBA_fnc_actionargument_path,[[],{[_target] join (group _caller)},true]] //captive joins action callers group, action is removed (true)
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
params [["_num",1,[0]]];
_num = floor abs _num;
private _exp = floor((ln _num)*1.44269502162933349609);
if (_exp >= 24) exitWith {false};
(2^(_exp+1))-1-_num;