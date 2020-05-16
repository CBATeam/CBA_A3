//#define DEBUG_MODE_FULL
#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_compileFunction

Description:
    Compiles a function into mission namespace and into ui namespace for caching purposes.
    Recompiling can be enabled by inserting the CBA_cache_disable.pbo from the optionals folder.

Parameters:
    0: _funcFile - Path to function sqf file <STRING>
    1: _funcName - Final function name <STRING>

Returns:
    None

Examples:
    (begin example)
        [_funcFile, _funcName] call CBA_fnc_compileFunction;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_funcFile", "", [""]], ["_funcName", "", [""]]];

private _cachedFunc = uiNamespace getVariable _funcName;

if (isNil "_cachedFunc") then {
    LOG_1("COMPILE - %1", _funcName);

    uiNamespace setVariable [_funcName, compileFinal preprocessFileLineNumbers _funcFile];
    missionNamespace setVariable [_funcName, uiNamespace getVariable _funcName];

    if (GVAR(PREP_list) isEqualType []) then {
        GVAR(PREP_list) pushBack _funcName;
    };
} else {
    if (["compile"] call CBA_fnc_isRecompileEnabled) then {
        LOG_1("RECOMPILE - %1", _funcName);
        missionNamespace setVariable [_funcName, compileFinal preprocessFileLineNumbers _funcFile];
    } else {
        LOG_1("COPY CACHE - %1", _funcName);
        missionNamespace setVariable [_funcName, _cachedFunc];
    };
};
