/* ----------------------------------------------------------------------------
@description Logs a message to the RPT log.
-----------------------------------------------------------------------------*/

#include "script_component.hpp"

SCRIPT(log);

// ----------------------------------------------------------------------------
PARAMS_3(_file,_line,_message);

// TODO: Add log message to trace log
diag_log text format ["%1 [%2:%3] %4", [time, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime, _file, _line + 1, _message];

nil;
