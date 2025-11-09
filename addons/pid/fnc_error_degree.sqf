#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_pid_fnc_error_degree

Description:
    Error function that is adjusted for degree values.
    This function will account for wraparound with values in the domain of [-180, 180] or [0, 360]

Parameters:
    _observed           - the observed value <NUMBER>
    _setpoint           - the setpoint <NUMBER>

Returns:
    Wrapped error of `setpoint - observed` <NUMBER>

Examples:
    (begin example)
        private _error = [350, 5] call CBA_pid_fnc_error_degree;
        // _error == 15
    (end)

Author:
    tcvm
---------------------------------------------------------------------------- */
SCRIPT(error_degree);
params [
    ["_observed", 0, [0]],
    ["_setpoint", 0, [0]],
];

private _absoluteError =_setpoint - _observed;
private _error = _absoluteError;
if (_absoluteError < -180) then {
    _error = 360 + _absoluteError;
};
if (_absoluteError > 180) then {
    _error = _absoluteError - 360;
};
_error
