#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_keyPressedQTE

Description:
    Process Quick-Time Key Press

Parameters:
    _eventQTE - Character to test against Quick-Time Event <STRING>

Example:
    ["^"] call CBA_fnc_keyPressedQTE;

Returns:
    True if QTE is running <BOOLEAN>

Author:
    john681611
---------------------------------------------------------------------------- */


params ["_eventQTE"];

if !(missionNamespace getVariable [QGVAR(QTERunning), false]) exitWith {
    false
};

private _args = GVAR(QTEArgs) get "args";
private _qteSequence = GVAR(QTEArgs) get "qteSequence";
private _elapsedTime = CBA_missionTime - (GVAR(QTEArgs) get "startTime");

GVAR(QTEHistory) pushBack _eventQTE;

// Check if the input corresponds to the sequence
if (GVAR(QTEHistory) isEqualTo _qteSequence) exitWith {
    GVAR(QTEHistory) = [];
    GVAR(QTERunning) = false;
    TRACE_1("QTE Completed",_elapsedTime);
    private _onFinish = GVAR(QTEArgs) get "onFinish";
    if (_onFinish isEqualType "") then {
        [_onFinish, [_args, _elapsedTime, GVAR(QTEResetCount)]] call CBA_fnc_localEvent;
    } else {
        [_args, _elapsedTime, GVAR(QTEResetCount)] call _onFinish;
    };
    true
};

private _incorrectInput = false;

// If the user failed an input, wipe the previous input from memory
if (GVAR(QTEHistory) isNotEqualTo (_qteSequence select [0, count GVAR(QTEHistory)])) then {
    if (GVAR(QTEArgs) get "resetUponIncorrectInput") then {
        GVAR(QTEHistory) = [];
        GVAR(QTEResetCount) = GVAR(QTEResetCount) + 1;
    } else {
        GVAR(QTEHistory) deleteAt [-1];
    };

    _incorrectInput = true;
};

private _onDisplay = GVAR(QTEArgs) get "onDisplay";
if (_onDisplay isEqualType "") then {
    [_onDisplay, [_args, _qteSequence, GVAR(QTEHistory), GVAR(QTEResetCount), _incorrectInput]] call CBA_fnc_localEvent;
} else {
    [_args, _qteSequence, GVAR(QTEHistory), GVAR(QTEResetCount), _incorrectInput] call _onDisplay;
};

true
