#include "script_component.hpp"

// get button
params ["_control"];

// get dialog
private _display = ctrlParent _control;

private _ctrlGeneralGroup = _display displayCtrl 2300;
private _ctrlColorsGroup = _display displayCtrl 2301;
private _ctrlDifficultyGroup = _display displayCtrl 2302;

private _ctrlDifficultyButton = _display displayCtrl 304;
private _ctrlGeneralButton = _display displayCtrl 2402;
private _ctrlGUIButton = _display displayCtrl 2404;
private _ctrlLayoutButton = _display displayCtrl 2405;
private _ctrlTitle = _display displayCtrl 1000;
private _ctrlPresetsButton = _display displayCtrl 114;
private _ctrlDefaultButton = _display displayCtrl 101;

private _ctrlAddonsGroup = _display displayCtrl IDC_ADDONS_GROUP;
private _ctrlToggleButton = _display displayCtrl IDC_BTN_CONFIGURE_ADDONS;
private _ctrlClientButton = _display displayCtrl IDC_BTN_CLIENT;
private _ctrlServerButton = _display displayCtrl IDC_BTN_SERVER;
private _ctrlMissionButton = _display displayCtrl IDC_BTN_MISSION;
private _ctrlButtonImport = _display displayCtrl IDC_BTN_IMPORT;
private _ctrlButtonExport = _display displayCtrl IDC_BTN_EXPORT;
private _ctrlButtonSave = _display displayCtrl IDC_BTN_SAVE;
private _ctrlButtonLoad = _display displayCtrl IDC_BTN_LOAD;

// Toggle displayed groups and buttons.
if !(ctrlShown _ctrlAddonsGroup) then {
    //--- disable and hide default menu
    _ctrlGeneralGroup ctrlEnable false;
    _ctrlGeneralGroup ctrlShow false;
    _ctrlColorsGroup ctrlEnable false;
    _ctrlColorsGroup ctrlShow false;
    _ctrlDifficultyGroup ctrlEnable false;
    _ctrlDifficultyGroup ctrlShow false;
    _ctrlPresetsButton ctrlEnable false;
    _ctrlPresetsButton ctrlShow false;
    _ctrlDefaultButton ctrlEnable false;
    _ctrlDefaultButton ctrlShow false;
    _ctrlDifficultyButton ctrlEnable false;
    _ctrlDifficultyButton ctrlShow false;
    _ctrlGeneralButton ctrlEnable false;
    _ctrlGeneralButton ctrlShow false;
    _ctrlGUIButton ctrlEnable false;
    _ctrlGUIButton ctrlShow false;
    _ctrlLayoutButton ctrlEnable false;
    _ctrlLayoutButton ctrlShow false;

    //--- show and enable custom buttons
    _ctrlAddonsGroup ctrlEnable true;
    _ctrlAddonsGroup ctrlShow true;
    _ctrlClientButton ctrlEnable CAN_VIEW_CLIENT_SETTINGS;
    _ctrlClientButton ctrlShow true;
    _ctrlServerButton ctrlEnable CAN_VIEW_SERVER_SETTINGS;
    _ctrlServerButton ctrlShow true;
    _ctrlMissionButton ctrlEnable CAN_VIEW_MISSION_SETTINGS;
    _ctrlMissionButton ctrlShow true;
    _ctrlButtonImport ctrlEnable true;
    _ctrlButtonImport ctrlShow true;
    _ctrlButtonExport ctrlEnable true;
    _ctrlButtonExport ctrlShow true;
    _ctrlButtonSave ctrlEnable true;
    _ctrlButtonSave ctrlShow true;
    _ctrlButtonLoad ctrlEnable true;
    _ctrlButtonLoad ctrlShow true;

    //--- change button text
    _ctrlToggleButton ctrlSetText localize LSTRING(configureBase);

    //--- emulate default scope selection
    ([
        _ctrlClientButton, _ctrlServerButton, _ctrlMissionButton
    ] param [[
        CAN_VIEW_CLIENT_SETTINGS, CAN_VIEW_SERVER_SETTINGS, CAN_VIEW_MISSION_SETTINGS
    ] find true]) call FUNC(gui_sourceChanged);
} else {
    //--- enable and show default menu
    _ctrlGeneralGroup ctrlEnable true;
    _ctrlGeneralGroup ctrlShow true;
    _ctrlColorsGroup ctrlEnable false;
    _ctrlColorsGroup ctrlShow false;
    _ctrlDifficultyGroup ctrlEnable false;
    _ctrlDifficultyGroup ctrlShow false;
    _ctrlPresetsButton ctrlEnable true;
    _ctrlPresetsButton ctrlShow true;
    _ctrlDefaultButton ctrlEnable false;
    _ctrlDefaultButton ctrlShow false;
    _ctrlDifficultyButton ctrlEnable true;
    _ctrlDifficultyButton ctrlShow true;
    _ctrlGeneralButton ctrlEnable true;
    _ctrlGeneralButton ctrlShow true;
    _ctrlGUIButton ctrlEnable true;
    _ctrlGUIButton ctrlShow true;
    _ctrlLayoutButton ctrlEnable true;
    _ctrlLayoutButton ctrlShow true;

    //--- hide and disable custom buttons
    _ctrlAddonsGroup ctrlEnable false;
    _ctrlAddonsGroup ctrlShow false;
    _ctrlClientButton ctrlEnable false;
    _ctrlClientButton ctrlShow false;
    _ctrlServerButton ctrlEnable false;
    _ctrlServerButton ctrlShow false;
    _ctrlMissionButton ctrlEnable false;
    _ctrlMissionButton ctrlShow false;
    _ctrlButtonImport ctrlEnable false;
    _ctrlButtonImport ctrlShow false;
    _ctrlButtonExport ctrlEnable false;
    _ctrlButtonExport ctrlShow false;
    _ctrlButtonSave ctrlEnable false;
    _ctrlButtonSave ctrlShow false;
    _ctrlButtonLoad ctrlEnable false;
    _ctrlButtonLoad ctrlShow false;

    //--- change button text
    _ctrlToggleButton ctrlSetText localize LSTRING(configureAddons);
};
