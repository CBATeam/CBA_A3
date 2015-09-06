/* ----------------------------------------------------------------------------
Function: CBA_fnc_logDynamic

Description:
    Logs messages with meta information to provided log writers.

    This respects log level restrictions (CBA_log_logLevel).

Parameters:
    _prefix - Prefix of the source logging [String]
    _component - Component that is logging [String]
    _message - Log message [String]
    _level - Log Level (default: CBA_LOGLEVEL_INFO) [Number]
    _logWriters - Log Writer functions (default: []) [Array]
    _file - Filename the log has been called from (default: nil) [String]
    _lineNumber - Linenumber the log has been called from (default: nil) [Number]

Returns:
    Formatted Log message [String]

Author:
    MikeMatrix
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(logDynamic);

private ["_logFormat", "_formattedMessage"];

params ["_prefix", "_component", "_message", ["_level", CBA_LOGLEVEL_INFO, [0]], ["_logWriters", [], [[]]], "_file", "_lineNumber"];

_logFormat = if (!isNil "_file" && !isNil "_lineNumber") then {
    "[%4_%5] %8 (%6:%7) <%1|%2|%3>: %9"
} else {
    "[%4_%5] %8 <%1|%2|%3>: %9"
};

_formattedMessage = format [_logFormat, diag_frameNo, diag_tickTime, time, _prefix, _component, _file, _lineNumber, [_level] call CBA_fnc_getLogLevelDescriptor, _message];

if (isNil QGVAR(logLevel)) then {
    #ifdef DEBUG_MODE_FULL
        GVAR(logLevel) = CBA_LOGLEVEL_TRACE;
    #else
        GVAR(logLevel) = CBA_LOGLEVEL_INFO;
    #endif
};

// Exit if log level is not sufficient.
if (_level < GVAR(logLevel)) exitWith {_formattedMessage};

{
    if (IS_STRING(_x)) then {
        [_formattedMessage] call (uiNamespace getVariable [_x, {}]);
    };
    if (IS_CODE(_x)) then {
        [_formattedMessage] call _x;
    };
    nil
} count _logWriters;

_formattedMessage
