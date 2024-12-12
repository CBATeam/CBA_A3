/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseLSHFT

Description:
    Performs a bitwise LEFT-SHIFT operation on a given number.

    * This function returns an integer.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will cause unexpected behavior.

Parameters:
    _num    -   the number to shift <NUMBER>
    _numShift -   the number of shifts to perform <NUMBER>

Returns:
    Shifted number <NUMBER>

Examples:
    (begin example)
        captive addaction ["rescue",CBA_fnc_actionargument_path,[[],{[_target] join (group _caller)},true]] //captive joins action callers group, action is removed (true)
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
params [["_num",1,[0]],["_numShift",0,[0]]];
_num = floor _num;
_numShift = floor _numShift;
_num * 2^_numShift