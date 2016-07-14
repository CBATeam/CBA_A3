// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_join);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn"];

_fn = "CBA_fnc_join";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_join","");

_result = [[], "x"] call CBA_fnc_join;
_expected = "";
TEST_OP(_result,==,_expected,_fn);

_result = [[""], "x"] call CBA_fnc_join;
_expected = "";
TEST_OP(_result,==,_expected,_fn);

_result = [["frog"], "x"] call CBA_fnc_join;
_expected = "frog";
TEST_OP(_result,==,_expected,_fn);

_result = [["", ""], "x"] call CBA_fnc_join;
_expected = "x";
TEST_OP(_result,==,_expected,_fn);

_result = [["a","b","c"], "x"] call CBA_fnc_join;
_expected = "axbxc";
TEST_OP(_result,==,_expected,_fn);

_result = [["a",1,[objNull]], "x^x"] call CBA_fnc_join;
_expected = "ax^x1x^x[<Null-Object>]";
TEST_OP(_result,==,_expected,_fn);

nil;
