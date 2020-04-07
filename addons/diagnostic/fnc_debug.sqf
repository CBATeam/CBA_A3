#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_debug

Description:
    General Purpose Debug Message Writer

    Handles very long messages without losing text.

Parameters:
    _message - Message to write <STRING, ARRAY>
    _title   - Message title (optional, default: "cba_diagnostic") <STRING>
    _type    - Type of message <ARRAY>
        0: _useChat - Write to chat (optional, default: true) <BOOLEAN>
        1: _useLog  - Log to arma.rpt (optional, default: true) <BOOLEAN>
        2: _global  - true: execute global (optional, default: false) <BOOLEAN>

Returns:
    nil

Examples:
    (begin example)
        // Write the debug message in chat-log of every client
        ["New Player Joined the Server!", "cba_network", [true, false, true]] call CBA_fnc_debug;
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */

// function to split lines into multiple lines with a maxium length
#define MAX_LINE_LENGTH 120

private _fnc_splitLines = {
    private _return = [];

    {
        private _string = _x;

        while {count _string > 0} do {
            _return pushBack (_string select [0, MAX_LINE_LENGTH]);
            _string = _string select [MAX_LINE_LENGTH];
        };
    } forEach _this;

    _return
};

// create a logic than can use the chat
if (isNil QGVAR(logic)) then {
    GVAR(logic) = "Logic" createVehicleLocal [0, 0, 0];
};

// input
params [["_message", "", ["", []]], ["_title", 'ADDON', [""]], ["_type", [], [[]]]];

_type params [
    ["_useChat", true, [false]],
    ["_useLog", true, [false]],
    ["_global", false, [false]]
];

// forward to remote machines
if (_global) then {
    [QGVAR(debug), [_message, _title, [_useChat, _useLog, false]]] call CBA_fnc_remoteEvent;
};

// if string, split into seperate lines marked by "\n"
if (_message isEqualType "") then {
    _message = [_message, "\n"] call CBA_fnc_split;
};

// format the first line to include title and time stamp
_message set [0, format [
    "(%3) %1 - %2",
    _title,
    _message select 0,
    [CBA_missionTimeTriple vectorDotProduct [1e6 , 1e3, 1], "H:MM:SS"] call CBA_fnc_formatElapsedTime
]];

_message = _message call _fnc_splitLines;

// print in chat
if (_useChat) then {
    // fix for chat-log being reset after the loading screen
    if (time < 1) then {
        _message spawn {
            uiSleep 1;

            {
                GVAR(logic) globalChat _x;
            } forEach _this;
        };
    } else {
        {
            GVAR(logic) globalChat _x;
        } forEach _message;
    };
};

// print in rpt-log
if (_useLog) then {
    {
        diag_log text _x;
    } forEach _message;
};
