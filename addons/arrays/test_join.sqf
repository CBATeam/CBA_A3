// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_join);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn"];

_fn = "CBA_fnc_join";
ASSERT_DEFINED(_fn,"");

LOG("Testing " + _fn);

_result = [[], "x"] call CBA_fnc_join;
_expected = "";
ASSERT_OP(_result,==,_expected,_fn);

_result = [[""], "x"] call CBA_fnc_join;
_expected = "";
ASSERT_OP(_result,==,_expected,_fn);

_result = [["frog"], "x"] call CBA_fnc_join;
_expected = "frog";
ASSERT_OP(_result,==,_expected,_fn);

_result = [["", ""], "x"] call CBA_fnc_join;
_expected = "x";
ASSERT_OP(_result,==,_expected,_fn);

_result = [["a","b","c"], "x"] call CBA_fnc_join;
_expected = "axbxc";
ASSERT_OP(_result,==,_expected,_fn);

_result = [["a",1,[objNull]], "x^x"] call CBA_fnc_join;
_expected = "ax^x1x^x[<Null-Object>]";
ASSERT_OP(_result,==,_expected,_fn);

nil;
