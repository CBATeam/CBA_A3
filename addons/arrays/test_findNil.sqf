// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_findNil);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn"];

_fn = "CBA_fnc_findNil";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_findNil","");

// Use of embeded nil
_result = ["", 5, objNull, nil, player] call CBA_fnc_findNil;
_expected = 3;
TEST_OP(_result,==,_expected,_fn);

// Only find the first nil
_result = ["", 5, objNull, player, nil, nil] call CBA_fnc_findNil;
_expected = 4;
TEST_OP(_result,==,_expected,_fn);

// Return a not found when there is no nil
_result = ["", 5, objNull, displayNull, player] call CBA_fnc_findNil;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return a not found when empty array is given
_result = [] call CBA_fnc_findNil;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return a not found when a non array is given
_result = "not an array" call CBA_fnc_findNil;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

nil;
