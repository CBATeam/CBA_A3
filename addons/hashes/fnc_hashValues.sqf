#include "script_component.hpp"
#include "script_hashes.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashValues

Description:
    Returns all values in a Hash.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to get values for <ARRAY>(CBA HASH)

Returns:
    Array of all values <ARRAY>

Author:
    Fusselwurm
---------------------------------------------------------------------------- */
SCRIPT(hashValues);

// -----------------------------------------------------------------------------
params [["_hash", [[], []], [[]]]];

 [] + (_hash select HASH_VALUES) // flat-copy
