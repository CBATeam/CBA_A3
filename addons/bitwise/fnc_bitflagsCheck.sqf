/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsCheck

Description:
    Checks if a given flagset has the specified flags set.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will be clamped.

Parameters:
    _flagset    - flagset to check for flags within <NUMBER>
    _flags      - flags to check for <NUMBER>

Returns:
    Sum of set bits as a decimal number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        [47,6] call CBA_fnc_bitflagsCheck // returns 6
        // 47's set bits = 32+8+4+2+1
        // 6's set bits = 4+2
        // set bits in common = 4, 2
        // sum of common set bits = 6 
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
_this call CBA_fnc_bitwiseAND;