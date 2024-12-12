/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsFlip

Description:
    Flips the flags' specified bits in the flagset.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flagset    - flagset to flip flags within <NUMBER>
    _flags      - flags to flip for <NUMBER>

Returns:
    Sum of set bits as a decimal number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        [63,23] call CBA_fnc_bitflagsFlip; // returns 40
        // 63's set bits = 32,16,8,4,2,1
        // 23's set bits = 16,4,2,1
        // bits in common = 16,4,2,1
        // bits not in common = 32,8
        // sum of unique bits = 40
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
_this call CBA_fnc_bitwiseXOR;