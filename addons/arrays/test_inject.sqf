// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_inject);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn"];

_fn = "CBA_fnc_inject";
ASSERT_DEFINED(_fn,"");

LOG("Testing " + _fn);
  
_result = [[], "", { _accumulator + (str _x) }] call CBA_fnc_inject;
_expected = "";
ASSERT_OP(_result,==,_expected,_fn);

_result = [[1, 2, 3], "", { _accumulator + (str _x) }] call CBA_fnc_inject;
_expected = "123";
ASSERT_OP(_result,==,_expected,_fn);

_result = [[1, 2, 3], " frogs", { (str _x) + _accumulator }] call CBA_fnc_inject;
_expected = "321 frogs";
ASSERT_OP(_result,==,_expected,_fn);

_result = [[1, 2, 3], 0, { _accumulator + _x }] call CBA_fnc_inject;
_expected = 6;
ASSERT_OP(_result,==,_expected,_fn);

nil;
