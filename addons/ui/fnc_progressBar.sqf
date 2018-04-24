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

// show progress bar with new title
private _control = uiNamespace getVariable [QGVAR(ProgressBar), controlNull];
_control ctrlShow true;

private _ctrlTitle = _control controlsGroupCtrl IDC_PROGRESSBAR_TITLE;
_ctrlTitle ctrlSetText _title;

if (isNil QGVAR(ProgressBarParams)) then {
    // update progress bar, run condition
    addMissionEventHandler ["EachFrame", {
        private _control = uiNamespace getVariable [QGVAR(ProgressBar), controlNull];

        GVAR(ProgressBarParams) params ["_arguments", "_condition", "_onSuccess", "_onFailure", "_startTime", "_totalTime"];
        private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

        private _continue = [[_arguments, true, _elapsedTime, _totalTime], _condition] call {
            private ["_control", "_arguments", "_condition", "_onSuccess", "_onFailure", "_startTime", "_totalTime", "_elapsedTime"];
            _this#0 call _this#1;
        };

        if (!_continue) exitWith {
            removeMissionEventHandler ["EachFrame", _thisEventHandler];
            GVAR(ProgressBarParams) = nil;
            _control ctrlShow false;
            [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
        };

        if (_elapsedTime >= _totalTime) exitWith {
            removeMissionEventHandler ["EachFrame", _thisEventHandler];
            GVAR(ProgressBarParams) = nil;
            _control ctrlShow false;
            [_onSuccess, [_arguments, true, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
        };

        private _ctrlBar = _control controlsGroupCtrl IDC_PROGRESSBAR_BAR;
        _ctrlBar progressSetPosition (_elapsedTime / _totalTime);
    }];
} else {
    // run failure code on previous progress bar
    GVAR(ProgressBarParams) params ["_arguments", "", "", "_onFailure", "_startTime", "_totalTime"];
    private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

    [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
};

GVAR(ProgressBarParams) = [_arguments, _condition, _onSuccess, _onFailure, CBA_missionTime, _totalTime, _blockMouse, _blockKeys, _allowClose];

// create empty display to block input
if (_blockMouse) then {
    private _blockInputDisplay = ctrlParent _control createDisplay "RscDisplayEmpty";

    _blockInputDisplay displayAddEventHandler ["KeyDown", {
        params ["", "_key", "_shift", "_control", "_alt"];
        private _control = uiNamespace getVariable QGVAR(ProgressBar);

        GVAR(ProgressBarParams) params ["", "", "", "", "", "", "_blockMouse", "_blockKeys", "_allowClose"];
        private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

        if (_key isEqualTo DIK_ESCAPE) then {
            if (_allowClose) then {
                // let progressbar handler fail next frame
                GVAR(ProgressBarParams) set [1, {false}];
                _blockKeys = true;
            } else {
                _blockKeys = false;
            };
        };

        _blockKeys
    }];
};
