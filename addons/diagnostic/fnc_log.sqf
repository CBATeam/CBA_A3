/* ----------------------------------------------------------------------------
Function: CBA_fnc_log

Description:
	Logs a message to the RPT log.
	
	Should not be used directly, but rather via macro (<LOG(MESSAGE)>).
	
	This function is unaffected by the debug level (<DEBUG_MODE_*>).
	
Parameters:
	_file - [String]
	_lineNum - [Number]
	_message - Message [String]
	
Returns:
	nil
	
Author:
	Spooner
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

