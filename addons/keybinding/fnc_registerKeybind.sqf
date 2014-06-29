/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerKeybind

Description:
 Adds or updates the keybind handler for a specified mod action, and associates
 a function with that keybind being pressed.

Parameters:
 "modName"  String, name of the registering mod.
 "actionName"  String, name of the action to register.
 "functionName"  String, name of the function to call when key is pressed.
 _defaultKeybind  Array, the default keybind in the format
                [DIK code, shift?, ctrl?, alt?] (? indicates true/false)

 Optional:
 _overwrite  boolean, should this call overwrite existing keybind data?
             False by default.

Returns:
 Returns true on success.

Examples:
 ["your_mod", "your_action", "your_mod_fnc_openMenu", [15, true, true, true]]
      call cba_fnc_registerKeybind;

Author:
 Taosenai
---------------------------------------------------------------------------- */

#include "\x\cba\addons\keybinding\script_component.hpp"

// Clients only.
if (isDedicated) exitWith {};

// Parse parameters.
_modName = [_this, 0, nil, [""]] call bis_fnc_param;
_actionName = [_this, 1, nil, [""]] call bis_fnc_param;
_functionName = [_this, 2, nil, [""]] call bis_fnc_param;
_defaultKeybind = [_this, 3, [-1, false, false, false], [[]], 4] call bis_fnc_param;
_overwrite = [_this, 4, false, [false, true]] call bis_fnc_param;

// Get a local copy of the keybind registry.
_registry = profileNamespace getVariable [QGVAR(registry), []];

// Get a local copy of the handler tracker array.
_handlerTracker = GVAR(handlers);

// Get array of the mod's keybinds from the registry.
_modKeybinds = [_registry, _modName] call bis_fnc_getFromPairs;
if (isNil "_modKeybinds") then {
	// If nil, add the mod to the registry an empty array of keybinds.
	[_registry, _modName, []] call bis_fnc_setToPairs;
	_modKeybinds = [];
};

// Get the existing keypress data for the action.
_keybind = [_modKeybinds, _actionName] call bis_fnc_getFromPairs;
if (isNil "_keybind" || _overwrite) then {
	// If nil or overwrite specified, set the default keybind to the action.
	[_modKeybinds, _actionName, _defaultKeybind] call bis_fnc_setToPairs;
	_keybind = _defaultKeybind;

	// Update local registry.
	[_registry, _modName, _modKeybinds] call bis_fnc_setToPairs;
	// Update profile registry.
	profileNamespace setVariable [QGVAR(registry), _registry];
};

// Split the keybind data.
_dikCode = _keybind select 0;
_shift = _keybind select 1;
_ctrl = _keybind select 2;
_alt = _keybind select 3;

// See if this action has already been mapped to a keybind.
_index = [_modName, _actionName] call cba_fnc_getKeybind;

if (_index > -1) then {
	// It's already mapped to a key handler, so it must be updated.

	// Grab the handler data from the array.
	_handlerData = GVAR(handlers) select _index;

	// Remove any key handlers that are registered for it.
	_existingEHID = _handlerData select 4;
	if (_existingEHID > 0) then {
		// Remove the old key handler.
		[format ["%1", _existingEHID]] call cba_fnc_removeKeyHandler;
	};

	// Get a fresh event handler ID.
	_ehID = GVAR(ehCounter);
	// Increment the event handler ID source.
	GVAR(ehCounter) = _ehID + 1;

	// Add new key handler with updated data if a key is specified.
	if (_dikCode != -1) then { // A DIK of -1 signifies "no key set"
		// Add CBA key handler.
		[_dikCode, [_shift, _ctrl, _alt], compile format ["_this call %1", _functionName], "keydown", format ["%1", _ehID]] call cba_fnc_addKeyHandler;
	};

	// Update the handler tracker array.
	_handlerData = [_modName, _actionName, _keybind, _functionName, _ehID];
	_handlerTracker set [_index, _handlerData];
	GVAR(handlers) = _handlerTracker;

} else {
	// Not yet mapped to a key handler. 

	// Get a fresh event handler ID.
	_ehID = GVAR(ehCounter);
	// Increment the event handler ID source.
	GVAR(ehCounter) = _ehID + 1;

	if (_dikCode != -1) then { // A DIK of -1 signifies "no key set"
		// Add CBA key handler.
		[_dikCode, [_shift, _ctrl, _alt], compile format ["_this call %1", _functionName], "keydown", format ["%1", _ehID]] call cba_fnc_addKeyHandler;
	};

	// Add to handler tracker array.
	_handlerData = [_modName, _actionName, _keybind, _functionName, _ehID];
	_handlerTracker set [count _handlerTracker, _handlerData];
	GVAR(handlers) = _handlerTracker;
};


true;