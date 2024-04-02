#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_runQTE

Description:
    Runs a Quick time Event.

Parameters:
    _object - <OBJECT>
    _args - Extra arguments passed to the _on... functions<ARRAY>
    _onDisplay - Code callback on displayable event passed [_args, _qte_sequence, _qte_history]. <CODE, STRING>
    _onFinish - Code callback on Quick-Time Event completed passed [_args, _elapsedTime]. <CODE, STRING>
    _onFinish - Code callback on Quick-Time Event timeout/outranged passed [_args, _elapsedTime]. <CODE, STRING>
    _qte_sequence - Quick-Time sequence made up of ["↑", "↓", "→", "←"] <ARRAY>
    _max_distance - max interaction distance from attached object <NUMBER> (default: 10) 
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
    True if the QTE was started, false if it was already running <BOOELAN>

Author:
    john681611
---------------------------------------------------------------------------- */


params ["_object", "_args", "_onDisplay", "_onFinish", "_onFail", "_qte_sequence", ["_max_distance", 10], ["_timeout", 30]];
if (GVAR(QTERunning)) exitWith {
    false
};

GVAR(QTEHistory) = [];
GVAR(QTERunning) = true;
private _start_time = CBA_missionTime;
private _qteArgsArray = [
    ["object", _object],
    ["args", _args],
    ["onDisplay", _onDisplay],
    ["onFinish", _onFinish],
    ["onFail", _onFail],
    ["max_distance", _max_distance],
    ["qte_seqence", _qte_sequence],
    ["start_time", _start_time],
    ["timeout", _timeout]
];
GVAR(QTEArgs) = createHashMapFromArray _qteArgsArray;

// Setup 
[{
    private _timeout = GVAR(QTEArgs) get "timeout";
    private _object = GVAR(QTEArgs) get "object";
    private _max_distance = GVAR(QTEArgs) get "max_distance";
    private _elapsedTime = CBA_missionTime - (GVAR(QTEArgs) get "start_time");
    
    !GVAR(QTERunning) || player distance _object > _max_distance || _elapsedTime > _timeout;
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
    [_onDisplay, [_args, _qte_sequence, []]] call CBA_fnc_localEvent;
} else {
    [_args, _qte_sequence, []] call _onDisplay;
};

true
