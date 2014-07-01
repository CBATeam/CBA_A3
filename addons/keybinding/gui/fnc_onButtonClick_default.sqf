#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

// Get button
_button = _this select 0;
// Get dialog
_display = uiNamespace getVariable "RscDisplayConfigure";

// Get listnbox
_lnb = _display displayCtrl 202;
// Get currently selected index
_lnbIndex = lnbCurSelRow _lnb;

// Get handler tracker index for key stored in listbox
_handlerIndex = parseNumber (_lnb lnbData [_lnbIndex, 0]);

// Get entry from handler tracker array
_handlerTracker = GVAR(handlers);
_keyConfig = _handlerTracker select _handlerIndex;
_modName = _keyConfig select 0;
_actionName = _keyConfig select 1;
_oldKeyData = _keyConfig select 2;
_functionName = _keyConfig select 3;

// Get a local copy of the keybind registry.
_registry = profileNamespace getVariable [QGVAR(registry), []];

// Get array of the mod's keybinds from the registry.
_modKeybinds = [_registry, _modName] call bis_fnc_getFromPairs;

// Get the existing keypress data for the action.
_keybindData = [_modKeybinds, _actionName] call bis_fnc_getFromPairs;
// Need the default bind.
_defaultKeybind = _keybindData select 1;

// Re-register the handler with default keybind.
[_modName, _actionName, _functionName, _defaultKeybind, true] call cba_fnc_registerKeybind;

// Clear any input actions.
GVAR(waitingForInput) = false;

// Update the main dialog.
[] call FUNC(updateGUI);