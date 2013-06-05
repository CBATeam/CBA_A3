// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_hashes);

// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
private ["_hash", "_expected", "_result"];

LOG("Testing Hashes");

// UNIT TESTS (initStrings.sqf - stringJoin)
ASSERT_DEFINED("CBA_fnc_hashCreate","");
ASSERT_DEFINED("CBA_fnc_hashGet","");
ASSERT_DEFINED("CBA_fnc_hashSet","");
ASSERT_DEFINED("CBA_fnc_hashHasKey","");
ASSERT_DEFINED("CBA_fnc_isHash","");

ASSERT_FALSE([[]] call CBA_fnc_isHash,"CBA_fnc_isHash");
_hash = [5, [4], [1], 2]; // Not a real hash.
ASSERT_FALSE([_hash] call CBA_fnc_isHash,"CBA_fnc_isHash");
ASSERT_FALSE([5] call CBA_fnc_isHash,"CBA_fnc_isHash");

// Putting in and retreiving values.
_hash = [] call CBA_fnc_hashCreate;
ASSERT_DEFINED("_hash","hashSet/Get");
ASSERT_TRUE([_hash] call CBA_fnc_isHash,"CBA_fnc_isHash");

_result = [_hash, "frog"] call CBA_fnc_hashHasKey;
ASSERT_FALSE(_result,"hashHashKey");

[_hash, "frog", 12] call CBA_fnc_hashSet;
ASSERT_TRUE([_hash] call CBA_fnc_isHash,"CBA_fnc_isHash");

_result = [_hash, "frog"] call CBA_fnc_hashGet;
ASSERT_OP(_result,==,12,"hashSet/Get");

_result = [_hash, "frog"] call CBA_fnc_hashHasKey;
ASSERT_TRUE(_result,"hashHashKey");

_result = [_hash, "fish"] call CBA_fnc_hashHasKey;
ASSERT_FALSE(_result,"hashHashKey");

// Unsetting a value
[_hash, "frog", nil] call CBA_fnc_hashSet;

_result = [_hash, "frog"] call CBA_fnc_hashGet;
ASSERT_TRUE(_result == "UNDEF","hashSet/Get");

// Value never put in is nil.
_result = [_hash, "fish"] call CBA_fnc_hashGet;
ASSERT_TRUE(isNil "_result","hashSet/Get");

// Reading in from array
_hash = [[["fish", 7], ["frog", 99]]] call CBA_fnc_hashCreate;
ASSERT_TRUE([_hash] call CBA_fnc_isHash,"CBA_fnc_isHash");

_result = [_hash, "frog"] call CBA_fnc_hashGet;
ASSERT_DEFINED("_result","hashSet/Get");
ASSERT_OP(_result,==,99,"hashSet/Get");

// Alternative defaults.
_hash = [[["frog", -8]], 0] call CBA_fnc_hashCreate;
ASSERT_TRUE([_hash] call CBA_fnc_isHash,"CBA_fnc_isHash");

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
ASSERT_TRUE(_result == "UNDEF","hashSet/Get");

nil;
