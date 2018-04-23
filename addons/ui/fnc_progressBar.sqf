/* ----------------------------------------------------------------------------
Function: CBA_fnc_progressBar

Description:
    Opens a progress bar. Closes the currently active progress bar.

Parameters:
    _title      - Title of the progress bar <STRING>
    _totalTime  - Time for the progress bar to complete <NUMBER>
    _condition  - Execute every frame. If reports false, close the progress bar <CODE>
    _onSuccess  - Script to execute if the progress bar completed <CODE>
    _onFailure  - Script to execute if the progress bar was aborted prematurely
        (optional, default: {}) <CODE>
    _arguments  - Arguments passed to the scripts (optional, default: []) <ANY>
    _blockMouse - Block mouse input (optional, default: true) <BOOLEAN>
    _blockKeys  - Block keyboard input
        requires _blockMouse to be set to true (optional, default: true) <BOOLEAN>
    _allowClose - Allow ESC key to abort the progress bar
        requires _blockMouse to be set to true (optional, default: true) <BOOLEAN>

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
        ["progress bar", 5, {true}, {hint "done"}, {hint "aborted"}] call CBA_fnc_progressBar;
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
    ["_totalTime", 0, [0]],
    ["_condition", {}, [{}, ""]],
    ["_onSuccess", {}, [{}, ""]],
    ["_onFailure", {}, [{}, ""]],
    ["_arguments", []],
    ["_blockMouse", true, [false]],
    ["_blockKeys", true, [false]],
    ["_allowClose", true, [false]]
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

private _display = uiNamespace getVariable "RscDisplayMission";
private _control = uiNamespace getVariable [QGVAR(ProgressBar), controlNull];

if (!isNull _control) then {
    // run failure code on previous progress bar
    private _arguments = _control getVariable QGVAR(arguments);
    private _onFailure = _control getVariable QGVAR(onFailure);

    private _startTime = _control getVariable QGVAR(startTime);
    private _totalTime = _control getVariable QGVAR(totalTime);
    private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

    CLOSE(_control);
    [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
};

// create new progress bar
if (_blockMouse) then {
    private _progressBar = _display createDisplay QGVAR(ProgressBarDisplay);

    _progressBar displayAddEventHandler ["KeyDown", {
        params ["", "_key", "_shift", "_control", "_alt"];
        private _control = uiNamespace getVariable QGVAR(ProgressBar);

        private _arguments = _control getVariable QGVAR(arguments);
        private _onFailure = _control getVariable QGVAR(onFailure);
        private _allowClose = _control getVariable QGVAR(allowClose);
        private _blockKeys = _control getVariable QGVAR(blockKeys);

        if (_allowClose && {_key isEqualTo DIK_ESCAPE}) then {
            private _startTime = _control getVariable QGVAR(startTime);
            private _totalTime = _control getVariable QGVAR(totalTime);
            private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

            CLOSE(_control);
            [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;

            _blockKeys = true;
        };

        _blockKeys
    }];
} else {
    _display ctrlCreate [QGVAR(ProgressBar), -1];
};

_control = uiNamespace getVariable QGVAR(ProgressBar);

_control setVariable [QGVAR(EachFrame), {
    private _control = uiNamespace getVariable [QGVAR(ProgressBar), controlNull];

    private _arguments = _control getVariable QGVAR(arguments);
    private _condition = _control getVariable QGVAR(condition);

    private _startTime = _control getVariable QGVAR(startTime);
    private _totalTime = _control getVariable QGVAR(totalTime);
    private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

    private _continue = [[_arguments, true, _elapsedTime, _totalTime], _condition] call {
        private ["_control", "_arguments", "_condition", "_startTime", "_totalTime", "_elapsedTime"];
        _this#0 call _this#1;
    };

    private _onSuccess = _control getVariable QGVAR(onSuccess);
    private _onFailure = _control getVariable QGVAR(onFailure);

    if (!_continue) exitWith {
        CLOSE(_control);
        [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
    };

    if (_elapsedTime >= _totalTime) exitWith {
        CLOSE(_control);
        [_onSuccess, [_arguments, true, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
    };

    private _ctrlBar = _control controlsGroupCtrl IDC_PROGRESSBAR_BAR;
    _ctrlBar progressSetPosition (_elapsedTime / _totalTime);
}];

private _ctrlTitle = _control controlsGroupCtrl IDC_PROGRESSBAR_TITLE;
_ctrlTitle ctrlSetText _title;

_control setVariable [QGVAR(startTime), CBA_missionTime];
_control setVariable [QGVAR(totalTime), _totalTime];
_control setVariable [QGVAR(arguments), _arguments];
_control setVariable [QGVAR(condition), _condition];
_control setVariable [QGVAR(onSuccess), _onSuccess];
_control setVariable [QGVAR(onFailure), _onFailure];
_control setVariable [QGVAR(allowClose), _allowClose];
_control setVariable [QGVAR(blockKeys), _blockKeys];
