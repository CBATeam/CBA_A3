#include "script_component.hpp"

// get button
params ["_control"];

// get dialog
private _display = ctrlParent _control;

private _selectedSource = ["client", "server", "mission"] param [[IDC_BTN_CLIENT, IDC_BTN_SERVER, IDC_BTN_MISSION] find ctrlIDC _control];

uiNamespace setVariable [QGVAR(source), _selectedSource];

private _selectedAddon = uiNamespace getVariable QGVAR(addon);

// toggle lists
{
    (_x splitString "$") params ["", "_addon", "_source"];

    private _ctrlOptionsGroup = _display getVariable _x;
    private _isSelected = _source == _selectedSource && {_addon == _selectedAddon};

    _ctrlOptionsGroup ctrlEnable _isSelected;
    _ctrlOptionsGroup ctrlShow _isSelected;
} forEach (_display getVariable QGVAR(lists));

// toggle source buttons
{
    private _ctrlX = _display displayCtrl _x;
    _ctrlX ctrlSetTextColor ([COLOR_BUTTON_ENABLED, COLOR_BUTTON_DISABLED] select (_control == _ctrlX));
    _ctrlX ctrlSetBackgroundColor ([COLOR_BUTTON_DISABLED, COLOR_BUTTON_ENABLED] select (_control == _ctrlX));
} forEach [IDC_BTN_CLIENT, IDC_BTN_SERVER, IDC_BTN_MISSION];

(_display displayCtrl IDC_TXT_FORCE) ctrlShow (_selectedSource != "client");

// enable / disable IMPORT and LOAD buttons
private _ctrlButtonImport = _display displayCtrl IDC_BTN_IMPORT;
private _ctrlButtonLoad = _display displayCtrl IDC_BTN_LOAD;

private _enabled = switch (_selectedSource) do {
    case ("client"): {
        CAN_SET_CLIENT_SETTINGS
    };
    case ("server"): {
        CAN_SET_SERVER_SETTINGS
    };
    case ("mission"): {
        CAN_SET_MISSION_SETTINGS
    };
};

_ctrlButtonImport ctrlEnable _enabled;
_ctrlButtonLoad ctrlEnable _enabled;
