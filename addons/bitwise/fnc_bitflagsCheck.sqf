/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsCheck

Description:
    Checks if a given flagset has at least one of the specified flags set.

    * This function assumes the larger number is the flagset and the smaller number is the flags for calculation parity.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flags      - flags to check for <NUMBER>
    _flagset    - flagset to check for flags within <NUMBER>

Returns:
    True on success, false otherwise. <BOOLEAN>

Examples:
    (begin example)
        [70,47] call CBA_fnc_bitflagsCheck // returns true:
        // 70's set bits   = 1000110 (64,4,2)
        // 47's set bits   = 0101111 (32,8,4,2,1)
        // common set bits = 0000110 (4,2)
        // sum of common set bits = 6
        // 6 > 0 so return true
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
_this call CBA_fnc_bitwiseAND > 0