/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseLSHFT

Description:
    Performs a bitwise LEFT-SHIFT operation on a given number.

    * This function converts all inputs into positive integers.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will cause unexpected behavior.

Parameters:
    _num    -   the number to shift <NUMBER>
    _numShift -   the number of shifts to perform <NUMBER>

Returns:
    Shifted number <NUMBER>

Examples:
    (begin example)
        25 call CBA_fnc_bitwiseLSHFT; // returns 50
        // 25's set bits                                  =     11001 (16,8,1) 
        // shift bits left by 1, fill one's place with 0  =    110010 (32,16,2)
        // sum of shifted bits = 50
        [25,3] call CBA_fnc_bitwiseLSHFT; // returns 200
        // 25's set bits                                  =     11001 (16,8,1) 
        // shift bits left by 3, fill blank places with 0 =  11001000 (128,64,8)
        // sum of shifted bits = 200
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
params [["_num",1,[0]],["_numShift",0,[0]]];
_num = floor _num;
_numShift = floor _numShift;
_num * 2^_numShift