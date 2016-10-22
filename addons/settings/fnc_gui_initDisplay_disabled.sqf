#include "script_component.hpp"

params ["_display"];

private _ctrlAddonsGroup = _display displayCtrl IDC_ADDONS_GROUP;
private _ctrlToggleButton = _display displayCtrl IDC_BTN_CONFIGURE_ADDONS;
private _ctrlServerButton = _display displayCtrl IDC_BTN_SERVER;
private _ctrlClientButton = _display displayCtrl IDC_BTN_CLIENT;
private _ctrlMissionButton = _display displayCtrl IDC_BTN_MISSION;

_ctrlToggleButton ctrlEnable false;

{
    _x ctrlEnable false;
    _x ctrlShow false;
} forEach [_ctrlAddonsGroup, _ctrlServerButton, _ctrlClientButton, _ctrlMissionButton];
