/* ----------------------------------------------------------------------------
@description Logs a message to the RPT log.
-----------------------------------------------------------------------------*/

#include "script_component.hpp"

SCRIPT(log);

// ----------------------------------------------------------------------------
PARAMS_3(_file,_line,_message);

// TODO: Add log message to trace log
diag_log text format ["%1 [%2:%3] %4", [daytime, "HH:MM:SS:MM"] call BIS_fnc_timeToString, _file, _line + 1, _message];
