// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_inject);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn"];

_fn = "CBA_fnc_inject";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_inject","");

_result = [[], "", {_accumulator + (str _x)}] call CBA_fnc_inject;
_expected = "";
TEST_OP(_result,==,_expected,_fn);

_result = [[1, 2, 3], "", {_accumulator + (str _x)}] call CBA_fnc_inject;
_expected = "123";
TEST_OP(_result,==,_expected,_fn);

_result = [[1, 2, 3], " frogs", {(str _x) + _accumulator}] call CBA_fnc_inject;
_expected = "321 frogs";
TEST_OP(_result,==,_expected,_fn);

_result = [[1, 2, 3], 0, {_accumulator + _x}] call CBA_fnc_inject;
_expected = 6;
TEST_OP(_result,==,_expected,_fn);

nil;
