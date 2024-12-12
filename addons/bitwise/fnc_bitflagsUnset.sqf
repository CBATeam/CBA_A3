/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsUnset

Description:
    Unsets the flags' specified bits in the flagset. Has no effect if the bits are already unset.

    * This function assumes the larger number is the flagset and the smaller number is the flags for calculation parity.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flags      - the flags to unset <NUMBER>
    _flagset    - a number representing currently set bitflags <NUMBER>

Returns:
    Sum of set bits on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        [14,55] call CBA_fnc_bitflagsUnset; // returns 49
        // 14's set bits    = 001110 (8,4,2)
        // 55's set bits    = 110111 (32,16,4,2,1)
        // common set bits  = 000110 (4,2)
        // 55's unique bits = 110001 (32,16,1)
        // sum of unique bits = 49
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
_this sort true;
params ["_flags","_flagset"];
(floor abs _flagset) - ([_flags, _flagset] call CBA_fnc_bitwiseAND)
