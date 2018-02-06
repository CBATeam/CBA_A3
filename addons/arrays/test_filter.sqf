// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_filter);

// ----------------------------------------------------------------------------

private ["_original", "_expected", "_result", "_fn"];

_fn = "CBA_fnc_filter";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_filter","");

// Filter to new array.
_original = [];
_result = [[], {_x * 10}] call CBA_fnc_filter;
_expected = [];
TEST_OP(str _result,==,str _expected,_fn);
TEST_OP(str _original,==,str _expected,_fn);

_original = [1, 2, 3];
_result = [_original, {_x + 1}] call CBA_fnc_filter;
_expected = [2, 3, 4];
TEST_OP(str _result,==,str _expected,_fn);
TEST_OP(str _original,!=,str _expected,_fn);

_original = [1, 2, 3];
_result = [_original, {_x}, false] call CBA_fnc_filter;
_expected = [1, 2, 3];
TEST_OP(str _result,==,str _expected,_fn);

// Filter in place.
_original = [];
_result = [_original, {_x * 10}, true] call CBA_fnc_filter;
_expected = [];
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);

_original = [1, 2, 3];
_result = [_original, {_x + 1}, true] call CBA_fnc_filter;
_expected = [2, 3, 4];
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);

_original = [1, 2, 3];
_result = [_original, {_x}, true] call CBA_fnc_filter;
_expected = [1, 2, 3];
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);

nil;
