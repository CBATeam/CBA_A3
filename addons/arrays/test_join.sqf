// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_join);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn"];

_fn = "CBA_fnc_join";
ASSERT_DEFINED(_fn,"");

LOG("Testing " + _fn);

_str = [[], "x"] call CBA_fnc_join;
ASSERT_OP(_str,==,"",_fn);

_str = [[""], "x"] call CBA_fnc_join;
ASSERT_OP(_str,==,"",_fn);

_str = [["frog"], "x"] call CBA_fnc_join;
ASSERT_OP(_str,==,"frog",_fn);

_str = [["", ""], "x"] call CBA_fnc_join;
ASSERT_OP(_str,==,"x",_fn);

_str = [["a","b","c"], "x"] call CBA_fnc_join;
ASSERT_OP(_str,==,"axbxc",_fn);

nil;