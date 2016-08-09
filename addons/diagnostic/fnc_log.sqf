/* ----------------------------------------------------------------------------
Internal Function: CBA_fnc_log

Description:
    Logs a message to the RPT log.

    Should not be used directly, but rather via macro (<LOG()>).
    This function is unaffected by the debug level (<DEBUG_MODE_x>).

Parameters:
    _message   - Message <STRING>

Returns:
    nil

Author:
    Spooner, Rommel, commy2
-----------------------------------------------------------------------------*/
#define DEBUG_MODE_NORMAL
#include "script_component.hpp"
SCRIPT(log);

params [["_message", "", [""]]];

if (isNil QGVAR(logArray)) then {
    GVAR(logArray) = [];
    GVAR(logScript) = scriptNull;
};

GVAR(logArray) pushBack text _message;

if (scriptDone GVAR(logScript)) then {
    GVAR(logScript) = 0 spawn {
        private "_selected";

        while {
            _selected = GVAR(logArray) deleteAt 0;
            !isNil "_selected"
        } do {
            diag_log _selected;
        };
    };
};

nil
