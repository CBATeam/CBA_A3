// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_findTypeName);

// ----------------------------------------------------------------------------

disableSerialization;
private ["_array", "_expected", "_result", "_fn"];

_fn = "CBA_fnc_findTypeName";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_findTypeName","");

// Basic value typename check tests
_array = [[], true, {}, configFile >> "CfgWeapons", controlNull, displayNull, grpNull, locationNull, objNull, 5, scriptNull, side player, "test", taskNull, text "test", missionNamespace];

_result = [_array, "ARRAY"] call CBA_fnc_findTypeName;
_expected = 0;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "BOOL"] call CBA_fnc_findTypeName;
_expected = 1;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "CODE"] call CBA_fnc_findTypeName;
_expected = 2;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "CONFIG"] call CBA_fnc_findTypeName;
_expected = 3;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "CONTROL"] call CBA_fnc_findTypeName;
_expected = 4;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "DISPLAY"] call CBA_fnc_findTypeName;
_expected = 5;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "GROUP"] call CBA_fnc_findTypeName;
_expected = 6;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "LOCATION"] call CBA_fnc_findTypeName;
_expected = 7;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "OBJECT"] call CBA_fnc_findTypeName;
_expected = 8;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "SCALAR"] call CBA_fnc_findTypeName;
_expected = 9;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "SCRIPT"] call CBA_fnc_findTypeName;
_expected = 10;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "SIDE"] call CBA_fnc_findTypeName;
_expected = 11;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "STRING"] call CBA_fnc_findTypeName;
_expected = 12;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "TASK"] call CBA_fnc_findTypeName;
_expected = 13;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "TEXT"] call CBA_fnc_findTypeName;
_expected = 14;
TEST_OP(_result,==,_expected,_fn);

_result = [_array, "NAMESPACE"] call CBA_fnc_findTypeName;
_expected = 15;
TEST_OP(_result,==,_expected,_fn);

// Allow any capitalization
_result = [_array, "sCalAr"] call CBA_fnc_findTypeName;
_expected = 9;
TEST_OP(_result,==,_expected,_fn);

// Allow value pass in for typename
_result = [_array, scriptNull] call CBA_fnc_findTypeName;
_expected = 10;
TEST_OP(_result,==,_expected,_fn);

// Only find first instance of given typename
_result = [["", 4, 5], "SCALAR"] call CBA_fnc_findTypeName;
_expected = 1;
TEST_OP(_result,==,_expected,_fn);

// Return not found if typename has no value in array
_result = [["", 5, objNull], "NAMESPACE"] call CBA_fnc_findTypeName;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return not found if empty array is given
_result = [[], "STRING"] call CBA_fnc_findTypeName;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return not found if non array is given
_result = ["not an array", "STRING"] call CBA_fnc_findTypeName;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

// Return not found if parameters are nil
_result = [nil, nil] call CBA_fnc_findTypeName;
_expected = -1;
TEST_OP(_result,==,_expected,_fn);

nil;
