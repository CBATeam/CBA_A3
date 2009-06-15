#define THIS_FILE CBA\main\test_hash
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

// ----------------------------------------------------------------------------

// UNIT TESTS (initStrings.sqf - stringJoin)
ASSERT_DEFINED("CBA_fnc_hashCreate","");
ASSERT_DEFINED("CBA_fnc_hashGet","");
ASSERT_DEFINED("CBA_fnc_hashSet","");
ASSERT_DEFINED("CBA_fnc_hashHasKey","");

ASSERT_FALSE(IS_HASH([]),"Testing IS_HASH()");

// Putting in and retreiving values.
_hash = [] call hashCreate;
ASSERT_TRUE(IS_HASH(_hash),"Testing IS_HASH()");

[_hash, "frog", 12] call hashSet;
ASSERT_TRUE(IS_HASH(_hash),"IS_HASH()");

_result = [_hash, "frog"] call CBA_fnc_hashGet;
ASSERT_DEFINED("_result","hashSet/Get");
ASSERT_OP(_result,==,12,"hashSet/Get");

// Unsetting a value
[_hash, "frog", nil] call CBA_fnc_hashSet;

_result = [_hash, "frog"] call CBA_fnc_hashGet;
ASSERT_TRUE(isNil "_result","hashSet/Get");

// Value never put in is nil.
_result = [_hash, "fish"] call CBA_fnc_hashGet;
ASSERT_TRUE(isNil "_result","hashSet/Get");

// Reading in from array
_hash = [[["fish", 7], ["frog", 99]]] call CBA_fnc_hashCreate;
ASSERT_TRUE(IS_HASH(_hash),"Testing IS_HASH()");

_result = [_hash, "frog"] call CBA_fnc_hashGet;
ASSERT_DEFINED("_result","hashSet/Get");
ASSERT_OP(_result,==,99,"hashSet/Get");

// Alternative defaults.
_hash = [[["frog", -8]], 0] call CBA_fnc_hashCreate;
ASSERT_TRUE(IS_HASH(_hash),"Testing IS_HASH()");

_result = [_hash, "frog"] call CBA_fnc_hashGet;
ASSERT_DEFINED("_result","hashSet/Get");
ASSERT_OP(_result,==,-8,"hashSet/Get");

_result = [_hash, "fish"] call CBA_fnc_hashGet;
ASSERT_DEFINED("_result","hashSet/Get");
ASSERT_OP(_result,==,0,"hashSet/Get");

[_hash, "frog", 1] call CBA_fnc_hashSet;
_result = [_hash, "frog"] call CBA_fnc_hashGet;
ASSERT_DEFINED("_result","hashSet/Get");
ASSERT_OP(_result,==,1,"hashSet/Get");

[_hash, "frog", nil] call CBA_fnc_hashSet;
_result = [_hash, "frog"] call CBA_fnc_hashGet;
ASSERT_TRUE(isNil "_result","hashSet/Get");

// -----------------------------------------------------------------------------
LOG("Tests complete");