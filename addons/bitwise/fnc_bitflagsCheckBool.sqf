/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsCheckBool

Description:
    Checks if a given flagset has the specified flags set.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flagset    - flagset to check for flags within <NUMBER>
    _flags      - flags to check for <NUMBER>

Returns:
    True if at least one flag bit is set within the flagset, false otherwise. <BOOLEAN>

Examples:
    (begin example)
        [47,6] call CBA_fnc_bitflagsCheckBool // returns true:
        // 47's set bits = 32+8+4+2+1
        // 6's set bits = 4+2
        // set bits in common = 4, 2
        // sum of common set bits = 6 which is > 0 so = true
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
_this call CBA_fnc_bitwiseAND > 0