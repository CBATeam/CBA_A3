// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_hashEachPair);

// ----------------------------------------------------------------------------

private ["_hash", "_expected", "_sumKeys", "_sumValues", "_totalIterations", "_fn"];

_fn = "CBA_fnc_hashEachPair";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_hashEachPair","");

_hash = [[[1, 12], [5, 25]], 88] call CBA_fnc_hashCreate;

_sumKeys = 0;
_sumValues = 0;
_totalIterations = 0;

[_hash,
{
    ADD(_sumKeys,_key);
    ADD(_sumValues,_value);
    INC(_totalIterations);
}] call CBA_fnc_hashEachPair;

_expected = 6;
TEST_OP(_sumKeys,==,_expected,"");

_expected = 37;
TEST_OP(_sumValues,==,_expected,"");

_expected = 2;
TEST_OP(_totalIterations,==,_expected,"");
