#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_isRecompileEnabled

Description:
    Check if recompiling is enabled.

Parameters:
    0: _compileType - The compile type (`compile` or `functions`) <STRING>

Returns:
    true - recompiling is enabled, false - recompiling is disabled <BOOLEAN>

Examples:
    (begin example)
        _enabled = ["compile"] call CBA_fnc_isRecompileEnabled;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_compileType"];

private _return = missionNamespace getVariable (format [QGVAR(isRecompileEnabled_%1), _compileType]);

if (isNil "_return") then {
    private _config = configFile >> "CfgSettings" >> "CBA" >> "caching" >> _compileType;
    private _missionConfig = missionConfigFile >> "CfgSettings" >> "CBA" >> "caching" >> _compileType;

    _return = (isNumber _config && {getNumber _config == 0}) || {isNumber _missionConfig && {getNumber _missionConfig == 0}};
    missionNamespace setVariable [(format [QGVAR(isRecompileEnabled_%1), _compileType]), _return];

    // Normally, full caching is enabled. If not, log an informative message.
    if (_return) then {
        XEH_LOG(PFORMAT_1("CBA CACHE DISABLED? (Disable caching with cba_cache_disable.pbo)",_compileType));
    };
};

_return
