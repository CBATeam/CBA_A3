#include "script_component.hpp"
SCRIPT(test_position);

// execVM "\x\cba\addons\common\test_position.sqf";

private ["_funcName", "_value", "_result"];

_funcName = "CBA_fnc_getPos";
LOG("Testing " + _funcName);

TEST_DEFINED(_funcName,"");

_value = objNull;
_result = _value call CBA_fnc_getPos;

#define EXPECTED [0,0,0]
TEST_TRUE(_result isEqualTo EXPECTED,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_value = grpNull;
_result = _value call CBA_fnc_getPos;

TEST_TRUE(_result isEqualTo EXPECTED,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_value = ""; // marker
_result = _value call CBA_fnc_getPos;

TEST_TRUE(_result isEqualTo EXPECTED,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_value = locationNull;
_result = _value call CBA_fnc_getPos;

TEST_TRUE(_result isEqualTo EXPECTED,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

#define EXPECTED [1,2,0] // Pos 3D

_value = EXPECTED;
_result = _value call CBA_fnc_getPos;

// confirm that input array is copied
_value set [0,-1];

TEST_TRUE(_result isEqualTo EXPECTED,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

#define EXPECTED [1,2] // Pos 2D

_value = EXPECTED;
_result = _value call CBA_fnc_getPos;

// confirm that input array is copied
_value set [0,-1];

TEST_TRUE(_result isEqualTo EXPECTED,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////
