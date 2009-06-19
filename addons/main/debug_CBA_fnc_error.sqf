/* ----------------------------------------------------------------------------
Function: CBA_fnc_error

Description:
	Logs an error message to the RPT log.
	
Parameters:
	_file - [String]
	_lineNum - [Number]
	_title - Title of the error [String]
	_message - Error message [String, which may contain \n]
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(error);

// -----------------------------------------------------------------------------
PARAMS_4(_file,_lineNum,_title,_message);

private ["_time", "_lines"];

// TODO: popup window with error message in it.
_time = [diag_tickTime, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime;

diag_log text format ["%1 [%2:%3] -ERROR- %4", _time, _file, _lineNum + 1, _title];

_lines = [_message, "\n"] call CBA_fnc_split;

{
	diag_log text format ["            %1", _x];
} forEach _lines;

nil;
