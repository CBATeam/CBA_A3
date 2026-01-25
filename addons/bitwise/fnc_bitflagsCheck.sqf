/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsCheck

Description:
    Checks if a given flagset has the specified flags set.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flagset    - flagset to check for flags within <NUMBER>
    _flags      - flags to check for <NUMBER>

Returns:
    The sum of not-set bits on success, -1 on error. <NUMBER>

Examples:
    (begin example)
        [47,22] call CBA_fnc_bitflagsCheck // returns 16
        // 47's set bits    = 101111 (32,8,4,2,1)
        // 22's set bits    = 010110 (16,4,2)
        // common set bits  = 000110 (4,2)
        // 22's unique bits = 010000 (16)
        // sum of 22's unique bits = 16

        [47,6] call CBA_fnc_bitflagsCheck // returns 0
        // 47's set bits    = 101111 (32,8,4,2,1)
        // 6's set bits     = 000110 (4,2)
        // common set bits  = 000110 (4,2)
        // 6's unique bits  = 000000 (0)
        // sum of 6's unique bits = 0
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)
#define BITQUANT(num) floor BASE2LOG(num) + 1

params ["_flagset","_flags"];
_flagset = [_flagset,BITQUANT(_flagset max _flags)] call CBA_fnc_bitwiseNOT;
[_flagset,_flags] call CBA_fnc_bitwiseAND
