#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_pid_fnc_error_linear

Description:
    Linear error function.

Parameters:
    _observed           - the observed value <NUMBER>
    _setpoint           - the setpoint <NUMBER>

Returns:
    Error of `setpoint - observed` <NUMBER>

Examples:
    (begin example)
        private _error = [2, 5] call CBA_pid_fnc_error_linear;
    (end)

Author:
    tcvm
---------------------------------------------------------------------------- */
SCRIPT(error_linear);
params [
    ["_observed", 0, [0]],
    ["_setpoint", 0, [0]],
];

_setpoint - _observed
