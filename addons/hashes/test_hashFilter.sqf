// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_hashFilter);

// ----------------------------------------------------------------------------

private ["_hash", "_expected", "_sumKeys", "_sumValues", "_totalIterations", "_removeOddValues"];

_fn = "CBA_fnc_hashFilter";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_hashFilter","");

_hash = [[[1, 12], [5, 25]], 88] call CBA_fnc_hashCreate;

_sumKeys = 0;
_sumValues = 0;
_totalIterations = 0;

[_hash,
{
    ADD(_sumKeys,_key);
    ADD(_sumValues,_value);
    INC(_totalIterations);
    false
}] call CBA_fnc_hashFilter;

_expected = 6;
TEST_OP(_sumKeys,==,_expected,"");
_expected = 37;
TEST_OP(_sumValues,==,_expected,"");
_expected = 2;
TEST_OP(_totalIterations,==,_expected,"");


_hash = [[["A1", 1], ["A2", 1], ["B", 2], ["C", 3], ["D1", 4], ["D2", 4], ["E1", 5], ["E2", 5]]] call CBA_fnc_hashCreate;

_sumValues = 0;
_totalIterations = 0;

_removeOddValues = {
    ADD(_sumValues,_value);
    INC(_totalIterations);
    ((_value % 2) == 1)
};
_ret = [_hash, _removeOddValues] call CBA_fnc_hashFilter;

_expected = 5;
TEST_OP(_ret,isEqualTo,_expected,"");
_expected = ["B", "D1", "D2"];
TEST_OP(_hash select 1,isEqualTo,_expected,"");
_expected = [2, 4, 4];
TEST_OP(_hash select 2,isEqualTo,_expected,"");
_expected = 25;
TEST_OP(_sumValues,==,_expected,"");
_expected = 8;
TEST_OP(_totalIterations,==,_expected,"");

