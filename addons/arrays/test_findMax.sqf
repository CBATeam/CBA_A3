// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#define DEBUG_SYNCHRONOUS
#include "script_component.hpp"

SCRIPT(test_findMax);

// ----------------------------------------------------------------------------

private ["_original", "_expected", "_result", "_fn"];

_fn = "CBA_fnc_findMax";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_findMax","");

// Test descending array
_result = [5, 4, 3, 2, 1] call CBA_fnc_findMax;
_expected = [5, 0];
TEST_OP(_result,isEqualTo,_expected,_fn);

// Test ascending array
_result = [1, 2, 3, 4, 5] call CBA_fnc_findMax;
_expected = [5, 4];
TEST_OP(_result,isEqualTo,_expected,_fn);

// Test unordered array
_result = [2, 15, 0, 4, 1] call CBA_fnc_findMax;
_expected = [15, 1];
TEST_OP(_result,isEqualTo,_expected,_fn);

// Test descending negative values array
_result = [-1, -2, -3, -4, -5] call CBA_fnc_findMax;
_expected = [-1, 0];
TEST_OP(_result,isEqualTo,_expected,_fn);

// Test unordered array with negative values
_result = [2, 15, 3, -3, 0] call CBA_fnc_findMax;
_expected = [15, 1];
TEST_OP(_result,isEqualTo,_expected,_fn);

// Test unordered array with duplicate max values
_result = [2, 15, 15, -3, -3] call CBA_fnc_findMax;
_expected = [15, 2];
TEST_OP(_result,isEqualTo,_expected,_fn);

// Test invalid parameter array with bool
_result = [1, true, 3, 4, 5] call CBA_fnc_findMax;
TEST_TRUE(isNil "_result",_fn);

// Test invalid parameter array with nil
_result = [1, nil, 3, 4, 5] call CBA_fnc_findMax;
TEST_TRUE(isNil "_result",_fn);

// Test invalid parameter array with string
_result = [1, "not a number", 3, 4, 5] call CBA_fnc_findMax;
TEST_TRUE(isNil "_result",_fn);

// Test invalid array given
_result = "not an array" call CBA_fnc_findMax;
TEST_TRUE(isNil "_result",_fn);

// Test empty array given
_result = [] call CBA_fnc_findMax;
TEST_TRUE(isNil "_result",_fn);

nil;
