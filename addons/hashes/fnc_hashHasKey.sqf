#include "script_component.hpp"
#include "script_hashes.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashHasKey

Description:
    Check if a Hash has a value defined for a key.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to look for key in <ARRAY>(CBA HASH)
    _key - Key to search for in Hash <ANY>

Returns:
    True if key defined, false if not defined <BOOL>

Author:
    Spooner
---------------------------------------------------------------------------- */

SCRIPT(hashHasKey);

// -----------------------------------------------------------------------------
params [["_hash", [[], []], [[]]], "_key"];

_key in (_hash select HASH_KEYS); // Return.
