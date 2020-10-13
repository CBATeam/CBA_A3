#include "script_component.hpp"
#include "script_hashes.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashValues

Description:
    Returns all values in a Hash.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to get values for [Array which is a Hash structure]

Returns:
    Array of all values [Array]

Author:
    Fusselwurm
---------------------------------------------------------------------------- */
SCRIPT(hashValues);

// -----------------------------------------------------------------------------
params [["_hash", [[], []], [[]]]];

+(_hash select HASH_VALUES)
