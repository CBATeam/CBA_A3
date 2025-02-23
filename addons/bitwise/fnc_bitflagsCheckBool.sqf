/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsCheckBool

Description:
    Checks if a given flagset has the specified flags set.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flagset    - flagset to check for flags within <NUMBER>
    _flags      - flags to check for <NUMBER>

Returns:
    True on success, false otherwise. <BOOLEAN>

Examples:
    (begin example)
        [70,47] call CBA_fnc_bitflagsCheckBool // returns false:
        // 70's set bits    = 1000110 (64,4,2)
        // 47's set bits    = 0101111 (32,8,4,2,1)
        // common set bits  = 0000110 (4,2)
        // 47's unique bits = 0101001 (32,8,1)
        // sum of 47's unique bits = 41
        // 41 != 0 so return false
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
(call CBA_fnc_bitflagsCheck) isEqualTo 0
