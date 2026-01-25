// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_shuffle);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn", "_original"];

_fn = "CBA_fnc_shuffle";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_shuffle","");

_original = [1, 2, 3];
_result = [_original] call CBA_fnc_shuffle;
TEST_OP(count _result,==,count _original,_fn);

{
    TEST_OP(_x,in,_original,_fn);
} forEach _result;

// Result will be empty array because the function expects an array as the first param (test throws a param error)
_original = [1, 2, 3];
_result = _original call CBA_fnc_shuffle;
TEST_OP(_result,isEqualTo,[],_fn);

_original = [];
_result = [_original] call CBA_fnc_shuffle;
TEST_OP(count _result,==,count _original,_fn);

_original = [1, 2, 3];
_result = [_original,true] call CBA_fnc_shuffle;
_result set [0,100];
TEST_OP((_original select 0),==,100,_fn);

nil;
