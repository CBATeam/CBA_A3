// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_parseJSON);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn", "_data"];

_fn = "CBA_fnc_parseJSON";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_parseJSON",_fn);

/*_data = ["\x\cba\addons\hashes\test_parseJSON_config.json"] call CBA_fnc_parseJSON;

TEST_TRUE([_data] call CBA_fnc_isHash,_fn);

_result = [_data, "anotherNumber"] call CBA_fnc_hashGet;
_expected = "42";
TEST_OP(_result,==,_expected,_fn);

_result = ([_data, "nestedArray"] call CBA_fnc_hashGet) select 0;
_expected = "first";
TEST_OP(_result,==,_expected,_fn);

_result = (([_data, "nestedArray"] call CBA_fnc_hashGet) select 2) select 1;
_expected = "3.2";
TEST_OP(_result,==,_expected,_fn);

nil
