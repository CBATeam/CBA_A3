// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_find);

// ----------------------------------------------------------------------------

private ["_original", "_expected", "_result", "_fn"];

_fn = "CBA_fnc_findNil";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_findNil","");

// Find First Nil Entry
_original = ["", player, "", player, nil, "", player, nil];
_result = ["", player, "", player, nil, "", player, nil] call CBA_fnc_findNil;
_expected = 4;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["", nil, "", player, nil, "", player, nil];
_result = ["", nil, "", player, nil, "", player, nil] call CBA_fnc_findNil;
_expected = 1;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["", player, "", nil, nil, "", player, nil];
_result = ["", player, "", nil, nil, "", player, nil] call CBA_fnc_findNil;
_expected = 3;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["", player, "", player, "", "", player, nil];
_result = ["", player, "", player, "", "", player, nil] call CBA_fnc_findNil;
_expected = 7;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["", player, "", player, "", "", player, ""];
_result = ["", player, "", player, "", "", player, ""] call CBA_fnc_findNil;
_expected = -1;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);




_fn = "CBA_fnc_findNull";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_findNull","");


// Find First Null Entry
_original = ["", player, "", player, objNull, "", player, displayNull];
_result = ["", player, "", player, objNull, "", player, displayNull] call CBA_fnc_findNull;
_expected = 4;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["", grpNull, "", player, objNull, "", player, displayNull];
_result = ["", grpNull, "", player, objNull, "", player, displayNull] call CBA_fnc_findNull;
_expected = 1;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["", player, "",  scriptNull, objNull, "", player, displayNull];
_result = ["", player, "",  scriptNull, objNull, "", player, displayNull] call CBA_fnc_findNull;
_expected = 3;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["", player, "", player, "", "", player, displayNull];
_result = ["", player, "", player, "", "", player, displayNull] call CBA_fnc_findNull;
_expected = 7;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["", player, "", player, "", "", player, ""];
_result = ["", player, "", player, "", "", player, ""] call CBA_fnc_findNil;
_expected = -1;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);






_fn = "CBA_fnc_findTypeName";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_findTypeName","");


// Find First Type of Entry
_original = ["OBJECT" ,["", player, "", player, objNull, "", player, displayNull]];
_result = ["OBJECT" ,["", player, "", player, objNull, "", player, displayNull]] call CBA_fnc_findTypeName;
_expected = 4;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["OBJECT" ,["", "", "", player, objNull, "", player, displayNull]];
_result = ["OBJECT" ,["", "", "", player, objNull, "", player, displayNull]] call CBA_fnc_findTypeName;
_expected = 3;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["CODE" ,["", player, {}, {}, objNull, "", player, displayNull]];
_result = ["CODE" ,["", player, {}, {}, objNull, "", player, displayNull]] call CBA_fnc_findTypeName;
_expected = 2;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["STRING" ,[objNull, player, {}, player, objNull, "", player, displayNull]];
_result = ["STRING" ,[objNull, player, {}, player, objNull, "", player, displayNull]] call CBA_fnc_findTypeName;
_expected = 5;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["OBJECT" ,["", "", "", "", "", "", "", displayNull]];
_result = ["OBJECT" ,["", "", "", "", "", "", "", displayNull]] call CBA_fnc_findTypeName;
_expected = -1;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);




_fn = "CBA_fnc_findTypOf";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_findTypOf","");


// Find First Type of Entry
_original = [typeOf player ,["", player, "", player, objNull, "", player, displayNull]];
_result = [typeOf player ,["", player, "", player, objNull, "", player, displayNull]] call CBA_fnc_findTypOf;
_expected = 4;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = [player ,["", "", "", player, objNull, "", player, displayNull]];
_result = [player ,["", "", "", player, objNull, "", player, displayNull]] call CBA_fnc_findTypOf;
_expected = 3;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = [player ,["", player, {}, {}, objNull, "", player, displayNull]];
_result = [player ,["", player, {}, {}, objNull, "", player, displayNull]] call CBA_fnc_findTypOf;
_expected = 2;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = [player ,[objNull, player, {}, player, objNull, "", player, displayNull]];
_result = [player ,[objNull, player, {}, player, objNull, "", player, displayNull]] call CBA_fnc_findTypOf;
_expected = 5;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);


_original = ["OBJECT" ,["", "", "", "", "", "", "", displayNull]];
_result = ["OBJECT" ,["", "", "", "", "", "", "", displayNull]] call CBA_fnc_findTypOf;
_expected = -1;
TEST_OP(str _original,==,str _expected,_fn);
TEST_OP(str _result,==,str _expected,_fn);

nil;
