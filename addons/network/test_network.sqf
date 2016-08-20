#include "script_component.hpp"
SCRIPT(test_network);

// 0 spawn compile preprocessFileLineNumbers "\x\cba\addons\network\test_network.sqf";
// test has to be done with an existing "player" object (not 3den!!)

private ["_funcName", "_result"];

_funcName = "CBA_fnc_publicVariable";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_publicVariable","");

X1 = nil;
X2 = nil;

_result = ["X1", nil] call CBA_fnc_publicVariable;
TEST_FALSE(_result,_funcName);

_result = ["X1", 1] call CBA_fnc_publicVariable;
TEST_TRUE(_result,_funcName);

_result = ["X1", 2] call CBA_fnc_publicVariable;
TEST_TRUE(_result,_funcName);

_result = ["X1", 2] call CBA_fnc_publicVariable;
TEST_FALSE(_result,_funcName);

_result = ["X2", 2] call CBA_fnc_publicVariable;
TEST_TRUE(_result,_funcName);

_result = ["X1", nil] call CBA_fnc_publicVariable;
TEST_TRUE(_result,_funcName);

_result = ["X1", nil] call CBA_fnc_publicVariable;
TEST_FALSE(_result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_setVarNet";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_setVarNet","");

player setVariable ["X1", nil];
player setVariable ["X2", nil];
cba_logic setVariable ["X1", nil];
cba_logic setVariable ["X2", nil];

_result = [objNull, "X1", 1] call CBA_fnc_setVarNet;
TEST_FALSE(_result,_funcName);

_result = [player, "X1", nil] call CBA_fnc_setVarNet;
TEST_FALSE(_result,_funcName);

_result = [player, "X1", 1] call CBA_fnc_setVarNet;
TEST_TRUE(_result,_funcName);

_result = [player, "X1", 2] call CBA_fnc_setVarNet;
TEST_TRUE(_result,_funcName);

_result = [player, "X1", 2] call CBA_fnc_setVarNet;
TEST_FALSE(_result,_funcName);

_result = [cba_logic, "X1", 2] call CBA_fnc_setVarNet;
TEST_TRUE(_result,_funcName);

_result = [player, "X2", 2] call CBA_fnc_setVarNet;
TEST_TRUE(_result,_funcName);

_result = [player, "X1", nil] call CBA_fnc_setVarNet;
TEST_TRUE(_result,_funcName);

_result = [player, "X1", nil] call CBA_fnc_setVarNet;
TEST_FALSE(_result,_funcName);
