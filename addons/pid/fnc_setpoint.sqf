#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_pid_fnc_setpoint

Description:
    Set a new setpoint for a PID controller.

Parameters:
    _pid        - a pid controller <HASHMAP>
    _setpoint   - the new target setpoint for the controller <NUMBER>
    _reset      - if we want to reset the PID for the new setpoint <BOOL> (Default: true)

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
    ["_pid", createHashMap, [createHashMap]],
    ["_setpoint", 0, [0]],
    ["_reset", true, [true]]
];

_pid set [QGVAR(setpoint), _setpoint];
if (_reset) then {
    _pid set [QGVAR(history), []];
};
