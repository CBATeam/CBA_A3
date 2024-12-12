/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsCheckAll

Description:
    Checks if a given flagset has all the specified flags set.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flags      - flags to check for <NUMBER>
    _flagset    - flagset to check for flags within <NUMBER>

Returns:
    True on success, sum of not-set bits on failure, false otherwise. <BOOLEAN>

Examples:
    (begin example)
        [22,47] call CBA_fnc_bitflagsCheckAll // returns 16
        // 22's set bits    = 010110 (16,4,2)
        // 47's set bits    = 101111 (32,8,4,2,1)
        // common set bits  = 000110 (4,2)
        // 22's unique bits = 010000 (16)
        // 16 != 0 so return 16

        [6,47] call CBA_fnc_bitflagsCheckAll // returns true
        // 6's set bits     = 000110 (4,2)
        // 47's set bits    = 101111 (32,8,4,2,1)
        // common set bits  = 000110 (4,2)
        // 6's unique bits  = 000000 (0)
        // 0 = 0 so return true
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)
params ["_flagset","_flags"];
_flagset = [_flagset,floor BASE2LOG(_flagset max _flags)] call CBA_fnc_bitwiseNOT;
private _res = [_flags,_flagset] call CBA_fnc_bitwiseAND;
if (_res isEqualTo 0) exitWith {true};
_res