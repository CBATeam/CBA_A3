// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_findTypeOf);

// ----------------------------------------------------------------------------

private ["_original", "_expected", "_result", "_fn"];

_fn = "CBA_fnc_findTypeOf";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_findTypeOf","");

// Find by class name string
_result = [["", player, 5], typeOf player] call CBA_fnc_findTypeOf;
_expected = 1;
TEST_OP(_result,==,_expected,_fn);

// Find by object
_result = [["", player, 5], player] call CBA_fnc_findTypeOf;
_expected = 1;
TEST_OP(_result,==,_expected,_fn);

// Find first only
_result = [["", player, 5, objNull, player], typeOf player] call CBA_fnc_findTypeOf;
_expected = 1;
TEST_OP(_result,==,_expected,_fn);

// Find first only, mixed solutions in array
_result = [["", typeOf player, 5, objNull, player], typeOf player] call CBA_fnc_findTypeOf;
_expected = 1;
TEST_OP(_result,==,_expected,_fn);

// Return not found, when no matching element is in array
_result = [["", 5, objNull], typeOf player] call CBA_fnc_findTypeOf;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return not found, when empty array is passed
_result = [[], typeOf player] call CBA_fnc_findTypeOf;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return not found, when a non array is passed
_result = ["not an array", typeOf player] call CBA_fnc_findTypeOf;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return not found, when search parameter is not an object or string
_result = [["", player, 5, objNull], 5] call CBA_fnc_findTypeOf;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return not found, when parameters are nil
_result = [nil, nil] call CBA_fnc_findTypeOf;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

nil;
