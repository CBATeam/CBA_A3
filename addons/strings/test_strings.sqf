// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_strings);

// ----------------------------------------------------------------------------

private ["_pos", "_str", "_array", "_expected", "_result", "_fn"];

LOG('Testing Strings');

// UNIT TESTS (stringFind)
_fn = "CBA_fnc_find";
TEST_DEFINED("CBA_fnc_find","");

_pos = ["frog", "f"] call CBA_fnc_find;
TEST_OP(_pos,==,0,_fn);

_pos = ["frog", "g"] call CBA_fnc_find;
TEST_OP(_pos,==,3,_fn);

_pos = ["frog", "z"] call CBA_fnc_find;
TEST_OP(_pos,==,-1,_fn);

_pos = ["bullfrog", "frog"] call CBA_fnc_find;
TEST_OP(_pos,==,4,_fn);

_pos = ["bullfrog", "frogs"] call CBA_fnc_find;
TEST_OP(_pos,==,-1,_fn);

_pos = ["frofrog", "frog"] call CBA_fnc_find;
TEST_OP(_pos,==,3,_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (stringSplit)
_fn = "CBA_fnc_split";
TEST_DEFINED("CBA_fnc_split","");

_array = ["", "\"] call CBA_fnc_split;
_expected = [];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["", ""] call CBA_fnc_split;
_expected = [];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["\", "\"] call CBA_fnc_split;
_expected = ["", ""];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["\frog", "\"] call CBA_fnc_split;
_expected = ["", "frog"];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["\frog\", "\"] call CBA_fnc_split;
_expected = ["", "frog", ""];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["cheese\frog\fish", "\"] call CBA_fnc_split;
_expected = ["cheese", "frog", "fish"];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["peas", ""] call CBA_fnc_split;
_expected = ["p", "e", "a", "s"];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["abc", "abc"] call CBA_fnc_split;
_expected = ["", ""];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["abc", "long"] call CBA_fnc_split;
_expected = ["abc"];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["this\is\a\path\to\fnc_test.sqf","\fnc_"] call CBA_fnc_split;
_expected = ["this\is\a\path\to", "test.sqf"];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["babab", "bab"] call CBA_fnc_split;
_expected = ["", "ab"];
TEST_OP(str _array, ==, str _expected, _fn);

_array = ["BbabTabAbabbabababab", "bab"] call CBA_fnc_split;
_expected = ["B","TabA","","a","ab"];
TEST_OP(str _array, ==, str _expected, _fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (stringReplace)
_fn = "CBA_fnc_replace";

TEST_DEFINED("CBA_fnc_replace","");

_str = ["", "", ""] call CBA_fnc_replace;
TEST_OP(_str,==,"",_fn);

_str = ["", "frog", "fish"] call CBA_fnc_replace;
TEST_OP(_str,==,"",_fn);

_str = ["frog", "fish", "cheese"] call CBA_fnc_replace;
TEST_OP(_str,==,"frog",_fn);

_str = ["frog", "o", "a"] call CBA_fnc_replace;
TEST_OP(_str,==,"frag",_fn);

_str = ["frodo", "o", "ai"] call CBA_fnc_replace;
TEST_OP(_str,==,"fraidai",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (leftTrim)
_fn = "CBA_fnc_leftTrim";

TEST_DEFINED("CBA_fnc_leftTrim","");

_str = [""] call CBA_fnc_leftTrim;
TEST_OP(_str,==,"",_fn);

_str = ["frog"] call CBA_fnc_leftTrim;
TEST_OP(_str,==,"frog",_fn);

_str = [" frog"] call CBA_fnc_leftTrim;
TEST_OP(_str,==,"frog",_fn);

_str = ["   frog"] call CBA_fnc_leftTrim; // spaces
TEST_OP(_str,==,"frog",_fn);

_str = ["	frog"] call CBA_fnc_leftTrim; // tab
TEST_OP(_str,==,"frog",_fn);

_str = ["   "] call CBA_fnc_leftTrim;
TEST_OP(_str,==,"",_fn);

_str = [" x "] call CBA_fnc_leftTrim;
TEST_OP(_str,==,"x ",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (rightTrim)
_fn = "CBA_fnc_rightTrim";

TEST_DEFINED("CBA_fnc_rightTrim","");

_str = [""] call CBA_fnc_rightTrim;
TEST_OP(_str,==,"",_fn);

_str = ["frog"] call CBA_fnc_rightTrim;
TEST_OP(_str,==,"frog",_fn);

_str = ["frog "] call CBA_fnc_rightTrim;
TEST_OP(_str,==,"frog",_fn);

_str = ["frog   "] call CBA_fnc_rightTrim;
TEST_OP(_str,==,"frog",_fn);

_str = ["frog 	"] call CBA_fnc_rightTrim; // including tabs
TEST_OP(_str,==,"frog",_fn);

_str = ["   "] call CBA_fnc_rightTrim;
TEST_OP(_str,==,"",_fn);

_str = [" 	"] call CBA_fnc_rightTrim; // including tabs
TEST_OP(_str,==,"",_fn);

_str = [" x	"] call CBA_fnc_rightTrim;
TEST_OP(_str,==," x",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (trim)
_fn = "CBA_fnc_trim";

TEST_DEFINED("CBA_fnc_trim","");

_str = [""] call CBA_fnc_trim;
TEST_OP(_str,==,"",_fn);

_str = [" x "] call CBA_fnc_trim;
TEST_OP(_str,==,"x",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (capitalize)
_fn = "CBA_fnc_capitalize";

TEST_DEFINED("CBA_fnc_capitalize","");

_str = [""] call CBA_fnc_capitalize;
TEST_OP(_str,==,"",_fn);

_str = ["a"] call CBA_fnc_capitalize;
TEST_OP(_str,==,"A",_fn);

_str = ["frog"] call CBA_fnc_capitalize;
TEST_OP(_str,==,"Frog",_fn);

_str = ["Frog"] call CBA_fnc_capitalize;
TEST_OP(_str,==,"Frog",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (CBA_fnc_formatNumber)
_fn = "CBA_fnc_formatNumber";

TEST_DEFINED("CBA_fnc_formatNumber","");

_str = [0.0001, 1, 3] call CBA_fnc_formatNumber;
TEST_OP(_str,==,"0.000",_fn);

_str = [0.0005, 1, 3] call CBA_fnc_formatNumber;
TEST_OP(_str,==,"0.001",_fn);

_str = [12345, 1, 0, true] call CBA_fnc_formatNumber;
_expected = "12,345";
TEST_OP(_str,==,_expected,_fn);

_str = [12345.67, 1, 1, true] call CBA_fnc_formatNumber;
_expected = "12,345.7";
TEST_OP(_str,==,_expected,_fn);

_str = [0.1, 1] call CBA_fnc_formatNumber;
TEST_OP(_str,==,"0",_fn);

_str = [0.1, 3, 1] call CBA_fnc_formatNumber;
TEST_OP(_str,==,"000.1",_fn);

_str = [0.1, 0, 2] call CBA_fnc_formatNumber;
TEST_OP(_str,==,".10",_fn);

_str = [12, 0] call CBA_fnc_formatNumber;
TEST_OP(_str,==,"12",_fn);

_str = [12, 3] call CBA_fnc_formatNumber;
TEST_OP(_str,==,"012",_fn);

_str = [-12] call CBA_fnc_formatNumber;
TEST_OP(_str,==,"-12",_fn);

_str = [-12.75] call CBA_fnc_formatNumber;
TEST_OP(_str,==,"-13",_fn);

_str = [-12.75,0,3] call CBA_fnc_formatNumber;
TEST_OP(_str,==,"-12.750",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (elaspsedTime)
_fn = "CBA_fnc_formatElapsedTime";

TEST_DEFINED("CBA_fnc_formatElapsedTime","");

_str = [0, "H:MM:SS"] call CBA_fnc_formatElapsedTime;
_expected = "0:00:00";
TEST_OP(_str,==,_expected,_fn);

_str = [0, "M:SS"] call CBA_fnc_formatElapsedTime;
_expected = "0:00";
TEST_OP(_str,==,_expected,_fn);

_str = [0, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime;
_expected = "0:00:00.000";
TEST_OP(_str,==,_expected,_fn);

_str = [0, "M:SS.mmm"] call CBA_fnc_formatElapsedTime;
_expected = "0:00.000";
TEST_OP(_str,==,_expected,_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (compareStrings)
/* Function ISN'T implemented.
_fn = "CBA_fnc_compare";
TEST_DEFINED("CBA_fnc_compare","");

_result = ["", ""] call CBA_fnc_compare;
TEST_OP(_result, ==, 0, _fn);

_result = ["", "a"] call CBA_fnc_compare;
TEST_OP(_result, ==, -1, _fn);

_result = ["a", ""] call CBA_fnc_compare;
TEST_OP(_result, ==, +1, _fn);

_result = ["a", "a"] call CBA_fnc_compare;
TEST_OP(_result, ==, 0, _fn);

_result = ["a", "b"] call CBA_fnc_compare;
TEST_OP(_result, ==, -1, _fn);

_result = ["b", "a"] call CBA_fnc_compare;
TEST_OP(_result, ==, +1, _fn);

_result = ["aardvark", "aardwolf"] call CBA_fnc_compare;
TEST_OP(_result, ==, -1, _fn);

_result = ["aardwolf", "aardvark"] call CBA_fnc_compare;
TEST_OP(_result, ==, +1, _fn);
*/

nil;
