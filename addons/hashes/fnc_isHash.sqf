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

#include "script_component.hpp"
#include "script_hashes.hpp"

SCRIPT(isHash);

// -----------------------------------------------------------------------------
params ["_hash"];

_hash isEqualType [] && {count _hash == 4} && {(_hash select HASH_ID) isEqualTo TYPE_HASH}
