/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsUnset

Description:
    Unsets the flags' specified bits in the flagset. Has no effect if the bits are already unset.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.

Parameters:
    _flagset    - a number representing currently set bitflags <NUMBER>
    _flags      - the flags to unset <NUMBER>

Returns:
    Sum of set bits on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        [55,14] call CBA_fnc_bitflagsUnset; // returns 49
        // 55's set bits    = 110111 (32,16,4,2,1)
        // 14's set bits    = 001110 (8,4,2)
        // common set bits  = 000110 (4,2)
        // 55's unique bits = 110001 (32,16,1)
        // sum of unique bits = 49
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
params ["_flagset","_flags"];
private _andReturn = [_flagset,_flags] call CBA_fnc_bitwiseAND;
if (_andReturn isEqualType false) exitWith {false};
(floor abs _flagset) - _andReturn
