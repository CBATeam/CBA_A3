/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsFlip

Description:
    Flips the flags' specified bits in the flagset.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flags      - flags to flip <NUMBER>
    _flagset    - flagset to flip flags within <NUMBER>

Returns:
    Sum of set bits on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        [23,62] call CBA_fnc_bitflagsFlip; // returns 41
        // 23's set bits     = 010111 (16,4,2,1)
        // 62's set bits     = 111110 (32,16,8,4,2)
        // common set bits   = 010110 (16,4,2,1)
        // unique set bits   = 101001 (32,8,1)
        // sum of unique bits = 41
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
_this call CBA_fnc_bitwiseXOR;