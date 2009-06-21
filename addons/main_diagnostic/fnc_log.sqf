/* ----------------------------------------------------------------------------
Function: CBA_fnc_log

Description:
	Logs a message to the RPT log.
	
Parameters:
	_file - [String]
	_lineNum - [Number]
	_message - Message [String]
-----------------------------------------------------------------------------*/

#include "script_component.hpp"

SCRIPT(log);

// ----------------------------------------------------------------------------
PARAMS_3(_file,_lineNum,_message);

// TODO: Add log message to trace log
diag_log text format ["%1 [%2:%3] %4",
	[diag_tickTime, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime,
	_file, _lineNum + 1, _message];

nil;
