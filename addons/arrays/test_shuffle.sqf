// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_shuffle);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn"];

_fn = "CBA_fnc_shuffle";
ASSERT_DEFINED(_fn,"");

LOG("Testing " + _fn);

_original = [1, 2, 3];
_result = [_original, { _x + 1 }] call CBA_fnc_filter;
_expected = [2, 3, 4];
ASSERT_OP(str _result,==,str _expected,_fn);
ASSERT_OP(str _original,!=,str _expected,_fn);

nil;