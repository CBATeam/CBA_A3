// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_findFirstEmptyEntry);

// ----------------------------------------------------------------------------

private ["_original", "_expected", "_result", "_fn"];

_fn = "CBA_fnc_findFirstEmptyEntry";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_findFirstEmptyEntry","");

_original = ["", player, "", player, nil, "", player, nil];
_result = ["", player, "", player, nil, "", player, nil] call CBA_fnc_findFirstEmptyEntry;
_expected = 4;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["", nil, "", player, nil, "", player, nil];
_result = ["", nil, "", player, nil, "", player, nil] call CBA_fnc_findFirstEmptyEntry;
_expected = 1;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);



_original = ["", player, "", nil, nil, "", player, nil];
_result = ["", player, "", nil, nil, "", player, nil] call CBA_fnc_findFirstEmptyEntry;
_expected = 3;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["", player, "", player, "", "", player, nil];
_result = ["", player, "", player, "", "", player, nil] call CBA_fnc_findFirstEmptyEntry;
_expected = 7;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);

nil;
