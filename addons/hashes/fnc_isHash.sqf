#include "script_component.hpp"
#include "script_hashes.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_isHash

Description:
    Check if a value is a Hash data structure.

    See <CBA_fnc_hashCreate>.

Parameters:
    _value - Data structure to check [Any]

Returns:
    True if it is a Hash, otherwise false [Boolean]

Author:
    Spooner
---------------------------------------------------------------------------- */

SCRIPT(isHash);

// -----------------------------------------------------------------------------
params ["_hash"];

_hash isEqualType [] && {(count _hash) in [4, 5]} && {(_hash select HASH_ID) isEqualTo TYPE_HASH}
