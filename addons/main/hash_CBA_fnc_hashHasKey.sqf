/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashHasKey

Description:
	Check if a Hash has a value defined for a key.

Parameters:
	_hash - Hash to look for key in [Array which is a Hash structure]
	_key - Key to search for in Hash [Any]

Returns:
	True if key defined, false if not defined [Boolean]
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "hash.inc.sqf"

SCRIPT(hashHasKey);

// -----------------------------------------------------------------------------

PARAMS_2(_hash,_key);
	
_key in (_hash select HASH_KEYS); // Return.