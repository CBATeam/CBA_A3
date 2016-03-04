#include "script_component.hpp"
SCRIPT(test_config);

// 0 spawn compile preprocessFileLineNumbers "\x\cba\addons\common\test_inventory.sqf";

// Note: test requires a player with space in inventory

private ["_funcName", "_result"];

_funcName = "CBA_fnc_addWeapon";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_addWeapon","");

_result = [objNull, "Binocular"] call CBA_fnc_addWeapon;
TEST_FALSE(_result,_funcName);

_result = [player, ""] call CBA_fnc_addWeapon;
TEST_FALSE(_result,_funcName);

_result = [player, "Binocular"] call CBA_fnc_addWeapon;
TEST_TRUE(_result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_removeWeapon";
LOG("Testing " + _funcName);

_result = [objNull, "Binocular"] call CBA_fnc_removeWeapon;
TEST_FALSE(_result,_funcName);

_result = [player, ""] call CBA_fnc_removeWeapon;
TEST_FALSE(_result,_funcName);

_result = [player, "Binocular"] call CBA_fnc_removeWeapon;
TEST_TRUE(_result,_funcName);

_result = [player, "Binocular"] call CBA_fnc_removeWeapon;
TEST_FALSE(_result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_addMagazine";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_addMagazine","");

_result = [objNull, "SmokeShell"] call CBA_fnc_addMagazine;
TEST_FALSE(_result,_funcName);

_result = [player, ""] call CBA_fnc_addMagazine;
TEST_FALSE(_result,_funcName);

_result = [player, "SmokeShell"] call CBA_fnc_addMagazine;
TEST_TRUE(_result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_removeMagazine";
LOG("Testing " + _funcName);

_result = [objNull, "SmokeShell"] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);

_result = [player, ""] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);

_result = [player, "SmokeShell"] call CBA_fnc_removeMagazine;
TEST_TRUE(_result,_funcName);

player removeMagazines "SmokeShell";

_result = [player, "SmokeShell"] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);
