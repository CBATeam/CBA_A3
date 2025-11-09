#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_pid_fnc_create

Description:
    Creates a PID controller.

Parameters:
    _pGain          - gain for the immediate error <NUMBER>
    _iGain          - gain for the persistent error over time <NUMBER>
    _dGain          - gain for the error rate over time <NUMBER>
    _setpoint       - initial setpoint for the controller <NUMBER>
    _errorFunction  - the function which calculates the error which the controller operators <CODE>
    _min            - the minimum value the controller can return <NUMBER>
    _max            - the maximum value the controller can return <NUMBER>
    _historyLength  - how many past errors are stored and used to calculate the derivative/integral <NUMBER>

Returns:
    _pid            - a PID controller <LOCATION>

Examples:
    (begin example)
        private _pid = [1, 0.05, 0.2, 5, CBA_pid_fnc_error_linear, 0, 10, 15] call CBA_pid_fnc_create;
    (end)

Author:
    tcvm
---------------------------------------------------------------------------- */
SCRIPT(create);
params [
    ["_pGain", 0, [0]],
    ["_iGain", 0, [0]],
    ["_dGain", 0, [0]],
    ["_setpoint", 0, [0]],
    ["_errorFunction", FUNC(error_linear), [{0}]],
    ["_min", -1e99, [0]],
    ["_max",  1e99, [0]],
    ["_historyLength", 3, [0]],
];

private _pid = call CBA_fnc_createNamespace;
_pid setVariable [QGVAR(gains), [_pGain, _iGain, _dGain]];
_pid setVariable [QGVAR(bounds), [_min, _max]];
_pid setVariable [QGVAR(history), []];
_pid setVariable [QGVAR(historyLength), _historyLength];
_pid setVariable [QGVAR(setpoint), _setpoint];
_pid setVariable [QGVAR(errorFunction), _errorFunction];

_pid
