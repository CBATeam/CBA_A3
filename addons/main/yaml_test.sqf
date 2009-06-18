// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_strings);

// ----------------------------------------------------------------------------

private ["_pos", "_str", "_array", "_expected", "_result", "_fn"];

LOG('----- STARTED PREFIX\COMPONENT\yaml TESTS -----');

_data = ["\x\cba\addons\main\yaml_test_config.yaml"] call CBA_fnc_parseYaml;

ASSERT_TRUE([_data] call CBA_fnc_isHash,"");

_result = [_data, "anotherNumber"] call CBA_fnc_HashGet;
_expected = "42";
ASSERT_OP(_result,==,_expected,"");

_result = ([_data, "nestedArray"] call CBA_fnc_HashGet) select 0;
_expected = "first";
ASSERT_OP(_result,==,_expected,"");

_result = (([_data, "nestedArray"] call CBA_fnc_HashGet) select 2) select 1;
_expected = "3.2";
ASSERT_OP(_result,==,_expected,"");

// -----------------------------------------------------------------------------
LOG('----- COMPLETED PREFIX\COMPONENT\yaml TESTS -----');