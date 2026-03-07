#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_fnc_error

Description:
    Logs an error message to the RPT log.

    Should not be used directly, but rather via macros (<ERROR()>, <ERROR_WITH_TITLE()>
    or the <Assertions>).

Parameters:
    _prefix    - Addon name (optional, defaut: "cba") <STRING>
    _component - Component name (optional, default: "diagnostic") <STRING>
    _title     - Title of the error (optional) <STRING>
    _message   - Error message (use "\n" for newline) (optional) <STRING>
    _file      - Name of file (optional) <STRING>
    _lineNum   - Line of file (optional) <NUMBER>

Returns:
    nil

Author:
    Spooner, commy2
---------------------------------------------------------------------------- */
SCRIPT(error);

params [
    ["_prefix", 'PREFIX', [""]],
    ["_component", 'COMPONENT'],
    ["_title", "", [""]],
    ["_message", "", [""]],
    ["_file", "", [""]],
    ["_lineNum", -1, [0]]
];

_prefix = toUpper _prefix;

// RPT log
diag_log text format ["[%1] (%2) ERROR: %3 %4:%5", _prefix, _component, _title, _file, _lineNum];

private _lines = [_message, "\n"] call CBA_fnc_split;

{
    diag_log text format ["            %1", _x];
} forEach _lines;

// error pop up
disableSerialization;
QGVAR(Error) cutRsc [QGVAR(Error), "PLAIN"];
private _control = uiNamespace getVariable QGVAR(Error);

if (_title isEqualTo "") then {
    _title = "ERROR";
};

private _compose = [lineBreak, parseText format [
    "<img align='center' size='1.65' image='\a3\3DEN\Data\Displays\Display3DEN\EntityMenu\functions_ca.paa' /><t align='center' size='1.65'>[%1] (%2) %3<\t>",
    _prefix, _component, _title
], lineBreak];

{
    _compose append [lineBreak, format ["            %1", _x]];
} forEach _lines;

_control ctrlSetStructuredText composeText _compose;

nil
