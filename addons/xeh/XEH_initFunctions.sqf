#define DEBUG_MODE_FULL
#include "script_component.hpp"

LOG("Compiling PREP'd functions.");

private _config = configFile >> "CfgSettings" >> "CBA" >> "caching" >> _compileType;
private _missionConfig = missionConfigFile >> "CfgSettings" >> "CBA" >> "caching" >> _compileType;

if ((isNumber _config && {getNumber _config == 0}) || {isNumber _missionConfig && {getNumber _missionConfig == 0}}) then {
    // Recompile enabled.
    {
        _x params ["_funcName", "_funcFile"];
        missionNamespace setVariable [_x, compile/*Final*/ preprocessFileLineNumbers _funcFile];
    } forEach call (uiNamespace getVariable [QGVAR(PREP_list), {[]}]);
} else {
    // Recompile disabled.
    {
        _x params ["_funcName"];
        missionNamespace setVariable [_x, uiNamespace getVariable _x];
    } forEach call (uiNamespace getVariable [QGVAR(PREP_list), {[]}]);
};

LOG("Done compiling PREP'd functions.");

#include "\A3\functions_f\initFunctions.sqf"
