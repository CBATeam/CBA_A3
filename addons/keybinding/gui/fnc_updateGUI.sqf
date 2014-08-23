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
		// ["modName", "actionName", keybind, "functionName", ehID, "keypressType"]
		_modName = _x select 0;
		_actionName = _x select 1;
		_keybind = _x select 2;
		_functionName = _x select 3;
		// _ehID = _x select 4;
		_keypressType = _x select 5;

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
		_modName = _comboMods select (lbCurSel _combo);
		// Get the actions associated with the current mod.
		_modActions = [_keyDict, _modName] call bis_fnc_getFromPairs;

		// Clear the listbox.
		lnbClear _lnb;

		// Array tracking actionNames to be ignored as parsing continues.
		// Used so that only one entry is added for binds with two calls,
		// one using KeyDown and one using KeyUp.
		_ignore = [];

		// Add the actions to the listbox and associate their data.
		_lbCount = 0; // Count of items in listbox is not necessary equal to the count
		// of keybinds due to keyup/keydown.
		{
			_actionName = _x select 0;
			_index = _x select 1;

			if !(_actionName in _ignore) then {

				_keybind = (_handlerTracker select _index) select 2;
				_dikCode = _keybind select 0;
				_shift = _keybind select 1;
				_ctrl = _keybind select 2;
				_alt = _keybind select 3;

				_keypressType = (_handlerTracker select _index) select 5;

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

				// Search the modActions array (without current modAction) for any other 
				// actions with the same name but a different keypressType (KeyDown and
				// KeyUp on same actionname).
				_foundIndex = -1;
				{
					_sActionName = _x select 0;
					_sIndex = _x select 1;

					_sKeybind = (_handlerTracker select _sIndex) select 2;
					_sKeypressType = (_handlerTracker select _sIndex) select 5;

					if (_sActionName == _actionName && {_sKeypressType != _keypressType}) then {
						// Found an action with the same name but different keypresstypes.
						// Add it to the ignore array.
						_ignore set [count _ignore, _actionName];

						// Update the foundIndex to point to the found action
						_foundIndex = _sIndex;
					};
				} foreach (_modActions - [_x]);

				// Search the handler array for any other keybinds using this key.
				_isDuplicated = false;
				_dupAction = "";
				{
					_sModName = _x select 0;
					_sActionName = _x select 1;
					_sKeybind = _x select 2;
					_sKeypressType = _x select 5;

					if ((_sModName != _modName || _sActionName != _actionName) && [_sKeybind, _keybind] call bis_fnc_areEqual) exitWith {
						_isDuplicated = true;
						_dupAction = _sActionName;
					};

				} foreach _handlerTracker;

				if (_isDuplicated) then {
					// Add the name of the action that dupes the keybinding to the 
					// end of the readable bind string.
					_keyString = format ["%1 [%2]", _keyString, _dupAction];
				};

				// Add the row.
				_lnb lnbAddRow [_actionName, _keyString];

				// Format the array containing the indexes referred to by the action name.
				// It is stored as a string.
				_indexArray = [_index];
				if (_foundIndex > -1) then {
					_indexArray set [count _indexArray, _foundIndex];
				};

				// Set row data to the index of the action in the handler tracker.
				_lnb lnbSetData [[_lbCount, 0], format ["%1", _indexArray]];

				// Set the row color to red if a duplicate keybind exists.
				if (_isDuplicated) then {
					_lnb lnbSetColor [[_lbCount, 1], [1,0,0,1]];
				};

				_lbCount = _lbCount + 1;
			};
		} foreach _modActions;
	};
};