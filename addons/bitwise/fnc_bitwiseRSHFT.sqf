/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseRSHFT

Description:
    Performs a bitwise logical RIGHT-SHIFT operation on a given number.

    * This function returns an integer.
Parameters:
    _num    -   the number to shift <NUMBER>
    _numShift -   the number of shifts to perform <NUMBER>

Returns:
    Shifted number <NUMBER>

Examples:
    (begin example)
        25 call CBA_fnc_bitwiseRSHFT; // returns 12
        // 25's set bits                                    = 11001 (16+8+1) 
        // shift bits right by 1, discard bit in 1's place  =  1100 (8+4)
        // sum of shifted bits = 12
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
params [["_num",1,[0]],["_numShift",0,[0]]];
_num = floor _num;
_numShift = floor _numShift;
floor (_num / 2^_numShift)