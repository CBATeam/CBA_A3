#define THIS_FILE CBA\main\hashHasKey
scriptName 'THIS_FILE';
// -----------------------------------------------------------------------------
// @description Check if a Hash has a value defined for a key.
//
// Params:
//   0: _hash - Hash to look for key in [Array which is a Hash structure]
//   1: _key - Key to search for in Hash [Any]
//
// Returns:
//   True if key defined, false if not defined [Boolean]
// -----------------------------------------------------------------------------

#include "script_component.hpp"
#include "hash.inc.sqf"

// -----------------------------------------------------------------------------

PARAMS_2(_hash,_key);
	
_key in (_hash select HASH_KEYS); // Return.