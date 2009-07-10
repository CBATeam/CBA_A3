// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_parseYaml);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn", "_data"];

_fn = "CBA_fnc_parseYaml";
ASSERT_DEFINED(_fn,_fn);

LOG("Testing " + _fn);

private ["_expected", "_result", "_fn"];

_data = ["\x\cba\addons\common\test_parseYaml_config.yml"] call CBA_fnc_parseYaml;

ASSERT_TRUE([_data] call CBA_fnc_isHash,_fn);

_result = [_data, "anotherNumber"] call CBA_fnc_hashGet;
_expected = "42";
ASSERT_OP(_result,==,_expected,_fn);

_result = ([_data, "nestedArray"] call CBA_fnc_hashGet) select 0;
_expected = "first";
ASSERT_OP(_result,==,_expected,_fn);

_result = (([_data, "nestedArray"] call CBA_fnc_hashGet) select 2) select 1;
_expected = "3.2";
ASSERT_OP(_result,==,_expected,_fn);

nil;
