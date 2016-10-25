#include "script_component.hpp"
SCRIPT(test_config);

// 0 spawn compile preprocessFileLineNumbers "\x\cba\addons\common\test_config.sqf";

private ["_funcName", "_result"];

_funcName = "CBA_fnc_inheritsFrom";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_inheritsFrom","");

private ["_class", "_base"];

_class = configFile >> "CfgWeapons" >> "arifle_MXC_F";
_base = configFile >> "CfgWeapons" >> "RifleCore";
_result = [_class, _base] call CBA_fnc_inheritsFrom;
TEST_TRUE(_result,_funcName);

_class = configFile >> "CfgWeapons" >> "RifleCore";
_base = configFile >> "CfgWeapons" >> "arifle_MXC_F";
_result = [_class, _base] call CBA_fnc_inheritsFrom;
TEST_FALSE(_result,_funcName);

_class = configFile >> "CfgWeapons" >> "arifle_MXC_F";
_base = configFile >> "CfgWeapons" >> "PistolCore";
_result = [_class, _base] call CBA_fnc_inheritsFrom;
TEST_FALSE(_result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_getMuzzles";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_getMuzzles","");

_result = "" call CBA_fnc_getMuzzles;
TEST_TRUE(_result isEqualTo [],_funcName);

_result = "arifle_MX_F" call CBA_fnc_getMuzzles;
TEST_TRUE(_result isEqualTo ["arifle_MX_F"],_funcName);

_result = "arifle_MX_GL_F" call CBA_fnc_getMuzzles;
TEST_TRUE(_result isEqualTo [ARR_2("arifle_MX_GL_F","GL_3GL_F")],_funcName);

_result = "FirstAidKit" call CBA_fnc_getMuzzles;
TEST_TRUE(_result isEqualTo [],_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_getWeaponModes";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_getWeaponModes","");

_result = "" call CBA_fnc_getWeaponModes;
TEST_TRUE(_result isEqualTo [],_funcName);

_result = "arifle_MX_F" call CBA_fnc_getWeaponModes;
TEST_TRUE(_result isEqualTo [ARR_2("Single","FullAuto")],_funcName);

_result = ["arifle_MX_GL_F"] call CBA_fnc_getWeaponModes;
TEST_TRUE(_result isEqualTo [ARR_2("Single","FullAuto")],_funcName);

_result = ["arifle_MX_F", true] call CBA_fnc_getWeaponModes;
TEST_TRUE(_result isEqualTo [ARR_5("Single","FullAuto","fullauto_medium","single_medium_optics1","single_far_optics2")],_funcName);

_result = ["FirstAidKit", true] call CBA_fnc_getWeaponModes;
TEST_TRUE(_result isEqualTo ["FirstAidKit"],_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_getItemConfig";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_getItemConfig","");

_result = "" call CBA_fnc_getItemConfig;
TEST_TRUE(isNull _result,_funcName);

_result = "arifle_MX_F" call CBA_fnc_getItemConfig;
TEST_TRUE(_result isEqualTo (configFile >> "CfgWeapons" >> "arifle_MX_F"),_funcName);

_result = ["arifle_MX_GL_F"] call CBA_fnc_getItemConfig;
TEST_TRUE(_result isEqualTo (configFile >> "CfgWeapons" >> "arifle_MX_GL_F"),_funcName);

_result = "FirstAidKit" call CBA_fnc_getItemConfig;
TEST_TRUE(_result isEqualTo (configFile >> "CfgWeapons" >> "FirstAidKit"),_funcName);

_result = "30Rnd_65x39_caseless_mag" call CBA_fnc_getItemConfig;
TEST_TRUE(_result isEqualTo (configFile >> "CfgMagazines" >> "30Rnd_65x39_caseless_mag"),_funcName);

_result = "G_Shades_Black" call CBA_fnc_getItemConfig;
TEST_TRUE(_result isEqualTo (configFile >> "CfgGlasses" >> "G_Shades_Black"),_funcName);

_result = "B_Soldier_F" call CBA_fnc_getItemConfig;
TEST_TRUE(isNull _result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_getObjectConfig";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_getObjectConfig","");

_result = "" call CBA_fnc_getObjectConfig;
TEST_TRUE(isNull _result,_funcName);

_result = [objNull] call CBA_fnc_getObjectConfig;
TEST_TRUE(isNull _result,_funcName);

_result = "B_Soldier_F" call CBA_fnc_getObjectConfig;
TEST_TRUE(_result isEqualTo (configFile >> "CfgVehicles" >> "B_Soldier_F"),_funcName);

_result = (typeOf player) call CBA_fnc_getObjectConfig;
TEST_TRUE(isNull player || !isNull _result,_funcName);

_result = "EmptyDetector" call CBA_fnc_getObjectConfig;
TEST_TRUE(_result isEqualTo (configFile >> "CfgNonAIVehicles" >> "EmptyDetector"),_funcName);

_result = ["B_65x39_Caseless"] call CBA_fnc_getObjectConfig;
TEST_TRUE(_result isEqualTo (configFile >> "CfgAmmo" >> "B_65x39_Caseless"),_funcName);

_result = "FirstAidKit" call CBA_fnc_getObjectConfig;
TEST_TRUE(isNull _result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_getTurret";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_getTurret","");

_result = "" call CBA_fnc_getTurret;
TEST_TRUE(isNull _result,_funcName);

_result = [objNull] call CBA_fnc_getTurret;
TEST_TRUE(isNull _result,_funcName);

_result = "B_MBT_01_TUSK_F" call CBA_fnc_getTurret;
TEST_TRUE(_result isEqualTo (configFile >> "CfgVehicles" >> "B_MBT_01_TUSK_F"),_funcName);

_result = ["B_MBT_01_TUSK_F", [-1]] call CBA_fnc_getTurret;
TEST_TRUE(_result isEqualTo (configFile >> "CfgVehicles" >> "B_MBT_01_TUSK_F"),_funcName);

_result = ["B_MBT_01_TUSK_F", []] call CBA_fnc_getTurret;
TEST_TRUE(_result isEqualTo (configFile >> "CfgVehicles" >> "B_MBT_01_TUSK_F"),_funcName);

_result = ["B_MBT_01_TUSK_F", [0]] call CBA_fnc_getTurret;
TEST_TRUE(_result isEqualTo (configFile >> "CfgVehicles" >> "B_MBT_01_TUSK_F" >> "Turrets" >> "MainTurret"),_funcName);

_result = ["B_MBT_01_TUSK_F", [0,0]] call CBA_fnc_getTurret;
TEST_TRUE(_result isEqualTo (configFile >> "CfgVehicles" >> "B_MBT_01_TUSK_F" >> "Turrets" >> "MainTurret" >> "Turrets" >> "CommanderOptics"),_funcName);

_result = ["B_MBT_01_TUSK_F", [0,0,0]] call CBA_fnc_getTurret;
TEST_TRUE(isNull _result,_funcName);

_result = ["B_MBT_01_TUSK_F", [0,1]] call CBA_fnc_getTurret;
TEST_TRUE(isNull _result,_funcName);

/*_result = {isNull _x} count ([[0],[1],[2],[3],[4]] apply {["B_Heli_Transport_03_F", _x] call CBA_fnc_getTurret});
TEST_TRUE(_result == 0,_funcName);

_result = {!isNull _x} count ([[0],[1],[2],[3],[4]] apply {["B_Heli_Transport_03_F", _x] call CBA_fnc_getTurret});
TEST_TRUE(_result == 5,_funcName);*/
