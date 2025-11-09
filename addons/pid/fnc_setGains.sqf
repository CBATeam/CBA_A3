#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_pid_fnc_setGains

Description:
    Set new gains for a PID controller.

Parameters:
    _pid        - a pid controller <LOCATION>
    _pGain      - the new proportional gain <NUMBER>
                  OR
                  `nil`, to keep the current gain <NIL>
    _iGain      - the new integral gain <NUMBER>
                  OR
                  `nil`, to keep the current gain <NIL>
    _dGain      - the new derivative gain <NUMBER>
                  OR
                  `nil`, to keep the current gain <NIL>
Returns:
    Nothing

Examples:
    (begin example)
        [_pid, 5, nil, 0.2] call CBA_pid_fnc_setGains;
    (end)

Author:
    tcvm
---------------------------------------------------------------------------- */
SCRIPT(setGains);
params [
    ["_pid", locationNull, [locationNull]],
    ["_pGain", nil, [0, nil]],
    ["_iGain", nil, [0, nil]],
    ["_dGain", nil, [0, nil]]
];

if (isNull _pid) exitWith {};

(_pid getVariable [QGVAR(gains), [0, 0, 0]]) params ["_currentPGain", "_currentIGain", "_currentDGain"];
if !(isNil "_pGain") then {
    _currentPGain = _pGain;
};
if !(isNil "_iGain") then {
    _currentIGain = _iGain;
};
if !(isNil "_dGain") then {
    _currentDGain = _dGain;
};
_pid setVariable [QGVAR(gains), [_currentPGain, _currentIGain, _currentDGain]];
