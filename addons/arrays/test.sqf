// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_strings);

// ----------------------------------------------------------------------------

private "_tests";

_tests = ["filter", "inject", "join", "shuffle"];

{
	call COMPILEPREPROCESS("\x\cba\addons\arrays\test_" + _x);
} forEach _tests;

nil;