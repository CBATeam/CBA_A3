// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#define DEBUG_SYNCHRONOUS
#include "script_component.hpp"

SCRIPT(test_standardDeviation);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn"];

_fn = "CBA_fnc_standardDeviation";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_standardDeviation","");

// Test population standard deviation
_result = [[1, 2, 3, 4, 5, 6, 7]] call CBA_fnc_standardDeviation;
_expected = 2;
TEST_OP(_result,isEqualTo,_expected,_fn);

// Test sample standard deviation
_result = [[1, 2, 3], 1] call CBA_fnc_standardDeviation;
_expected = 1;
TEST_OP(_result,isEqualTo,_expected,_fn);

// Test empty array
_result = [[]] call CBA_fnc_standardDeviation;
_expected = 0;
TEST_OP(_result,isEqualTo,_expected,_fn);

nil;
