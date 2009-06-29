// ----------------------------------------------------------------------------

// TODO: This should be an auto-generated file.

#include "script_component.hpp"

SCRIPT(test-arrays);

// ----------------------------------------------------------------------------

private "_tests";

_tests = ["filter", "inject", "join", "shuffle"];

LOG("=== Testing Arrays");

{
	call compile preprocessFileLineNumbers format ["\x\cba\addons\arrays\test_%1.sqf", _x];
} forEach _tests;

nil;
