// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_findNull);

// ----------------------------------------------------------------------------

private ["_original", "_expected", "_result", "_fn"];

_fn = "CBA_fnc_findNull";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_findNull","");

// Use of embedded null
_result = ["", objNull, player, 3] call CBA_fnc_findNull;
_expected = 1;
TEST_OP(_result,==,_expected,_fn);

// Only find first Null
_result = ["", player, objNull, displayNull, 4] call CBA_fnc_findNull;
_expected = 2;
TEST_OP(_result,==,_expected,_fn);

// Return not found if there is no null
_result = ["", player, 5] call CBA_fnc_findNull;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return a not found if empty array is given
_result = [] call CBA_fnc_findNull;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return a not found when a non array is given
_result = "not an array" call CBA_fnc_findNull;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

nil;
