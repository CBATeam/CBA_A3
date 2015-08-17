// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_hashes);

// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
private ["_hash", "_expected", "_result"];

LOG("Testing Hashes");

// UNIT TESTS (initStrings.sqf - stringJoin)
TEST_DEFINED("CBA_fnc_hashCreate","");
TEST_DEFINED("CBA_fnc_hashGet","");
TEST_DEFINED("CBA_fnc_hashSet","");
TEST_DEFINED("CBA_fnc_hashHasKey","");
TEST_DEFINED("CBA_fnc_isHash","");

TEST_FALSE([[]] call CBA_fnc_isHash,"CBA_fnc_isHash");
_hash = [5, [4], [1], 2]; // Not a real hash.
TEST_FALSE([_hash] call CBA_fnc_isHash,"CBA_fnc_isHash");
TEST_FALSE([5] call CBA_fnc_isHash,"CBA_fnc_isHash");

// Putting in and retrieving values.
_hash = [] call CBA_fnc_hashCreate;
TEST_DEFINED("_hash","hashSet/Get");
TEST_TRUE([_hash] call CBA_fnc_isHash,"CBA_fnc_isHash");

_result = [_hash, "frog"] call CBA_fnc_hashHasKey;
TEST_FALSE(_result,"hashHashKey");

[_hash, "frog", 12] call CBA_fnc_hashSet;
TEST_TRUE([_hash] call CBA_fnc_isHash,"CBA_fnc_isHash");

_result = [_hash, "frog"] call CBA_fnc_hashGet;
TEST_OP(_result,==,12,"hashSet/Get");

_result = [_hash, "frog"] call CBA_fnc_hashHasKey;
TEST_TRUE(_result,"hashHashKey");

_result = [_hash, "fish"] call CBA_fnc_hashHasKey;
TEST_FALSE(_result,"hashHashKey");

// Unsetting a value
[_hash, "frog", nil] call CBA_fnc_hashSet;

_result = [_hash, "frog"] call CBA_fnc_hashGet;
TEST_TRUE(isNil "_result","hashSet/Get");

// Value never put in is nil.
_result = [_hash, "fish"] call CBA_fnc_hashGet;
TEST_TRUE(isNil "_result","hashSet/Get");

// Reading in from array
_hash = [[["fish", 7], ["frog", 99]]] call CBA_fnc_hashCreate;
TEST_TRUE([_hash] call CBA_fnc_isHash,"CBA_fnc_isHash");

_result = [_hash, "frog"] call CBA_fnc_hashGet;
TEST_DEFINED("_result","hashSet/Get");
TEST_OP(_result,==,99,"hashSet/Get");

// Alternative defaults.
_hash = [[["frog", -8]], 0] call CBA_fnc_hashCreate;
TEST_TRUE([_hash] call CBA_fnc_isHash,"CBA_fnc_isHash");

_result = [_hash, "frog"] call CBA_fnc_hashGet;
TEST_DEFINED("_result","hashSet/Get");
TEST_OP(_result,==,-8,"hashSet/Get");

_result = [_hash, "fish"] call CBA_fnc_hashGet;
TEST_DEFINED("_result","hashSet/Get");
TEST_OP(_result,==,0,"hashSet/Get");

[_hash, "frog", 1] call CBA_fnc_hashSet;
_result = [_hash, "frog"] call CBA_fnc_hashGet;
TEST_DEFINED("_result","hashSet/Get");
TEST_OP(_result,==,1,"hashSet/Get");

[_hash, "frog", nil] call CBA_fnc_hashSet;
_result = [_hash, "frog"] call CBA_fnc_hashGet;
TEST_TRUE(isNil "_result","hashSet/Get");

nil;
