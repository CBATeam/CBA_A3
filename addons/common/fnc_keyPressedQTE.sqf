#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_keyPressedQTE

Description:
    Process Quick-Time Key Press

Parameters:
    _eventQTE - Character to test against Quick-Time Event <STRING>

Example:
    ["↑"] call CBA_fnc_keyPressedQTE;

Returns:
    None

Author:
    john681611
---------------------------------------------------------------------------- */


params ["_eventQTE"];

if !(missionNamespace getVariable [QGVAR(QTERunning), false]) exitWith {};
if !(_eventQTE in ["↑", "↓", "→", "←"]) exitWith {};


private _args = GVAR(QTEArgs) get "args";
private _qteSequence = GVAR(QTEArgs) get "qte_seqence";
private _elapsedTime = CBA_missionTime - GVAR(QTEArgs) get "start_time";

GVAR(QTEHistory) pushBack _eventQTE;


if (GVAR(QTEHistory) isEqualTo _qteSequence) exitWith {
    GVAR(QTEHistory) = [];
    GVAR(QTERunning) = false;
    TRACE_1("QTE Completed",_elapsedTime);
    private _onFinish = GVAR(QTEArgs) get "onFinish";
    if (_onFinish isEqualType "") then {
        [_onFinish, [_args, _elapsedTime]] call CBA_fnc_localEvent;
    } else {
        [_args, _elapsedTime] call _onFinish;
    };
};

if (GVAR(QTEHistory) isNotEqualTo (_qteSequence select [0, count GVAR(QTEHistory)])) then {
    GVAR(QTEHistory) = [];
};

private _onDisplay = GVAR(QTEArgs) get "onDisplay";
if (_onDisplay isEqualType "") then {
    [_onDisplay, [_args, _qteSequence, GVAR(QTEHistory)]] call CBA_fnc_localEvent;
} else {
    [_args, _qteSequence, GVAR(QTEHistory)] call _onDisplay;
};
