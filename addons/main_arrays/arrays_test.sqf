// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(arrays_test);

// ----------------------------------------------------------------------------

private ["_pos", "_str", "_array", "_expected", "_result", "_fn"];

LOG('----- STARTED PREFIX\COMPONENT\arrays TESTS -----');

// ----------------------------------------------------------------------------
// UNIT TESTS (filter)
_fn = "CBA_fnc_filter";
ASSERT_DEFINED(_fn,"");

_result = [[], { (_this select 0) + 1 }] call CBA_fnc_filter;
_expected = [];
ASSERT_OP(str _result,==,str _expected,_fn);

_result = [[1, 2, 3], { (_this select 0) + 1 }] call CBA_fnc_filter;
_expected = [2, 3, 4];
ASSERT_OP(str _result,==,str _expected,_fn);

_result = [[1, 2, 3], { _this select 0 }] call CBA_fnc_filter;
_expected = [1, 2, 3];
ASSERT_OP(str _result,==,str _expected,_fn);

// ----------------------------------------------------------------------------
// UNIT TESTS (inject)
_fn = "CBA_fnc_inject";
ASSERT_DEFINED(_fn,"");
  
_result = [[], "", { (_this select 0) + str (_this select 1) }] call CBA_fnc_inject;
_expected = "";
ASSERT_OP(_result,==,_expected,_fn);

_result = [[1, 2, 3], "", { (_this select 0) + str (_this select 1) }] call CBA_fnc_inject;
_expected = "123";
ASSERT_OP(_result,==,_expected,_fn);

_result = [[1, 2, 3], " frogs", { (str (_this select 1)) + (_this select 0) }] call CBA_fnc_inject;
_expected = "321 frogs";
ASSERT_OP(_result,==,_expected,_fn);

_result = [[1, 2, 3], 0, { (_this select 0) + (_this select 1) }] call CBA_fnc_inject;
_expected = 6;
ASSERT_OP(_result,==,_expected,_fn);

// -----------------------------------------------------------------------------
LOG('----- COMPLETED PREFIX\COMPONENT\arrays TESTS -----');