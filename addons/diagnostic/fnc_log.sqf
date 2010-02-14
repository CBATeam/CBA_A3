/* ----------------------------------------------------------------------------
Function: CBA_fnc_log

Description:
	Logs a message to the RPT log.
	
	Should not be used directly, but rather via macro (<LOG()>).
	
	This function is unaffected by the debug level (<DEBUG_MODE_x>).
	
Parameters:
	_file - File error occurred in [String]
	_lineNum - Line number error occurred on (starting from 0) [Number]
	_message - Message [String]
	
Returns:
	nil
	
Author:
	Spooner and Rommel
-----------------------------------------------------------------------------*/

#include "script_component.hpp"

SCRIPT(log);

// ----------------------------------------------------------------------------
private ["_entry"];
PARAMS_3(_file,_lineNum,_message);

if (isNil "CBA_LOG_ARRAY") then { CBA_LOG_ARRAY = [] };
_entry = [_file,_lineNum,_message];
PUSH(CBA_LOG_ARRAY,_entry);

if (isNil "CBA_LOG_VAR") then
{
	CBA_LOG_VAR = true;
	[] spawn
	{
		_fnc_log =
		{
			PARAMS_3(_file,_lineNum,_message);
			// TODO: Add log message to trace log
			diag_log text format ["%1 (%2) [%3:%4] %5",
				[diag_tickTime, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime,
				[time, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime, _file, _lineNum + 1, _message];
		};

		while {count CBA_LOG_ARRAY > 0} do
		{
			_selected = CBA_LOG_ARRAY select 0;
			_selected call _fnc_log;
			
			// Removal method one
			CBA_LOG_ARRAY set [0, objNull];
			CBA_LOG_ARRAY = CBA_LOG_ARRAY - [objNull];
			
			/*
			// Removal method 2
			for "_i" from 1 to (count CBA_LOG_ARRAY - 1) do {
				CBA_LOG_ARRAY set [_i - 1, CBA_LOG_ARRAY select _i];
			};
			*/
		};
		CBA_LOG_VAR = nil;
	};
};

nil;

