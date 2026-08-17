#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_ui_fnc_addMissionsButton

Description:
    Adds Missions button on Multiplayer Role Assignment screen.

Parameters:
    _display - RscDisplayMultiplayerSetup display <DISPLAY>

Returns:
    Nothing/Undefined.

Examples:
    (begin example)
        call cba_ui_fnc_addMissionsButton
    (end)

Author:
    Dystopian
---------------------------------------------------------------------------- */

params ["_display"];

private _ctrlCancel = _display displayCtrl IDC_CANCEL;
if (isNull _ctrlCancel) exitWith {};

ctrlPosition _ctrlCancel params ["_cancelLeft", "_cancelTop", "_cancelWidth", "_cancelHeight"];

private _ctrlMissionsButton = _display ctrlCreate ["RscButtonMenu", IDC_RESTART];
_ctrlMissionsButton ctrlShow false;
_ctrlMissionsButton ctrlSetPosition [
    _cancelLeft + _cancelWidth + 0.1 * GUI_GRID_W,
    _cancelTop,
    _cancelWidth,
    _cancelHeight
];
_ctrlMissionsButton ctrlCommit 0;
_ctrlMissionsButton ctrlSetText localize "STR_DISP_MP_DS_MISSIONS";

_ctrlMissionsButton ctrlAddEventHandler ["ButtonClick", {serverCommand "#missions"}];

private _fnc_missionButtonControl = {
    params ["_display"];
    private _ctrlMissionsButton = _display displayCtrl IDC_RESTART;
    if (ctrlShown _ctrlMissionsButton) then {
        if (!serverCommandAvailable "#missions") then {_ctrlMissionsButton ctrlShow false};
    } else {
        if (serverCommandAvailable "#missions") then {_ctrlMissionsButton ctrlShow true};
    };
};
_display displayAddEventHandler ["MouseMoving", _fnc_missionButtonControl];
_display displayAddEventHandler ["MouseHolding", _fnc_missionButtonControl];
