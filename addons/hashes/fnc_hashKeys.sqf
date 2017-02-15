/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashGetKeys

Description:
    Returns all Keys in a Hash.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to get keys for [Array which is a Hash structure]

Returns:
    Array of all Keys [Array]

Author:
    Dedmen
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "script_hashes.hpp"

SCRIPT(hashGetKeys);

// -----------------------------------------------------------------------------
params [["_hash", [[], []], [[]]]];

+(_hash select HASH_KEYS)
