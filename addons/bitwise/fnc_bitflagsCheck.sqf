/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitflagsCheck

Description:
    Checks if a given flagset has the specified flags set.

    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs of 2^24 or more return -1.

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
params ["_flagset","_flags"];

_flagset = floor abs _flagset;
_flags = floor abs _flags;
if ((_flagset max _flags) >= 16777216) exitWith {-1}; // precision drop after 2^24

// sum of the bits of _flags that are not set in _flagset, bit by bit (exact below 2^24, unlike ln based bit counts)
private _return = 0;
private _power = 1;

while {_power <= _flags} do {
    if ((floor (_flags / _power)) mod 2 == 1 && {(floor (_flagset / _power)) mod 2 == 0}) then {
        _return = _return + _power;
    };
    _power = _power * 2;
};

_return
