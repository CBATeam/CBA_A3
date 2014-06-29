#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_firstRun = false;
// Pass any parameter to the function for full initialization behavior.
if (count _this == 1) then {_firstRun = true};

_display = uiNamespace getVariable "RscDisplayConfigure";

if !(isNull _display) then {
	_combo = _display displayCtrl 208;
	_lb = _display displayCtrl 202;
	_comboMods = [];
	_handlerTracker = GVAR(handlers);
	_keyDict = [];

	// Parse the key handler tracker array.
	{
		// ["modName", "actionName", keyPressData array, "functionName", ehID]
		_modName = _x select 0;
		_actionName = _x select 1;
		_keyPressData = _x select 2;
		_functionName = _x select 3;
		_ehID = _x select 4;

		// Add all mods to the combo array.
		if !(_modName in _comboMods) then {
			_comboMods set [count _comboMods, _modName];
		};

		// Build a dictionary with entries like ["mod":["action",index],["action2",index]]]
		[_keyDict, _modName, [[_actionName, _forEachIndex]]] call bis_fnc_addToPairs;
	} foreach _handlerTracker;

	// Save combomods list to global var.
	GVAR(guiComboMods) = _comboMods;

	if (_firstRun) then {
		// Clear the combobox.
		lbClear _combo;

		if (count _comboMods > 0) then {
			// Populate the combolistbox.
			{_combo lbAdd _x} foreach _comboMods;
		};

		_combo lbSetCurSel 0;
	};

	if (count _comboMods > 0) then {
		// Get the selected mod.
		_current = _comboMods select (lbCurSel _combo);
		// Get the actions associated with the current mod.
		_curActions = [_keyDict, _current] call bis_fnc_getFromPairs;

		// Clear the listbox.
		lnbClear _lb;

		// Add the actions to the listbox and associate their data.
		{
			_actionName = _x select 0;
			_index = _x select 1;

			_keyPressData = (_handlerTracker select _index) select 2;
			_dikCode = _keyPressData select 0;
			_shift = _keyPressData select 1;
			_ctrl = _keyPressData select 2;
			_alt = _keyPressData select 3;

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

			// Add the row.
			_lb lnbAddRow [_actionName, _keyString];
			// Set row data to the index of the action in the binds registry.
			_lb lnbSetData [[_forEachIndex, 1], format ["%1", _index]];

		} foreach _curActions;
	};
};