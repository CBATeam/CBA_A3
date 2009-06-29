// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(strings_test);

// ----------------------------------------------------------------------------

private ["_pos", "_str", "_array", "_expected", "_result", "_fn"];

LOG('----- STARTED PREFIX\COMPONENT\strings TESTS -----');

// UNIT TESTS (stringFind)
_fn = "CBA_fnc_find";
ASSERT_DEFINED(_fn,"");

_pos = ["frog", "f"] call CBA_fnc_find;
ASSERT_OP(_pos,==,0,_fn);

_pos = ["frog", "g"] call CBA_fnc_find;
ASSERT_OP(_pos,==,3,_fn);

_pos = ["frog", "z"] call CBA_fnc_find;
ASSERT_OP(_pos,==,-1,_fn);

_pos = ["bullfrog", "frog"] call CBA_fnc_find;
ASSERT_OP(_pos,==,4,_fn);

_pos = ["bullfrog", "frogs"] call CBA_fnc_find;
ASSERT_OP(_pos,==,-1,_fn);

_pos = ["frofrog", "frog"] call CBA_fnc_find;
ASSERT_OP(_pos,==,3,_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (stringSplit)
_fn = "CBA_fnc_split";
ASSERT_DEFINED(_fn,"");

_array = ["", "\"] call CBA_fnc_split;
_expected = [];
ASSERT_OP(str _array, ==, str _expected, _fn);

_array = ["\", "\"] call CBA_fnc_split;
_expected = ["", ""];
ASSERT_OP(str _array, ==, str _expected, _fn);

_array = ["\frog", "\"] call CBA_fnc_split;
_expected = ["", "frog"];
ASSERT_OP(str _array, ==, str _expected, _fn);

_array = ["\frog\", "\"] call CBA_fnc_split;
_expected = ["", "frog", ""];
ASSERT_OP(str _array, ==, str _expected, _fn);

_array = ["cheese\frog\fish", "\"] call CBA_fnc_split;
_expected = ["cheese", "frog", "fish"];
ASSERT_OP(str _array, ==, str _expected, _fn);

_array = ["peas", ""] call CBA_fnc_split;
_expected = ["p", "e", "a", "s"];
ASSERT_OP(str _array, ==, str _expected, _fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (stringReplace)
_fn = "CBA_fnc_replace";

ASSERT_DEFINED(_fn,"");

_str = ["", "", ""] call CBA_fnc_replace;
ASSERT_OP(_str,==,"",_fn);

_str = ["", "frog", "fish"] call CBA_fnc_replace;
ASSERT_OP(_str,==,"",_fn);

_str = ["frog", "fish", "cheese"] call CBA_fnc_replace;
ASSERT_OP(_str,==,"frog",_fn);

_str = ["frog", "o", "a"] call CBA_fnc_replace;
ASSERT_OP(_str,==,"frag",_fn);

_str = ["frodo", "o", "ai"] call CBA_fnc_replace;
ASSERT_OP(_str,==,"fraidai",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (leftTrim)
_fn = "CBA_fnc_leftTrim";

ASSERT_DEFINED(_fn,"");

_str = [""] call CBA_fnc_leftTrim;
ASSERT_OP(_str,==,"",_fn);

_str = ["frog"] call CBA_fnc_leftTrim;
ASSERT_OP(_str,==,"frog",_fn);

_str = [" frog"] call CBA_fnc_leftTrim;
ASSERT_OP(_str,==,"frog",_fn);

_str = ["   frog"] call CBA_fnc_leftTrim; // spaces
ASSERT_OP(_str,==,"frog",_fn);
	
_str = ["	frog"] call CBA_fnc_leftTrim; // tab
ASSERT_OP(_str,==,"frog",_fn);

_str = ["   "] call CBA_fnc_leftTrim;
ASSERT_OP(_str,==,"",_fn);

_str = [" x "] call CBA_fnc_leftTrim;
ASSERT_OP(_str,==,"x ",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (rightTrim)
_fn = "CBA_fnc_rightTrim";

ASSERT_DEFINED(_fn,"");

_str = [""] call CBA_fnc_rightTrim;
ASSERT_OP(_str,==,"",_fn);

_str = ["frog"] call CBA_fnc_rightTrim;
ASSERT_OP(_str,==,"frog",_fn);

_str = ["frog "] call CBA_fnc_rightTrim;
ASSERT_OP(_str,==,"frog",_fn);

_str = ["frog   "] call CBA_fnc_rightTrim;
ASSERT_OP(_str,==,"frog",_fn);
	
_str = ["frog 	"] call CBA_fnc_rightTrim; // including tabs
ASSERT_OP(_str,==,"frog",_fn);

_str = ["   "] call CBA_fnc_rightTrim;
ASSERT_OP(_str,==,"",_fn);

_str = [" 	"] call CBA_fnc_rightTrim; // including tabs
ASSERT_OP(_str,==,"",_fn);

_str = [" x	"] call CBA_fnc_rightTrim;
ASSERT_OP(_str,==," x",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (trim)
_fn = "CBA_fnc_trim";

ASSERT_DEFINED(_fn,"");

_str = [""] call CBA_fnc_trim;
ASSERT_OP(_str,==,"",_fn);

_str = [" x "] call CBA_fnc_trim;
ASSERT_OP(_str,==,"x",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (capitalize)
_fn = "CBA_fnc_capitalize";

ASSERT_DEFINED(_fn,"");

_str = [""] call CBA_fnc_capitalize;
ASSERT_OP(_str,==,"",_fn);

_str = ["a"] call CBA_fnc_capitalize;
ASSERT_OP(_str,==,"A",_fn);

_str = ["frog"] call CBA_fnc_capitalize;
ASSERT_OP(_str,==,"Frog",_fn);

_str = ["Frog"] call CBA_fnc_capitalize;
ASSERT_OP(_str,==,"Frog",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (CBA_fnc_formatNumber)
_fn = "CBA_fnc_formatNumber";

ASSERT_DEFINED(_fn,"");

_str = [0.0001, 1, 3] call CBA_fnc_formatNumber;
ASSERT_OP(_str,==,"0.000",_fn);

_str = [0.0005, 1, 3] call CBA_fnc_formatNumber;
ASSERT_OP(_str,==,"0.001",_fn);

_str = [12345, 1, 0, true] call CBA_fnc_formatNumber;
_expected = "12,345";
ASSERT_OP(_str,==,_expected,_fn);

_str = [12345.67, 1, 1, true] call CBA_fnc_formatNumber;
_expected = "12,345.7";
ASSERT_OP(_str,==,_expected,_fn);
	
_str = [0.1, 1] call CBA_fnc_formatNumber;
ASSERT_OP(_str,==,"0",_fn);

_str = [0.1, 3, 1] call CBA_fnc_formatNumber;
ASSERT_OP(_str,==,"000.1",_fn);

_str = [0.1, 0, 2] call CBA_fnc_formatNumber;
ASSERT_OP(_str,==,".10",_fn);

_str = [12, 0] call CBA_fnc_formatNumber;
ASSERT_OP(_str,==,"12",_fn);

_str = [12, 3] call CBA_fnc_formatNumber; 
ASSERT_OP(_str,==,"012",_fn);

_str = [-12] call CBA_fnc_formatNumber;
ASSERT_OP(_str,==,"-12",_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (elaspsedTime)
_fn = "CBA_fnc_formatElapsedTime";

ASSERT_DEFINED(_fn,"");

_str = [0, "H:MM:SS"] call CBA_fnc_formatElapsedTime;
_expected = "0:00:00";
ASSERT_OP(_str,==,_expected,_fn);

_str = [0, "M:SS"] call CBA_fnc_formatElapsedTime;
_expected = "0:00";
ASSERT_OP(_str,==,_expected,_fn);

_str = [0, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime;
_expected = "0:00:00.000";
ASSERT_OP(_str,==,_expected,_fn);

_str = [0, "M:SS.mmm"] call CBA_fnc_formatElapsedTime;
_expected = "0:00.000";
ASSERT_OP(_str,==,_expected,_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (compareStrings)
/* Function ISN'T implemented.
_fn = "CBA_fnc_compare";
ASSERT_DEFINED(_fn,"");

_result = ["", ""] call CBA_fnc_compare;
ASSERT_OP(_result, ==, 0, _fn);

_result = ["", "a"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, -1, _fn);

_result = ["a", ""] call CBA_fnc_compare;
ASSERT_OP(_result, ==, +1, _fn);

_result = ["a", "a"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, 0, _fn);

_result = ["a", "b"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, -1, _fn);

_result = ["b", "a"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, +1, _fn);

_result = ["aardvark", "aardwolf"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, -1, _fn);

_result = ["aardwolf", "aardvark"] call CBA_fnc_compare;
ASSERT_OP(_result, ==, +1, _fn);
*/

// -----------------------------------------------------------------------------
LOG('----- COMPLETED PREFIX\COMPONENT\strings TESTS -----');