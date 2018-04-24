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

// show progress bar and set title
QGVAR(ProgressBar) cutRsc [QGVAR(ProgressBar), "PLAIN"];
private _display = uiNamespace getVariable QGVAR(ProgressBar);

private _ctrlTitle = _display displayCtrl IDC_PROGRESSBAR_TITLE;
_ctrlTitle ctrlSetText _title;

// run failure code on previous progress bar
if (!isNil QGVAR(ProgressBarParams)) then {
    GVAR(ProgressBarParams) params ["_arguments", "", "", "_onFailure", "_startTime", "_totalTime"];
    private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

    [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
};

GVAR(ProgressBarParams) = [_arguments, _condition, _onSuccess, _onFailure, CBA_missionTime, _totalTime, _blockMouse, _blockKeys, _allowClose];

nil
