/* ----------------------------------------------------------------------------
Function: CBA_fnc_isRecompileEnabled

Description:
    Check if recompiling is enabled.

Parameters:
    None

Returns:
    true - recompiling is enabled, false - recompiling is disabled <BOOLEAN>

Examples:
    (begin example)
        _enabled = call CBA_fnc_isRecompileEnabled;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

if (isNil QGVAR(isRecompileEnabled)) then {
    private _config = configFile >> "CfgSettings" >> "CBA" >> "caching" >> "compile";
    private _missionConfig = missionConfigFile >> "CfgSettings" >> "CBA" >> "caching" >> "compile";

    GVAR(isRecompileEnabled) = (isNumber _config && {getNumber _config == 0}) || {isNumber _missionConfig && {getNumber _missionConfig == 0}};

    #ifdef DEBUG_MODE_FULL
        diag_log text format ["isRecompileEnabled = %1", GVAR(isRecompileEnabled)];
    #endif
};

GVAR(isRecompileEnabled)
