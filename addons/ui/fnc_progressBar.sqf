/* ----------------------------------------------------------------------------
Function: CBA_fnc_progressBar

Description:
    Opens a progress bar. Closes the currently active progress bar.

Parameters:
    _title      - Title of the progress bar <STRING>
    _condition  - Execute every frame. If reports false, close the progress bar <CODE>
    _time       - Time for the progress bar to complete
    _onSuccess  - Script to execute if the progress bar completed <CODE>
    _onFailure  - Script to execute if the progress bar was aborted prematurely <CODE>
    _arguments  - Arguments passed to the scripts (optional, default: []) <ANY>
    _allowClose - Allow ESC key to abort the progress bar (optional, default: true) <BOOLEAN>
    _blockInput - (optional, default: true) <BOOLEAN>

Arguments:
    _this - same as _arguments <ANY>

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
    isNil (uiNamespace getVariable _fnc_scriptName);
    nil;
};

params [
    ["_title", "", [""]],
    ["_condition", {}, [{}, ""]],
    ["_time", 0, [0]],
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

    // close display, execute on failure script
    _display closeDisplay 0;

    [_arguments, _onFailure] spawn {
        isNil {
            _this#0 call _this#1;
        };
    };
};

// create new progress bar
if (_blockInput) then {
    _display = (uiNamespace getVariable "RscDisplayMission") createDisplay QGVAR(ProgressBar);
} else {
    QGVAR(ProgressBar) cutRsc [QGVAR(ProgressBar), "PLAIN"];
    _display = uiNamespace getVariable QGVAR(ProgressBar);
};

_display displayAddEventHandler ["KeyDown", {
    params ["_display", "_key", "_shift", "_control", "_alt"];

    private _arguments = _display getVariable QGVAR(arguments);
    private _onFailure = _display getVariable QGVAR(onFailure);
    private _allowClose = _display getVariable QGVAR(allowClose);
    private _blockInput = _display getVariable QGVAR(blockInput);

    if (_allowClose && {_key isEqualTo DIK_ESCAPE}) then {
        // close display, execute on failure script
        _display closeDisplay 0;

        [_arguments, _onFailure] spawn {
            isNil {
                _this#0 call _this#1;
            };
        };

        _blockInput = true;
    };

    _blockInput
}];

private _fnc_check = {
    params ["_display"];

    private _arguments = _display getVariable QGVAR(arguments);
    private _condition = _display getVariable QGVAR(condition);

    private _continue = [_arguments, _condition] call {
        private ["_display", "_arguments", "_condition"];
        _this#0 call _this#1;
    };

    private _onSuccess = _display getVariable QGVAR(onSuccess);
    private _onFailure = _display getVariable QGVAR(onFailure);

    if (!_continue) exitWith {
        // close display, execute on failure script
        _display closeDisplay 0;

        [_arguments, _onFailure] spawn {
            isNil {
                _this#0 call _this#1;
            };
        };
    };

    private _startTime = _display getVariable QGVAR(start);
    private _duration = _display getVariable QGVAR(duration);
    private _runTime = CBA_missionTime - _startTime;

    if (_runTime > _duration) exitWith {
        // close display, execute on success script
        _display closeDisplay 0;

        [_arguments, _onSuccess] spawn {
            isNil {
                _this#0 call _this#1;
            };
        };
    };

    private _ctrlBar = _display displayCtrl IDC_PROGRESSBAR_BAR;
    _ctrlBar progressSetPosition (_runTime / _duration);
};

_display displayAddEventHandler ["MouseMoving", _fnc_check];
_display displayAddEventHandler ["MouseHolding", _fnc_check];

private _ctrlTitle = _display displayCtrl IDC_PROGRESSBAR_TITLE;
_ctrlTitle ctrlSetText _title;

_display setVariable [QGVAR(start), CBA_missionTime];
_display setVariable [QGVAR(duration), _time];
_display setVariable [QGVAR(arguments), _arguments];
_display setVariable [QGVAR(condition), _condition];
_display setVariable [QGVAR(onSuccess), _onSuccess];
_display setVariable [QGVAR(onFailure), _onFailure];
_display setVariable [QGVAR(allowClose), _allowClose];
_display setVariable [QGVAR(blockInput), _blockInput];
