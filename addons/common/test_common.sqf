#include "script_component.hpp"
SCRIPT(test_common);

// execVM "\x\cba\addons\common\test_common.sqf";

private ["_funcName", "_result"];

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_getWeekDay";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_getWeekDay","");

_result = [] call CBA_fnc_getWeekDay;
TEST_TRUE(_result == -1,_funcName); // invalid

_result = [[0, 0, 0]] call CBA_fnc_getWeekDay;
TEST_TRUE(_result == -1,_funcName); // invalid

_result = [[2022, 1, 1]] call CBA_fnc_getWeekDay;
TEST_TRUE(_result == 6,_funcName); // Saturday

_result = [[2022, 2, 16]] call CBA_fnc_getWeekDay;
TEST_TRUE(_result == 3,_funcName); // Wednesday

// date format [year, month, day, hour, minute]
_result = [[2022, 2, 17, 11, 56]] call CBA_fnc_getWeekDay;
TEST_TRUE(_result == 4,_funcName); // Thursday

// systemTime format [year, month, day, hour, minute, second, millisecond]
_result = [[2022, 2, 18, 11, 56, 24, 126]] call CBA_fnc_getWeekDay;
TEST_TRUE(_result == 5,_funcName); // Friday
