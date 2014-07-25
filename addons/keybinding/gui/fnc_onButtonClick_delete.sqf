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

// Get handler tracker index array for keys stored in listbox data string
_handlerIndexArray = call compile (_lnb lnbData [_lnbIndex, 0]);

// Get entry from handler tracker array
_handlerTracker = GVAR(handlers);

{
	// Get the keyconfig from the tracker based on the indexes
	_keyConfig = _handlerTracker select _x;

	// Something must be selected.
	if (!isNil "_keyConfig") then {
		_modName = _keyConfig select 0;
		_actionName = _keyConfig select 1;
		_oldKeyData = _keyConfig select 2;
		_functionName = _keyConfig select 3;
		//_oldEhID = _keyConfig select 4;
		_keypressType = _keyConfig select 5;

		// Blank the keybind.
		_keybind = [-1, false, false, false];

		// Re-register the handler with default keybind.
		[_modName, _actionName, _functionName, _keybind, true, _keypressType] call cba_fnc_registerKeybind;
	};
} forEach _handlerIndexArray;

// Clear any input actions.
GVAR(waitingForInput) = false;

// Update the main dialog.
[] call FUNC(updateGUI);