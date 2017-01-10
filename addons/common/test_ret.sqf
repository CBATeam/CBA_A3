#include "script_component.hpp"
SCRIPT(test_config);

// 0 spawn compile preprocessFileLineNumbers "\x\cba\addons\common\test_config.sqf";

private ["_funcName", "_result"];

_funcName = "RETDEF";
LOG("Testing " + _funcName);

private _value = 1;
private "_undefined";

_result = RETDEF(_value,0);
TEST_TRUE(_result isEqualTo 1,_funcName);

_result = RETDEF(_undefined,0);
TEST_TRUE(_result isEqualTo 0,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "RETNIL";
LOG("Testing " + _funcName);

_result = RETNIL(_value);
TEST_TRUE(_result isEqualTo 1,_funcName);

_result = RETNIL(_undefined);
TEST_TRUE(isNil "_result",_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////
