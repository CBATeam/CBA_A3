#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_pid_fnc_setpoint

Description:
    Set a new setpoint for a PID controller.

Parameters:
    _pid        - a pid controller <LOCATION>
    _setpoint   - the new target setpoint for the controller <NUMBER>

Returns:
    Nothing

Examples:
    (begin example)
        [_pid, 42] call CBA_pid_fnc_setpoint;
    (end)

Author:
    tcvm
---------------------------------------------------------------------------- */
SCRIPT(setpoint);
params [
    ["_pid", locationNull, [locationNull]],
    ["_setpoint", 0, [0]]
];

if (isNull _pid) exitWith {};

_pid setVariable [QGVAR(setpoint), _setpoint];
_pid setVariable [QGVAR(history), []];
