#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_compileFunction

Description:
    Compiles a function into mission namespace and into ui namespace for caching purposes.
    Recompiling can be enabled by inserting the CBA_cache_disable.pbo from the optionals folder.

Parameters:
    0: _funcFile        - Path to function sqf file <STRING>
    1: _funcName        - Final function name <STRING>
    2: _enableCaching   - Enable function caching (default: true) <BOOL>
    2: _enableCallstack - Enable callstack logging (default: false) <BOOL>

Returns:
    None

Examples:
    (begin example)
        [_funcFile, _funcName] call CBA_fnc_compileFunction;
    (end)

Author:
    commy2, BaerMitUmlaut
---------------------------------------------------------------------------- */

params [
    ["_funcFile", "", [""]],
    ["_funcName", "", [""]],
    ["_enableCaching", true, [true]],
    ["_enableCallstack", false, [true]]
];

if (isNil QGVAR(functionHeader)) then {
    GVAR(functionHeader) = preprocessFile QPATHTOF(script_header.hpp);
    GVAR(functionHeaderDebug) = preprocessFile QPATHTOF(script_header_callstack.hpp);
};

private _header = format [GVAR(functionHeader), _funcName];

if (_enableCallstack) then {
    private _preprocessedFunction = _header + GVAR(functionHeaderDebug) + preprocessFileLineNumbers _funcFile;
    missionNamespace setVariable [_funcName, compileFinal _preprocessedFunction];
} else {
    if (_enableCaching && {!(["compile"] call CBA_fnc_isRecompileEnabled)}) then {
        private _cachedFunction = uiNamespace getVariable _funcName;
        if (isNil "_cachedFunction") then {
            private _preprocessedFunction = _header + preprocessFileLineNumbers _funcFile;
            _cachedFunction = compileFinal _preprocessedFunction;
            uiNamespace setVariable [_funcName, _cachedFunction];
        };
        missionNamespace setVariable [_funcName, _cachedFunction];
    } else {
        private _preprocessedFunction = _header + preprocessFileLineNumbers _funcFile;
        missionNamespace setVariable [_funcName, compile _preprocessedFunction];
    };
};
