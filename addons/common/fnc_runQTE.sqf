#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_runQTE

Description:
    Runs a Quick time Event.

Parameters:
    _object - <OBJECT>
    _args - Extra arguments passed to the _on... functions<ARRAY>
    _onDisplay - Code callback on displayable event passed [_args, _qteSequence, _qte_history]. <CODE, STRING>
    _onFinish - Code callback on Quick-Time Event completed passed [_args, _elapsedTime]. <CODE, STRING>
    _onFinish - Code callback on Quick-Time Event timeout/outranged passed [_args, _elapsedTime]. <CODE, STRING>
    _qteSequence - Quick-Time sequence made up of ["↑", "↓", "→", "←"] <ARRAY>
    _maxDistance - max interaction distance from attached object <NUMBER> (default: 10) 
    _timeout - ingame timeout <NUMBER> (default: 30)

Example:
    [car,
    [], 
    { 
    hint format [
        "%1 \n %2",
        [_this select 1] call CBA_fnc_getFormattedQTESequence,
        [_this select 2] call CBA_fnc_getFormattedQTESequence
        ]
    }, 
    { 
    hint "Finished!"; 
    },
    { 
        hint "Failure!"; 
    },
    ["↑", "↓", "→", "←"]] call CBA_fnc_runQTE

Returns:
    <BOOELAN> - True if the QTE was started, false if it was already running.

Author:
    john681611
---------------------------------------------------------------------------- */


params ["_object", "_args", "_onDisplay", "_onFinish", "_onFail", "_qteSequence", ["_maxDistance", 10], ["_timeout", 30]];
if (GVAR(QTERunning)) exitWith {
    false
};

GVAR(QTEHistory) = [];
GVAR(QTERunning) = true;
private _startTime = CBA_missionTime;
private _qteArgsArray = [
    ["object", _object],
    ["args", _args],
    ["onDisplay", _onDisplay],
    ["onFinish", _onFinish],
    ["onFail", _onFail],
    ["maxDistance", _maxDistance],
    ["qte_seqence", _qteSequence],
    ["startTime", _startTime],
    ["timeout", _timeout]
];
GVAR(QTEArgs) = createHashMapFromArray _qteArgsArray;

// Setup 
[{
    private _timeout = GVAR(QTEArgs) get "timeout";
    private _object = GVAR(QTEArgs) get "object";
    private _maxDistance = GVAR(QTEArgs) get "maxDistance";
    private _elapsedTime = CBA_missionTime - (GVAR(QTEArgs) get "startTime");
    
    !GVAR(QTERunning) || player distance _object > _maxDistance || _elapsedTime > _timeout;
}, {
    TRACE_1("QTE ended",GVAR(QTERunning));
    if(!GVAR(QTERunning)) exitWith {};
    GVAR(QTERunning) = false;
    GVAR(QTEHistory) = [];
    private _onFail = (GVAR(QTEArgs) get "onFail");
    private _args = (GVAR(QTEArgs) get "args");
    TRACE_1("QTE Failed",_args);
    if (_onFail isEqualType "") then {
        [_onFail, [_args, _elapsedTime]] call CBA_fnc_localEvent;
    } else {
        [_args, _elapsedTime] call _onFail;
    };
}, []] call CBA_fnc_waitUntilAndExecute;

if (_onDisplay isEqualType "") then {
    [_onDisplay, [_args, _qteSequence, []]] call CBA_fnc_localEvent;
} else {
    [_args, _qteSequence, []] call _onDisplay;
};

true
