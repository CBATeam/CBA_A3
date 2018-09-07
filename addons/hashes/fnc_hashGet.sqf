#include "script_component.hpp"
#include "script_hashes.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashGet

Description:
    Gets a value for a given key from a Hash.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to look for key in [Array which is a Hash structure]
    _key - Key to search for in Hash [Any]

Returns:
    Value associated with the key, or Hash default value if key missing [Any]

Author:
    Spooner
---------------------------------------------------------------------------- */

SCRIPT(hashGet);

// -----------------------------------------------------------------------------
params [["_hash", [], [[]]], "_key"];

private _index = (_hash select HASH_KEYS) find _key;

if (_index >= 0) then {
    (_hash select HASH_VALUES) select _index // Return.
} else {
    private _default = param [2, _hash select HASH_DEFAULT_VALUE];

    if (isNil "_default") then {
        nil // Return
    } else {
        // Make a copy of the array instead!
        if (_default isEqualType []) then {
            _default = + _default;
        };
        _default // Return.
    };
};
