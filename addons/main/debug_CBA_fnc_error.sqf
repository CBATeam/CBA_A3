/* ----------------------------------------------------------------------------
@description Logs an error message to the RPT log.
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(error);

// -----------------------------------------------------------------------------
PARAMS_4(_file,_line,_message,_title);

_message = [_message, "\n", " | "] call CBA_fnc_replace;

// TODO: popup window with error message in it.
diag_log text format ["%1 [%2:%3 ERROR %4] %5", [daytime, "HH:MM:SS:MM"] call BIS_fnc_timeToString, _file, _line + 1, _title, _message];
