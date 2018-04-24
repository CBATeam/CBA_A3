#include "script_component.hpp"

params ["_display"];
uiNamespace setVariable [QGVAR(ProgressBar), _display];

_display setVariable [QGVAR(script), {
    private _display = uiNamespace getVariable [QGVAR(ProgressBar), displayNull];

    GVAR(ProgressBarParams) params ["_arguments", "_condition", "_onSuccess", "_onFailure", "_startTime", "_totalTime", "_blockMouse"];
    private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

    // block mouse input
    private _mission = uiNamespace getVariable ["RscDisplayMission", displayNull];
    private _blockInputDisplay = _mission getVariable [QGVAR(BlockInputDisplay), displayNull];

    if (_blockMouse) then {
        if (isNull _blockInputDisplay) then {
            _blockInputDisplay = _mission createDisplay "RscDisplayEmpty";
            _mission setVariable [QGVAR(BlockInputDisplay), _blockInputDisplay];

            _blockInputDisplay displayAddEventHandler ["KeyDown", {
                params ["", "_key", "_shift", "_control", "_alt"];
                private _display = uiNamespace getVariable [QGVAR(ProgressBar), displayNull];

                GVAR(ProgressBarParams) params ["_arguments", "", "", "_onFailure", "_startTime", "_totalTime", "_blockMouse", "_blockKeys", "_allowClose"];
                private _elapsedTime = (CBA_missionTime - _startTime) min _totalTime;

                if (_key isEqualTo DIK_ESCAPE) then {
                    if (_allowClose) then {
                        // let progressbar handler fail next frame
                        GVAR(ProgressBarParams) = nil;
                        QGVAR(ProgressBar) cutText ["", "PLAIN"];
                        [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;

                        _blockKeys = true;
                    } else {
                        _blockKeys = false;
                    };
                };

                _blockKeys
            }];

            private _close = {
                params ["_blockInputDisplay"];
                private _display = uiNamespace getVariable [QGVAR(ProgressBar), displayNull];

                if (isNull _display) then {
                    _blockInputDisplay closeDisplay 0;
                };
            };

            _blockInputDisplay displayAddEventHandler ["MouseMoving", _close];
            _blockInputDisplay displayAddEventHandler ["MouseHolding", _close];
        };
    } else {
        if (!isNull _blockInputDisplay) then {
            _blockInputDisplay closeDisplay 0;
        };
    };

    // update bar, check condition, execute success or failure scripts
    private _continue = [[_arguments, true, _elapsedTime, _totalTime], _condition] call {
        private ["_display", "_arguments", "_condition", "_onSuccess", "_onFailure", "_startTime", "_totalTime", "_elapsedTime", "_blockMouse"];
        _this#0 call _this#1;
    };

    if (!_continue) exitWith {
        GVAR(ProgressBarParams) = nil;
        {QGVAR(ProgressBar) cutText ["", "PLAIN"]} call CBA_fnc_execNextFrame;
        [_onFailure, [_arguments, false, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
    };

    if (_elapsedTime >= _totalTime) exitWith {
        GVAR(ProgressBarParams) = nil;
        {QGVAR(ProgressBar) cutText ["", "PLAIN"]} call CBA_fnc_execNextFrame;
        [_onSuccess, [_arguments, true, _elapsedTime, _totalTime]] call CBA_fnc_execNextFrame;
    };

    private _ctrlBar = _display displayCtrl IDC_PROGRESSBAR_BAR;
    _ctrlBar progressSetPosition (_elapsedTime / _totalTime);
}];
