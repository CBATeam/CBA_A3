/* ----------------------------------------------------------------------------
Function: CBA_fnc_log

Description:
    Logs a message to the RPT log.

    Should not be used directly, but rather via macro (<LOG()>).
    This function is unaffected by the debug level (<DEBUG_MODE_x>).

Parameters:
    _file      - File error occurred in <STRING>
    _lineNum   - Line number error occurred on <NUMBER>
    _message   - Message <STRING>
    _prefix    - Addon name (optional, defaut: "cba") <STRING>
    _component - Component name (optional, default: "diagnostic") <STRING>

Returns:
    nil

Author:
    Spooner, Rommel, commy2
-----------------------------------------------------------------------------*/
#define DEBUG_MODE_NORMAL
#include "script_component.hpp"
SCRIPT(log);

params [
    ["_file", "", [""]],
    ["_lineNum", -1, [0]],
    ["_message", "", [""]],
    ["_prefix", 'PREFIX', [""]],
    ["_component", 'COMPONENT', [""]]
];

private _log = text format ["[%1] (%2) WARNING: %3 File: %4 Line: %5", toUpper _prefix, _component, _message, _file, _lineNum];

#ifndef DEBUG_SYNCHRONOUS
    if (isNil QGVAR(logArray)) then {
        GVAR(logArray) = [];
        GVAR(logScript) = scriptNull;
    };

    GVAR(logArray) pushBack _log;

    if (scriptDone GVAR(logScript)) then {
        GVAR(logScript) = 0 spawn {
            private "_selected";

            while {
                _selected = CBA_LOG_ARRAY deleteAt 0;
                !isNil "_selected"
            } do {
                diag_log _selected;
            };
        };
    };
#else
    diag_log _log;
#endif

nil
