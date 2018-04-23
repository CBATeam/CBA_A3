/* ----------------------------------------------------------------------------
Function: CBA_fnc_progressBar

Description:
    Opens a progress bar. Closes the currently active progress bar.

Parameters:
    _title      - Title of the progress bar <STRING>
    _condition  - Execute every frame. If reports false, close the progress bar <CODE>
    _totalTime  - Time for the progress bar to complete
    _onSuccess  - Script to execute if the progress bar completed <CODE>
    _onFailure  - Script to execute if the progress bar was aborted prematurely <CODE>
    _arguments  - Arguments passed to the scripts (optional, default: []) <ANY>
    _allowClose - Allow ESC key to abort the progress bar (optional, default: true) <BOOLEAN>
    _blockInput - true: block keyboard + mouse,
        false: block mouse, but only if _allowClose is true (optional, default: true) <BOOLEAN>

Arguments:
    _this:
        #0 - same as _arguments <ANY>
        #1 - true: success, false: failure <BOOLEAN>
        #2 - elapsed time, not more than _totalTime <NUMBER>
        #3 - total time, same as _totalTime <NUMBER>

Returns:
    Nothing

Examples:
    (begin example)
        ["progress bar", {true}, 5, {hint "done"}, {hint "aborted"}] call CBA_fnc_progressBar;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

if (!hasInterface) exitWith {};

if (canSuspend) exitWith {
    [CBA_fnc_progressBar, _this] call CBA_fnc_directCall;
};

params [
    ["_title", "", [""]],
    ["_condition", {}, [{}, ""]],
    ["_totalTime", 0, [0]],
    ["_onSuccess", {}, [{}, ""]],
    ["_onFailure", {}, [{}, ""]],
    ["_arguments", []],
    ["_allowClose", true, [false]],
    ["_blockInput", true, [false]]
];

if (isLocalized _title) then {
    _title = localize _title;
};

if (_condition isEqualType "") then {
    _condition = compile _condition;
};

if (_onSuccess isEqualType "") then {
    _onSuccess = compile _onSuccess;
};

if (_onFailure isEqualType "") then {
    _onFailure = compile _onFailure;
};

private _display = uiNamespace getVariable [QGVAR(ProgressBar), displayNull];

if (!isNull _display) then {
    // run failure code on previous progress bar
    private _arguments = _display getVariable QGVAR(arguments);
    private _onFailure = _display getVariable QGVAR(onFailure);

    private _startTime = _display getVariable QGVAR(startTime);
    private _totalTime = _display getVariable QGVAR(totalTime);
    private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

    _display closeDisplay 0;
    [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
};

// create new progress bar
private _blockMouse = _blockInput || _allowClose;

if (_blockMouse) then {
    _display = (uiNamespace getVariable "RscDisplayMission") createDisplay QGVAR(ProgressBar);

    _display displayAddEventHandler ["KeyDown", {
        params ["_display", "_key", "_shift", "_control", "_alt"];

        private _arguments = _display getVariable QGVAR(arguments);
        private _onFailure = _display getVariable QGVAR(onFailure);
        private _allowClose = _display getVariable QGVAR(allowClose);
        private _blockInput = _display getVariable QGVAR(blockInput);

        if (_allowClose && {_key isEqualTo DIK_ESCAPE}) then {
            private _startTime = _display getVariable QGVAR(startTime);
            private _totalTime = _display getVariable QGVAR(totalTime);
            private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

            _display closeDisplay 0;
            [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;

            _blockInput = true;
        };

        _blockInput
    }];
} else {
    QGVAR(ProgressBar) cutRsc [QGVAR(ProgressBar), "PLAIN"];
    _display = uiNamespace getVariable QGVAR(ProgressBar);
};

private _fnc_check = {
    private _display = uiNamespace getVariable [QGVAR(ProgressBar), displayNull];

    if (isNull _display) exitWith {
        removeMissionEventHandler ["Draw3D", _thisEventHandler];
    };

    private _arguments = _display getVariable QGVAR(arguments);
    private _condition = _display getVariable QGVAR(condition);

    private _startTime = _display getVariable QGVAR(startTime);
    private _totalTime = _display getVariable QGVAR(totalTime);
    private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

    private _continue = [[_arguments, true, _elapsedTime, _totalTime], _condition] call {
        private ["_display", "_arguments", "_condition", "_startTime", "_totalTime", "_elapsedTime"];
        _this#0 call _this#1;
    };

    private _onSuccess = _display getVariable QGVAR(onSuccess);
    private _onFailure = _display getVariable QGVAR(onFailure);

    if (!_continue) exitWith {
        _display closeDisplay 0;
        [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
    };

    if (_elapsedTime >= _totalTime) exitWith {
        _display closeDisplay 0;
        [_onSuccess, [_arguments, true, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
    };

    private _ctrlBar = _display displayCtrl IDC_PROGRESSBAR_BAR;
    _ctrlBar progressSetPosition (_elapsedTime / _totalTime);
};

if (_blockMouse) then {
    _display displayAddEventHandler ["MouseMoving", _fnc_check];
    _display displayAddEventHandler ["MouseHolding", _fnc_check];
} else {
    addMissionEventHandler ["Draw3D", _fnc_check];
};

private _ctrlTitle = _display displayCtrl IDC_PROGRESSBAR_TITLE;
_ctrlTitle ctrlSetText _title;

_display setVariable [QGVAR(startTime), CBA_missionTime];
_display setVariable [QGVAR(totalTime), _totalTime];
_display setVariable [QGVAR(arguments), _arguments];
_display setVariable [QGVAR(condition), _condition];
_display setVariable [QGVAR(onSuccess), _onSuccess];
_display setVariable [QGVAR(onFailure), _onFailure];
_display setVariable [QGVAR(allowClose), _allowClose];
_display setVariable [QGVAR(blockInput), _blockInput];
