//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!ISINITIALIZED(missionNamespace)) then {
    SETINITIALIZED(missionNamespace);

    LOG("Compiling PREP'd functions.");

    private _config = configFile >> "CfgSettings" >> "CBA" >> "caching" >> "compile";
    private _missionConfig = missionConfigFile >> "CfgSettings" >> "CBA" >> "caching" >> "compile";

    if ((isNumber _config && {getNumber _config == 0}) || {isNumber _missionConfig && {getNumber _missionConfig == 0}}) then {
        // Recompile enabled.
        {
            _x params ["_funcName", "_funcFile"];
            LOG_1("RECOMPILE - %1", _funcName);
            missionNamespace setVariable [_funcName, compile/*Final*/ preprocessFileLineNumbers _funcFile];
        } forEach call (uiNamespace getVariable [QGVAR(PREP_list), {[]}]);
    } else {
        // Recompile disabled.
        {
            _x params ["_funcName"];
            LOG_1("COPY CACHE - %1", _funcName);
            missionNamespace setVariable [_funcName, uiNamespace getVariable _funcName];
        } forEach call (uiNamespace getVariable [QGVAR(PREP_list), {[]}]);
    };

    LOG("Done compiling PREP'd functions.");
};

#include "\A3\functions_f\initFunctions.sqf"
