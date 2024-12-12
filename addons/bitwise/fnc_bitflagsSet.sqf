/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsSet

Description:
    Sets the flags' specified bits in the flagset. Has no effect if the bits are already set.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flags      - flags to set <NUMBER>
    _flagset    - flagset to set flags within <NUMBER>

Returns:
    Sum of set bits on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        [12,55] call CBA_fnc_bitflagsSet; // returns 63
        // 12's set bits = 001100 (8,4)
        // 55's set bits = 110111 (32,16,4,2,1)
        // all set bits  = 111111 (32,16,8,4,2,1)
        // sum of all set bits = 63
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
_this call CBA_fnc_bitwiseOR;