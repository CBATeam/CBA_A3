#include "script_component.hpp"
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

// no progress bar without interface
if (!hasInterface) exitWith {};

// execute in unscheduled environment
if (canSuspend) exitWith {
    [CBA_fnc_progressBar, _this] call CBA_fnc_directCall;
};

// arguments
params [
    ["_title", "", [""]],
    ["_totalTime", 0, [0]],
    ["_condition", {}, [{true}]],
    ["_onSuccess", {}, [{}]],
    ["_onFailure", {}, [{}]],
    ["_arguments", []],
    ["_blockMouse", true, [false]],
    ["_blockKeys", true, [false]],
    ["_allowClose", true, [false]]
];

if (isLocalized _title) then {
    _title = localize _title;
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

// update bar, check condition, execute success or failure scripts
private _ctrlScript = _display displayCtrl IDC_PROGRESSBAR_SCRIPT;
_ctrlScript ctrlAddEventHandler ["Draw", {
    params ["_ctrlScript"];
    private _display = ctrlParent _ctrlScript;

    GVAR(ProgressBarParams) params ["_arguments", "_condition", "_onSuccess", "_onFailure", "_startTime", "_totalTime"];
    private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

    private _continue = [[_arguments, true, _elapsedTime, _totalTime], _condition] call {
        // prevent these variables from being overwritten
        private ["_ctrlScript", "_display", "_arguments", "_condition", "_onSuccess", "_onFailure", "_startTime", "_totalTime", "_elapsedTime"];
        _this#0 call _this#1;
    };

    private _blockInputDisplay = uiNamespace getVariable [QGVAR(BlockInputDisplay), displayNull];

    if (!_continue) exitWith {
        GVAR(ProgressBarParams) = nil;
        {QGVAR(ProgressBar) cutText ["", "PLAIN"]} call CBA_fnc_execNextFrame; // game would crash if display is killed from Draw event
        _blockInputDisplay closeDisplay 0;
        [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
    };

    if (_elapsedTime >= _totalTime) exitWith {
        GVAR(ProgressBarParams) = nil;
        {QGVAR(ProgressBar) cutText ["", "PLAIN"]} call CBA_fnc_execNextFrame; // game would crash if display is killed from Draw event
        _blockInputDisplay closeDisplay 0;
        [_onSuccess, [_arguments, true, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
    };

    private _ctrlBar = _display displayCtrl IDC_PROGRESSBAR_BAR;
    _ctrlBar progressSetPosition (_elapsedTime / _totalTime);
}];

// block input while the bar is shown
private _blockInputDisplay = uiNamespace getVariable [QGVAR(BlockInputDisplay), displayNull];
_blockInputDisplay closeDisplay 0;

if (_blockMouse) then {
    private _mission = uiNamespace getVariable "RscDisplayMission";
    _blockInputDisplay = _mission createDisplay "RscDisplayEmpty";
    uiNamespace setVariable [QGVAR(BlockInputDisplay), _blockInputDisplay];

    _blockInputDisplay displayAddEventHandler ["KeyDown", {
        params ["_blockInputDisplay", "_key", "_shift", "_control", "_alt"];

        GVAR(ProgressBarParams) params ["_arguments", "", "", "_onFailure", "_startTime", "_totalTime", "_blockMouse", "_blockKeys", "_allowClose"];
        private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

        if (_key isEqualTo DIK_ESCAPE) then {
            if (_allowClose) then {
                GVAR(ProgressBarParams) = nil;
                QGVAR(ProgressBar) cutText ["", "PLAIN"];
                _blockInputDisplay closeDisplay 0;
                [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;

                _blockKeys = false;
            } else {
                _blockKeys = true;
            };
        };

        _blockKeys
    }];
};

nil
