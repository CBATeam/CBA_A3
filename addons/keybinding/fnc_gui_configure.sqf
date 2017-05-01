#include "script_component.hpp"

// get button
params ["_control"];

// get dialog
private _display = ctrlParent _control;

_ctrlKeyboardGroup = _display displayCtrl 2300;
_ctrlMouseGroup = _display displayCtrl 2301;
_ctrlKeyboardButton = _display displayCtrl 2400;
_ctrlMouseButton = _display displayCtrl 2401;
_ctrlControllerButton = _display displayCtrl 106;
_ctrlPresetButton = _display displayCtrl 114;
_ctrlDefaultButton = _display displayCtrl 101;

_ctrlKeyboardButtonFake = _display displayCtrl IDC_BTN_KEYBOARD_FAKE;
_ctrlAddonsGroup = _display displayCtrl IDC_ADDONS_GROUP;
_ctrlToggleButton = _display displayCtrl IDC_BTN_CONFIGURE_ADDONS;

// Toggle displayed groups and buttons.
if !(ctrlShown _ctrlAddonsGroup) then {
    //--- disable and hide default menu
    _ctrlKeyboardGroup ctrlEnable false;
    _ctrlKeyboardGroup ctrlShow false;
    _ctrlMouseGroup ctrlEnable false;
    _ctrlMouseGroup ctrlShow false;
    _ctrlKeyboardButton ctrlEnable false;
    _ctrlKeyboardButton ctrlShow false;
    _ctrlMouseButton ctrlEnable false;
    _ctrlMouseButton ctrlShow false;
    _ctrlControllerButton ctrlEnable false;
    _ctrlControllerButton ctrlShow false;
    _ctrlPresetButton ctrlEnable false;
    _ctrlPresetButton ctrlShow false;
    _ctrlDefaultButton ctrlEnable false;
    _ctrlDefaultButton ctrlShow false;

    //--- show and enable custom buttons
    _ctrlKeyboardButtonFake ctrlEnable true;
    _ctrlKeyboardButtonFake ctrlShow true;
    _ctrlAddonsGroup ctrlEnable true;
    _ctrlAddonsGroup ctrlShow true;

    //--- change button text
    _ctrlToggleButton ctrlSetText localize LSTRING(configureBase);
} else {
    //--- enable and show default menu
    _ctrlKeyboardGroup ctrlEnable true;
    _ctrlKeyboardGroup ctrlShow true;
    _ctrlKeyboardButton ctrlEnable true;
    _ctrlKeyboardButton ctrlShow true;
    _ctrlMouseButton ctrlEnable true;
    _ctrlMouseButton ctrlShow true;
    _ctrlControllerButton ctrlEnable true;
    _ctrlControllerButton ctrlShow true;
    _ctrlPresetButton ctrlEnable true;
    _ctrlPresetButton ctrlShow true;

    //--- hide and disable custom buttons
    _ctrlKeyboardButtonFake ctrlEnable false;
    _ctrlKeyboardButtonFake ctrlShow false;
    _ctrlAddonsGroup ctrlEnable false;
    _ctrlAddonsGroup ctrlShow false;

    //--- change button text
    _ctrlToggleButton ctrlSetText localize LSTRING(configureAddons);
};
