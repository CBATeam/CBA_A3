// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_insert);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn"];

_fn = "CBA_fnc_insert";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_insert","");

// Test example
_result = ["a", "b", "e"];
[_result, 2, ["c", "d"]] call CBA_fnc_insert;
_expected = ["a", "b", "c", "d", "e"];
TEST_OP(_result,isEqualTo,_expected,_fn);

// Test empty array
_result = [];
[_result, 0, [6, 6]] call CBA_fnc_insert;
_expected = [6, 6];
TEST_OP(_result,isEqualTo,_expected,_fn);

nil;
