/* -----------------------------------------------------------------------------
Function: CBA_fnc_formatElapsedTime

Description:
    Formats time in seconds according to a format.

    Intended to show time elapsed, rather than time-of-day.

Parameters:
    _seconds - Number of seconds to format, for example from 'time' command [number]
    _format - Format to put time into [String: "H:MM:SS", "M:SS",
        "H:MM:SS.mmm" or "M:SS.mmm"; defaults to "H:MM:SS"]

Returns:
    Formatted time [String]

Author:
    Spooner
---------------------------------------------------------------------------- */

#define DEBUG_MODE_NORMAL
#include "script_component.hpp"

SCRIPT(formatElapsedTime);

// -----------------------------------------------------------------------------

params ["_seconds", ["_format", "H:MM:SS"]];

// Discover all the digits to use.
private _hours = floor (_seconds / 3600);
_seconds = _seconds - (_hours * 3600);
private _minutes = floor (_seconds / 60);
_seconds = _seconds - (_minutes * 60);

// Add the milliseconds if required.
_elapsed = switch (_format) do {
    case "H:MM:SS": {
        format ["%1:%2:%3",
            _hours,
            [_minutes, 2] call CBA_fnc_formatNumber,
            [floor _seconds, 2] call CBA_fnc_formatNumber];
    };
    case "M:SS": {
        format ["%1:%2",
            _minutes,
            [floor _seconds, 2] call CBA_fnc_formatNumber];
    };
    case "H:MM:SS.mmm": {
        format ["%1:%2:%3",
            _hours,
            [_minutes, 2] call CBA_fnc_formatNumber,
            [_seconds, 2, 3] call CBA_fnc_formatNumber];
    };
    case "M:SS.mmm": {
        format ["%1:%2",
            _minutes,
            [_seconds, 2, 3] call CBA_fnc_formatNumber];
    };
    default {
        private "_msg";
        _msg = format ["%1: %2", _msg, _format];
        ERROR(_msg);
        _msg;
    };
};

_elapsed; // Return.
