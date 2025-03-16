#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_runQTE

Description:
    Runs a Quick-Time Event.

Parameters:
    _args - Extra arguments passed to the _on... functions<ARRAY>
    _failCondition - Code condition to fail the Quick-Time Event passed [_args, _elapsedTime, _resetCount]. <CODE, STRING> (default: {false})
    _onDisplay - Code callback on displayable event passed [_args, _qteSequence, _qteHistory, _resetCount, _incorrectInput]. <CODE, STRING>
    _onFinish - Code callback on Quick-Time Event completed passed [_args, _elapsedTime, _resetCount]. <CODE, STRING>
    _onFail - Code callback on Quick-Time Event timeout/outranged passed [_args, _elapsedTime, _resetCount]. <CODE, STRING>
    _qteSequence - Quick-Time sequence made up of ["^", "v", ">", "<"] <ARRAY>
    _resetUponIncorrectInput - Reset Quick-Time keystroke history if input is incorrect <BOOLEAN>

Example:
    [car,
    {
        params ["_args", "_elapsedTime", "_resetCount"];
        player distance _args > 10 || _elapsedTime > 10 || _resetCount >= 3;
    },
    {
        params ["_args", "_qteSequence", "_qteHistory", "_resetCount"];
        hint format [
            "%3/3 \n %1 \n %2",
            [_qteSequence] call CBA_fnc_getFormattedQTESequence,
            [_qteHistory] call CBA_fnc_getFormattedQTESequence,
            _resetCount
        ]
    },
    {
        params ["_args", "_elapsedTime", "_resetCount"];
        hint format ["Finished! %1s %2", _elapsedTime, _resetCount];
    },
    {
        params ["_args", "_elapsedTime", "_resetCount"];
        hint format ["Failure! %1s %2", _elapsedTime, _resetCount];
    },
    ["^", "v", ">", "<"]] call CBA_fnc_runQTE

Returns:
    True if the QTE was started, false if it was already running <BOOLEAN>

Author:
    john681611
---------------------------------------------------------------------------- */
if (missionNamespace getVariable [QGVAR(QTERunning), false]) exitWith {
    false
};

params [
    "_args",
    ["_failCondition",{false}, ["", {}]],
    ["_onDisplay",{}, ["", {}]],
    ["_onFinish",{}, ["", {}]],
    ["_onFail",{}, ["", {}]],
    ["_qteSequence", [], [[]]],
    ["_resetUponIncorrectInput", true, [false]]
];

GVAR(QTEHistory) = [];
GVAR(QTEResetCount) = 0;
GVAR(QTERunning) = true;
private _startTime = CBA_missionTime;
if(GVAR(qteShorten)) then {
    _qteSequence = _qteSequence select [0, 1];
};
private _qteArgsArray = [
    ["args", _args],
    ["failCondition", _failCondition],
    ["onDisplay", _onDisplay],
    ["onFinish", _onFinish],
    ["onFail", _onFail],
    ["qteSequence", _qteSequence],
    ["startTime", _startTime],
    ["resetUponIncorrectInput", _resetUponIncorrectInput]
];
GVAR(QTEArgs) = createHashMapFromArray _qteArgsArray;

// Setup
[{
    private _args = GVAR(QTEArgs) get "args";
    private _failCondition = GVAR(QTEArgs) get "failCondition";
    private _elapsedTime = CBA_missionTime - (GVAR(QTEArgs) get "startTime");

    !GVAR(QTERunning) || [_args, _elapsedTime, GVAR(QTEResetCount)] call _failCondition;
}, {
    TRACE_1("QTE ended",GVAR(QTERunning));
    if(!GVAR(QTERunning)) exitWith {};
    GVAR(QTERunning) = false;
    GVAR(QTEHistory) = [];
    private _onFail = GVAR(QTEArgs) get "onFail";
    private _args = GVAR(QTEArgs) get "args";
    private _elapsedTime = CBA_missionTime - (GVAR(QTEArgs) get "startTime");
    TRACE_1("QTE Failed",_args);
    if (_onFail isEqualType "") then {
        [_onFail, [_args, _elapsedTime, GVAR(QTEResetCount)]] call CBA_fnc_localEvent;
    } else {
        [_args, _elapsedTime, GVAR(QTEResetCount)] call _onFail;
    };
}, []] call CBA_fnc_waitUntilAndExecute;

if (_onDisplay isEqualType "") then {
    [_onDisplay, [_args, _qteSequence, [], GVAR(QTEResetCount), false]] call CBA_fnc_localEvent;
} else {
    [_args, _qteSequence, [], GVAR(QTEResetCount), false] call _onDisplay;
};

true
