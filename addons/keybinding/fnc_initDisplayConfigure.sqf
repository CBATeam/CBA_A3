#include "script_component.hpp"

params ["_display"];
uiNamespace setVariable [QGVAR(display), _display];

private _ctrlAddonsGroup = _display displayCtrl IDC_ADDONS_GROUP;

_ctrlAddonsGroup ctrlShow false;
_ctrlAddonsGroup ctrlEnable false;

// Hide addons group on display init.
private _ctrlKeyboardButtonFake = _display displayCtrl IDC_BTN_KEYBOARD_FAKE;

// Always highlight fake button
_ctrlKeyboardButtonFake ctrlSetTextColor [0, 0, 0, 1];
_ctrlKeyboardButtonFake ctrlSetBackgroundColor [1, 1, 1, 1];

_ctrlKeyboardButtonFake ctrlShow false;
_ctrlKeyboardButtonFake ctrlEnable false;

// ----- disable in main menu
if (isNil QUOTE(ADDON)) exitWith {
    private _ctrlToggleButton = _display displayCtrl IDC_BTN_CONFIGURE_ADDONS;

    _ctrlToggleButton ctrlEnable false;
};

// ----- fill addon combo box
private _ctrlAddonList = _display displayCtrl IDC_ADDON_LIST;

{
    private _addonInfo = GVAR(addons) getVariable _x;
    private _addonName = GVAR(modPrettyNames) getVariable [_x, _addonInfo select 0];

    _ctrlAddonList lbSetData [_ctrlAddonList lbAdd _addonName, _x];
} forEach allVariables GVAR(addons);

lbSort _ctrlAddonList;

_ctrlAddonList lbSetCurSel (uiNamespace getVariable [QGVAR(addonIndex), 0]);
_ctrlAddonList ctrlAddEventHandler ["LBSelChanged", {_this call (uiNamespace getVariable QFUNC(gui_update))}];

private _ctrlKeyList = _display displayCtrl IDC_KEY_LIST;

_ctrlKeyList ctrlSetTooltipColorShade [0, 0, 0, 0.5];
_ctrlKeyList ctrlAddEventHandler ["LBSelChanged", {_this call (uiNamespace getVariable QFUNC(gui_editKey))}];

// ----- namespace for temp changed keybinds
uiNamespace setVariable [QGVAR(tempKeybinds), _display ctrlCreate ["RscText", -1]];

// ----- save changes
private _ctrlButtonOK = _display displayCtrl IDC_OK;

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {
    private _registry = profileNamespace getVariable QGVAR(registry_v3);
    private _tempNamespace = uiNamespace getVariable QGVAR(tempKeybinds);
    private _changedActions = allVariables GVAR(actions) select {!isNil {_tempNamespace getVariable _x}};

    {
        private _action = toLower _x;
        private _keybinds = _tempNamespace getVariable _action;

        (GVAR(actions) getVariable _action) params ["", "", "_oldKeybinds", "", "_downCode", "_upCode", "_holdKey", "_holdDelay"];
        (GVAR(actions) getVariable _action) set [2, _keybinds];

        // overwrite with new keyhandlers
        {
            _keybind = _x;

            if !(_downCode isEqualTo {}) then {
                [_keybind select 0, _keybind select 1, _downCode, "keyDown", format ["%1_down_%2", _action, _forEachIndex], _holdKey, _holdDelay] call CBA_fnc_addKeyHandler;
            };

            if !(_upCode isEqualTo {}) then {
                [_keybind select 0, _keybind select 1, _upCode, "keyUp", format ["%1_up_%2", _action, _forEachIndex]] call CBA_fnc_addKeyHandler;
            };
        } forEach _keybinds;

        // remove no longer used keyhandlers
        for "_index" from (count _keybinds) to (count _oldKeybinds - 1) do {
            [format ["%1_down_%2", _action, _index], "keydown"] call CBA_fnc_removeKeyHandler;
            [format ["%1_up_%2", _action, _index], "keyup"] call CBA_fnc_removeKeyHandler;
        };

        // save in profile
        [_registry, _action, _keybinds] call CBA_fnc_hashSet;
    } forEach _changedActions;
}];

// ----- update gui
[] call FUNC(gui_update);
