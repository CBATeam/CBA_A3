/* ----------------------------------------------------------------------------
Function: CBA_fnc_error

Description:
    Logs an error message to the RPT log.

    Should not be used directly, but rather via macros (<ERROR()>,
        <ERROR_WITH_TITLE()> or the <Assertions>).

Parameters:
    _file - Name of file [String]
    _lineNum - Line of file (starting at 0) [Number]
    _title - Title of the error [String]
    _message - Error message [String, which may contain \n]

Returns:
    nil

Author:
    Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(error);

// -----------------------------------------------------------------------------
PARAMS_4(_file,_lineNum,_title,_message);

private ["_time", "_lines"];

// TODO: popup window with error message in it.
_time = [diag_tickTime, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime;

diag_log text format ["%1 (%2) [%3:%4] -ERROR- %5", _time, time, _file, _lineNum + 1, _title];

_lines = [_message, "\n"] call CBA_fnc_split;

{
    diag_log text format ["            %1", _x];
} forEach _lines;

nil;
