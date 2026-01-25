// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_prettyFormat);

// ----------------------------------------------------------------------------

LOG("Testing CBA_fnc_prettyFormat");

private _fn = "CBA_fnc_prettyFormat";
TEST_DEFINED("CBA_fnc_prettyFormat","");

private _val = [] call CBA_fnc_prettyFormat;
private _exp = "[]";
TEST_OP(_val,isEqualTo,_exp,_fn);

_val = [[], "xY", nil, 2] call CBA_fnc_prettyFormat;
_exp = "xYxY[]";
TEST_OP(_val,isEqualTo,_exp,_fn);

_val = [[0, 1, ["22", 33, []], 4]] call CBA_fnc_prettyFormat;
_exp = [
    "[",
    "    0,",
    "    1,",
    "    [",
    "        ""22"",",
    "        33,",
    "        []",
    "    ],",
    "    4",
    "]"
] joinString endl;
TEST_OP(_val,isEqualTo,_exp,_fn);

_val = [[0, 1, ["22", 33, []], 4], ">---", "\n"] call CBA_fnc_prettyFormat;
_exp = "[\n>---0,\n>---1,\n>---[\n>--->---""22"",\n>--->---33,\n>--->---[]\n>---],\n>---4\n]";
TEST_OP(_val,isEqualTo,_exp,_fn);

_val = [[[[]]], """", endl, 1] call CBA_fnc_prettyFormat;
_exp = [
    """[",
    """""[",
    """""""[]",
    """""]",
    """]"
] joinString endl;
TEST_OP(_val,isEqualTo,_exp,_fn);
