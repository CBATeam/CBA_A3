#include "script_component.hpp"
#include "script_hashes.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashKeys

Description:
    Returns all Keys in a Hash.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to get keys for <ARRAY>(CBA HASH)

Returns:
    Array of all Keys <ARRAY>

Author:
    Dedmen
---------------------------------------------------------------------------- */
SCRIPT(hashKeys);

// -----------------------------------------------------------------------------
params [["_hash", [[], []], [[]]]];

[] + (_hash select HASH_KEYS) // flat-copy
