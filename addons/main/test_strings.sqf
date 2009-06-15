#define THIS_FILE test_strings
scriptName 'THIS_FILE';

// ----------------------------------------------------------------------------

#include "script_component.hpp"

// ----------------------------------------------------------------------------

private ["_pos", "_str", "_array", "_expected", "_result"];

// UNIT TESTS (stringFind)
ASSERT_DEFINED("stringFind","");

_pos = ["frog", "f"] call CBA_fnc_find;
ASSERT_OP(_pos,==,0,"stringFind 3");

_pos = ["frog", "g"] call CBA_fnc_find;
ASSERT_OP(_pos,==,3,"stringFind 2");

_pos = ["frog", "z"] call CBA_fnc_find;
ASSERT_OP(_pos,==,-1,"stringFind 3");

_pos = ["bullfrog", "frog"] call CBA_fnc_find;
ASSERT_OP(_pos,==,4,"stringFind 4");

_pos = ["bullfrog", "frogs"] call CBA_fnc_find;
ASSERT_OP(_pos,==,-1,"stringFind 5");

_pos = ["frofrog", "frog"] call CBA_fnc_find;
ASSERT_OP(_pos,==,3,"stringFind 6");

// ----------------------------------------------------------------------------
// UNIT TESTS (stringJoin)
ASSERT_DEFINED("stringJoin","");

_str = [[], "x"] call CBA_fnc_join;
ASSERT_OP(_str,==,"","stringJoin 1");

_str = [[""], "x"] call CBA_fnc_join;
ASSERT_OP(_str,==,"","stringJoin 2");

_str = [["", ""], "x"] call CBA_fnc_join;
ASSERT_OP(_str,==,"x","stringJoin 3");

_str = [["a","b","c"], "x"] call CBA_fnc_join;
ASSERT_OP(_str,==,"axbxc","stringJoin 4");

// ----------------------------------------------------------------------------
// UNIT TESTS (stringSplit)
ASSERT_DEFINED("splitString","");

_array = ["", "\"] call CBA_fnc_split;
ASSERT_OP(count _array, ==, 0, "stringSplit 1");

_array = ["\", "\"] call CBA_fnc_split;
_expected = ["", ""];
TRACE_1("stringSplit 2", _array);
ASSERT_OP(str _array, ==, str _expected, "stringSplit 2");

_array = ["\frog", "\"] call CBA_fnc_split;
_expected = ["", "frog"];
TRACE_1("stringSplit 3", _array);
ASSERT_OP(str _array, ==, str _expected, "stringSplit 3");

_array = ["\frog\", "\"] call CBA_fnc_split;
_expected = ["", "frog", ""];
TRACE_1("stringSplit 4",_array);
ASSERT_OP(str _array, ==, str _expected, "stringSplit 4");

_array = ["cheese\frog\fish", "\"] call CBA_fnc_split;
_expected = ["cheese", "frog", "fish"];
TRACE_1("stringSplit 5",_array);
ASSERT_OP(str _array, ==, str _expected, "stringSplit 5");

_array = ["peas", ""] call CBA_fnc_split;
_expected = ["p", "e", "a", "s"];
TRACE_1("stringSplit 6",_array);
ASSERT_OP(str _array, ==, str _expected, "stringSplit 6");

// ----------------------------------------------------------------------------
// UNIT TESTS (compareStrings)
_result = ["", ""] call CBA_fnc_compare;
ASSERT_OP(_result, ==, 0, "stringCompare 1");

_result = ["", "a"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, -1, "stringCompare 2");

_result = ["a", ""] call CBA_fnc_compare;
ASSERT_OP(_result, ==, +1, "stringCompare 3");

_result = ["a", "a"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, 0, "stringCompare 4");

_result = ["a", "b"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, -1, "stringCompare 5");

_result = ["b", "a"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, +1, "stringCompare 6");

_result = ["aardvark", "aardwolf"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, -1, "stringCompare 7");

_result = ["aardwolf", "aardvark"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, +1, "stringCompare 8");

// -----------------------------------------------------------------------------
LOG("Tests complete");