#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_firstRun = false;
// Pass any parameter to the function for full initialization behavior.
if (count _this == 1) then {_firstRun = true};

_display = uiNamespace getVariable "RscDisplayConfigure";

if !(isNull _display) then {
	_combo = _display displayCtrl 208;
	_lnb = _display displayCtrl 202;
	
	// Get a local copy of the handler array.
	_handlerTracker = GVAR(handlers);

	// Parse the key handler tracker array.
	_comboMods = [];
	_keyDict = [];
	{
		// Format of handler tracker array: array of arrays like
		// ["modName", "actionName", keybind, "functionName", ehID]
		_modName = _x select 0;
		_actionName = _x select 1;
		_keybind = _x select 2;
		_functionName = _x select 3;
		_ehID = _x select 4;

		// Add all mods to the combo array.
		if !(_modName in _comboMods) then {
			_comboMods set [count _comboMods, _modName];
		};

		// Build a dict with entries like ["mod":[["action",index in handlers tracker array],["action2",index]]]
		[_keyDict, _modName, [[_actionName, _forEachIndex]]] call bis_fnc_addToPairs;
	} foreach _handlerTracker;

	// First run only actions.
	if (_firstRun) then {
		// Clear the combobox.
		lbClear _combo;

		if (count _comboMods > 0) then {
			// Populate the combolistbox.
			{_combo lbAdd _x} foreach _comboMods;
		};

		_combo lbSetCurSel 0;
	};

	// Fill the listnbox with actions.
	if (count _comboMods > 0) then {
		// Get the selected mod.
		_current = _comboMods select (lbCurSel _combo);
		// Get the actions associated with the current mod.
		_modActions = [_keyDict, _current] call bis_fnc_getFromPairs;

		// Clear the listbox.
		lnbClear _lnb;

		// Add the actions to the listbox and associate their data.
		{
			_actionName = _x select 0;
			_index = _x select 1;

			_keybind = (_handlerTracker select _index) select 2;
			_dikCode = _keybind select 0;
			_shift = _keybind select 1;
			_ctrl = _keybind select 2;
			_alt = _keybind select 3;

			// Try to convert dik code to a human key code.
			_keyName = [GVAR(dikDecToStringTable), format ["%1", _dikCode]] call bis_fnc_getFromPairs;
			if (isNil "_keyName") then {
				_keyName = format ["Unknown Code %1", _dikCode];
			};

			// Build the full key combination name.
			_keyString = format ["%1", _keyName];
			if (_shift) then {_keyString = format ["Shift+%1", _keyString]};	
			if (_alt) then {_keyString = format ["Alt+%1", _keyString]};
			if (_ctrl) then {_keyString = format ["Ctrl+%1", _keyString]};
			if (_keyString != "") then {
				// Add quotes around whole string.
				_keyString = format ["""%1""", _keyString]
			};

			// Add the row.
			_lnb lnbAddRow [_actionName, _keyString];

			// Set row data to the index of the action in the handler tracker.
			_lnb lnbSetData [[_forEachIndex, 0], format ["%1", _index]];

		} foreach _modActions;
	};
};