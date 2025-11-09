#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_pid_fnc_update

Description:
    Updates a PID controller and returns the controller output.

Parameters:
    _pid    - a pid controller <LOCATION>
    _value  - the measured value for this update <NUMBER>
    _time   - the time for which the value was measured <NUMBER>
              (Default: CBA_missionTime)

Returns:
    The output of the controller <NUMBER>

Examples:
    (begin example)
        private _delta = [_pid, 6, CBA_missionTime] call CBA_pid_fnc_update;
    (end)

Author:
    tcvm
---------------------------------------------------------------------------- */
SCRIPT(update);
params [
    ["_pid", locationNull, [locationNull]],
    ["_value", 0, [0]],
    ["_time", CBA_missionTime, [0]]
];

if (isNull _pid) exitWith {};

private _error = [_value, _pid getVariable [QGVAR(setpoint), 0]] call (_pid getVariable [QGVAR(errorFunction), {0}]);
private _history = _pid getVariable [QGVAR(history), []];
private _maxHistoryLength = _pid getVariable [QGVAR(historyLength), 2];

_history pushBack [_time, _value];
if (count _history > _maxHistoryLength) then {
    _history deleteAt 0;
};
_pid setVariable [QGVAR(history), _history];

private _derivative = 0;
switch (true) do {
    case (count _history == 2): {
        private _x0 = _history select 0;
        private _x1 = _history select 1;

        private _stride = (_x1 select 0) - (_x0 select 0);
        if (_stride == 0) then { break };

        _derivative = ((_x0 select 1) - (_x1 select 1)) / _stride;
    };
    case (count _history >= 3): {
        private _xn0 = _history select -1;
        private _xn1 = _history select -2;
        private _xn2 = _history select -3;
        private _stride = (_xn0 select 0) - (_xn1 select 0);
        if (_stride == 0) then { break };

        private _sum = -3 * (_xn2 select 1) + 4 * (_xn1 select 1) - (_xn0 select 1);
        _derivative = _sum / (2 * _stride);
    };
    default {};
};

private _integral = 0;
private _tn_prev = 0;
{
    if (_forEachIndex == 0) then { continue };
    _x params ["_tn", "_error"];
    private _stride = _tn - _tn_prev;
    _integral = _integral + (_error * _stride);
    _tn_prev = _tn;
} forEach _history;

(_pid getVariable [QGVAR(gains), [0, 0, 0]]) params ["_pGain", "_iGain", "_dGain"];

private _delta = _error * _pGain + _integral * _iGain + _derivative * _dGain;

(_pid getVariable [QGVAR(bounds), [-1e99, 1e99]]) params ["_min", "_max"];

_max min (_delta max _min)
