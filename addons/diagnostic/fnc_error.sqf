/* ----------------------------------------------------------------------------
Function: CBA_fnc_error

Description:
    Logs an error message to the RPT log.

    Should not be used directly, but rather via macros (<ERROR()>,
    <ERROR_WITH_TITLE()> or the <Assertions>).

Parameters:
    _file      - Name of file [String]
    _lineNum   - Line of file (starting at 0) [Number]
    _title     - Title of the error [String]
    _message   - Error message [String, which may contain \n]
    _prefix    - Addon name (optional, defaut: "cba") <STRING>
    _component - Component name (optional, default: "diagnostic") <STRING>

Returns:
    nil

Author:
    Spooner, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(error);

params [
    ["_file", "", [""]],
    ["_lineNum", -1, [0]],
    ["_title", "", [""]],
    ["_message", "", [""]],
    ["_prefix", 'PREFIX', [""]],
    ["_component", 'COMPONENT', [""]]
];

// TODO: popup window with error message in it.
diag_log text format ["[%1] (%2) ERROR: %3 File: %4 Line: %5", toUpper _prefix, _component, _title, _file, _lineNum];

if (_message != "") then {
    private _lines = [_message, "\n"] call CBA_fnc_split;

    {
        diag_log text format ["            %1", _x];
    } forEach _lines;
};

nil
