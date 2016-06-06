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
#define DEBUG_MODE_NORMAL
#include "script_component.hpp"

SCRIPT(log);

// ----------------------------------------------------------------------------

#ifndef DEBUG_SYNCHRONOUS
    if (isNil "CBA_LOG_ARRAY") then { CBA_LOG_ARRAY = [] };
    private ["_msg"];
    _msg = [_this select 0, _this select 1, _this select 2, diag_frameNo, diag_tickTime, time]; // Save it here because we want to know when it was happening, not when it is outputted
    CBA_LOG_ARRAY pushBack _msg;

    if (isNil "CBA_LOG_VAR") then
    {
        CBA_LOG_VAR = true;
        SLX_XEH_STR spawn
        {
            _fnc_log =
            {
                params ["_file","_lineNum","_message","_frameNo","_tickTime","_gameTime"];
                // TODO: Add log message to trace log
                diag_log [_frameNo,
                    _tickTime, _gameTime, //[_tickTime, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime, [_gameTime, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime,
                    _file + ":"+str(_lineNum + 1), _message];
            };

            _selected = "";
            while {_selected = CBA_LOG_ARRAY deleteAt 0; !isNil "_selected"} do
            {
                _selected call _fnc_log;
            };
            CBA_LOG_VAR = nil;
        };
    };
#else
    params ["_file","_lineNum","_message"];
    // TODO: Add log message to trace log
    diag_log [diag_frameNo,
        diag_tickTime, time, // [diag_tickTime, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime, [time, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime
        _file + ":"+str(_lineNum + 1), _message];
#endif

nil;
