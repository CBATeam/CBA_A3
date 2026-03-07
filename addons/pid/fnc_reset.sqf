#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_pid_fnc_reset

Description:
    Reset a PID controller's history.

Parameters:
    _pid           - the controller <HASHMAP>

Returns:
    Nothing

Examples:
    (begin example)
        _pid call CBA_pid_fnc_reset;
    (end)

Author:
    tcvm
---------------------------------------------------------------------------- */
SCRIPT(reset);
params [
    ["_pid", createHashMap, [createHashMap]]
];

_pid set [QGVAR(history), []];
