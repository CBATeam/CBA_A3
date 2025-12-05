#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_pid_fnc_create

Description:
    Creates a PID controller.

Parameters:
    _pGain          - gain for the immediate error <NUMBER>
                      (Default: 0)
    _iGain          - gain for the persistent error over time <NUMBER>
                      (Default: 0)
    _dGain          - gain for the error rate over time <NUMBER>
                      (Default: 0)
    _setpoint       - initial setpoint for the controller <NUMBER>
                      (Default: 0)
    _min            - the minimum value the controller can return <NUMBER>
                      (Default: -1e30)
    _max            - the maximum value the controller can return <NUMBER>
                      (Default: 1e30)
    _errorFunction  - the function which calculates the error which the controller operators <CODE>
                      (Default: <CBA_pid_fnc_error_linear>)
    _historyLength  - how many past errors are stored and used to calculate the derivative/integral <NUMBER>
                      (Default: 10)

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
    ["_min", -LARGE_NUMBER, [0]],
    ["_max",  LARGE_NUMBER, [0]],
    ["_errorFunction", FUNC(error_linear), [{}]],
    ["_historyLength", DEFAULT_HISTORY_LENGTH, [0]]
];

private _pid = call CBA_fnc_createNamespace;
_pid setVariable [QGVAR(gains), [_pGain, _iGain, _dGain]];
_pid setVariable [QGVAR(bounds), [_min, _max]];
_pid setVariable [QGVAR(history), []];
_pid setVariable [QGVAR(historyLength), _historyLength];
_pid setVariable [QGVAR(setpoint), _setpoint];
_pid setVariable [QGVAR(errorFunction), _errorFunction];

_pid
