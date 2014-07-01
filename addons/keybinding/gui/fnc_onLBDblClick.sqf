#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_display = uiNamespace getVariable "RscDisplayConfigure";

// Get listnbox
_lnb = _display displayCtrl 202;
// Get currently selected index
_lnbIndex = lnbCurSelRow _lnb;
// Get combobox
_combo = _display displayCtrl 208;
// Get the mod selected in the comobo
_comboMod = _combo lbText (lbCurSel _combo);

// Don't allow multiple keys to be changed at once.
if (GVAR(waitingForInput)) exitWith {};

// Get handler tracker index for key stored in listbox
_handlerIndex = parseNumber (_lnb lnbData [_lnbIndex, 0]);

// Get entry from handler tracker array
_handlerTracker = GVAR(handlers);
_keyConfig = _handlerTracker select _handlerIndex;
_modName = _keyConfig select 0;
_actionName = _keyConfig select 1;
_oldKeyData = _keyConfig select 2;
_functionName = _keyConfig select 3;

// Clear keypress data.
GVAR(input) = [];

// Mark that we're waiting so that onKeyDown handler blocks input (Esc key)
GVAR(waitingForInput) = true;

// Update box content to indicate that we're waiting for input.
_lnb lnbSetText [[_lnbIndex, 1], "Press key or Esc to cancel"];
_lnb lnbSetColor [[_lnbIndex, 1], [1,0,0,1]];

// Wait for input, selection, or mod change.
waitUntil {count GVAR(input) > 0 || !GVAR(waitingForInput) || lnbCurSelRow _lnb != _lnbIndex || _comboMod != (_combo lbText (lbCurSel _combo))};

if (GVAR(waitingForInput)) then {
	// Tell the onKeyDown handler that we're not waiting anymore, so it stops blocking input.
	GVAR(waitingForInput) = false;

	if (!isNull _display) then { // Make sure user hasn't exited dialog before continuing.
		// Get stored keypress data.
		_keyPressData = GVAR(input);

		// If a valid key other than Escape was pressed,
		if (_keyPressData select 0 != 1) then {
			// Re-register the handler, overwriting old keypressdata.
			[_modName, _actionName, _functionName, _keyPressData, true] call cba_fnc_registerKeybind;
		};

		// Update the main dialog.
		[] call FUNC(updateGUI);
	};
};



