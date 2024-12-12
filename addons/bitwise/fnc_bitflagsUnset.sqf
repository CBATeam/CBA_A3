/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsUnset

Description:
    Unsets the flags' specified bits in the flagset. Has no effect if the bits are already unset.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flagset    - a number representing currently set bitflags <NUMBER>
    _flags      - the flags to unset <NUMBER>

Returns:
    Sum of set bits as a decimal number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        [55,17] call CBA_fnc_bitflagsUnset; // returns 38
        // 55's set bits = 32,16,4,2,1
        // 17's set bits = 16,1
        // common bits = 16,1
        // 55's unique bits = 32,4,2
        // sum of all set bits = 38

        // alternatively:
        [32+16+4+2+1,16+1] call CBA_fnc_bitflagsUnset;
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
params ["_flagset","_flags"];
[_flagset,_flags call CBA_fnc_bitwiseNOT] call CBA_fnc_bitwiseAND;

// or 

_flagset - (_this call CBA_fnc_bitwiseAND)
