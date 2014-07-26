/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerKeybind

Description:
 Adds or updates the keybind handler for a specified mod action, and associates
 a function with that keybind being pressed.

Parameters:
 _modName			Name of the registering mod [String]
 _actionName		Name of the action to register [String]
 _code				Code to execute upon event [Code]
 _defaultKeybind	Default keybind [DIK code, [shift?, ctrl?, alt?]] [Array]

 Optional:
 _overwrite			Overwrite existing keybind data? [Bool] (Default: False)
 _keypressType		"keydown" (Default) = keyDown, "keyup" = keyUp [String]

Returns:
 Returns the current keybind for the action [Array]

Examples:
 // Register a simple keypress to an action
 // This file should be included for readable DIK codes.
 #include "\a3\editor_f\Data\Scripts\dikCodes.h"
 ["Your Mod", "Your Action", {["main"] call your_mod_fnc_openMenu}, [DIK_TAB, [true, true, true]]]
      call cba_fnc_registerKeybind;
 ["Your Mod", "Your Other Action", your_mod_fnc_openStuff, [DIK_K, [false, false, true]]] call cba_fnc_registerKeybind;


 // Register on keyup
 ["Your Mod", "Your KeyUp Action", {_this call your_mod_fnc_doStuff}, [DIK_O, [true, false, false]], false, "keyup"] call cba_fnc_registerKeybind;


 // Register different events for both keydown and keyup of the same action
 ["Your Mod", "Your Double Action", {_this call your_mod_fnc_keyDown}, [DIK_P, [false, false, false]], false, "keydown"] call cba_fnc_registerKeybind;
 ["Your Mod", "Your Double Action", {_this call your_mod_fnc_keyUp}, [DIK_P, [false, false, false]], false, "keyup"] call cba_fnc_registerKeybind;

Author:
 Taosenai
---------------------------------------------------------------------------- */

#include "\x\cba\addons\keybinding\script_component.hpp"

// Clients only.
if (isDedicated) exitWith {};

_nullKeybind = [-1,false,false,false];

PARAMS_3(_modName,_actionName,_code);
DEFAULT_PARAM(3,_defaultKeybind,_nullKeybind);
DEFAULT_PARAM(4,_overwrite,false);
DEFAULT_PARAM(5,_keypressType,"KeyDown");

// Get a local copy of the keybind registry.
_registry = profileNamespace getVariable [QGVAR(registry), []];

// Get a local copy of the handler tracker array.
_handlerTracker = GVAR(handlers);

// Get array of the mod's keybinds from the registry.
_modKeybinds = [];
_modKeybinds = [_registry, _modName, []] call bis_fnc_getFromPairs;

// Lowercase keypress type.
_keypressType = toLower _keypressType;

// Confirm correct formatting of keybind array.
if (count _defaultKeybind != 4) then {
	// See if it is a addKeyHandler style keypress array
	if (count _defaultKeybind == 2 && {typeName (_defaultKeybind select 1) == "ARRAY"} && {count (_defaultKeybind select 1) == 3}) then {
		// Convert from [DIK, [shift, ctrl, alt]] to [DIK, shift, ctrl, alt]
		_defaultKeybind = [_defaultKeybind select 0, (_defaultKeybind select 1) select 0, (_defaultKeybind select 1) select 1, (_defaultKeybind select 1) select 2];
	} else {
		// Key format is not known, set to nil and warn
		_defaultKeybind = _nullKeybind;

		_warn = ["[CBA Keybinding] ERROR: Invalid keybind format %1 for %2 %3. Using null keybind.", _defaultKeybind, _modName, _actionName];
		_warn call bis_fnc_error;
		diag_log format _warn;
	};
};

// Handle deprecated string function name.
if (typeName _code == "STRING") then {
	_code = compile format ["_this call %1", _code];

	_warn = ["[CBA_Keybinding] WARN: Deprecated call to cba_fnc_registerKeybind by %1 %2 -- code parameter is a string. Pass code directly (check function definition).", _modName, _actionName];
	_warn call bis_fnc_error;
	diag_log format _warn;
};

// _modKeybinds will be an empty array if not found in the registry.
if (count _modKeybinds == 0) then {
	// If nil, add the mod to the registry an empty array of keybinds.
	_modKeybinds = [];
	[_registry, _modName, _modKeybinds] call bis_fnc_setToPairs;
};

// Attempt to get the existing keypress data for the action.
_keybindData = [];
_keybindData = [_modKeybinds, _actionName, []] call bis_fnc_getFromPairs;

_keybind = nil;

// _keybindData will be an empty array if not found in the mod's registry entry.
if (count _keybindData > 0) then {
	// Only need the assigned data (select 0), not the default (select 1).
	_keybind = _keybindData select 0;
};

// If nil or overwrite specified, set the default keybind to the action.
if (isNil "_keybind" || _overwrite) then {
	// Only change the stored default keybinding if _overwrite was set true.
	if (_overwrite) then {
		[_modKeybinds, _actionName, [_defaultKeybind, _keybindData select 1]] call bis_fnc_setToPairs;
	} else {
		[_modKeybinds, _actionName, [_defaultKeybind, _defaultKeybind]] call bis_fnc_setToPairs;
	};

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
_index = [_modName, _actionName, _keypressType] call cba_fnc_getKeybind;

if (_index > -1) then {
	// It's already mapped to a key handler, so it must be updated.

	// Grab the handler data from the array.
	_handlerData = GVAR(handlers) select _index;

	// Remove any key handlers that are registered for it.
	_existingEHID = _handlerData select 4;
	if (_existingEHID > 0) then {
		// Remove the old key handler.
		[format ["%1", _existingEHID], _keypressType] call cba_fnc_removeKeyHandler;
	};

	// Get a fresh event handler ID.
	_ehID = GVAR(ehCounter);

	if (_dikCode != -1 && !isNil {_code}) then {  // A DIK code of -1 signifies "no key set"
		// Increment the event handler ID source.
		GVAR(ehCounter) = _ehID + 1;

		// Add CBA key handler.
		[_dikCode, [_shift, _ctrl, _alt], _code, _keypressType, format ["%1", _ehID]] call cba_fnc_addKeyHandler;

	} else {
		// No key handler will be created, so set ehID to -1 so that no removal will
		// be attempted on update.
		_ehID = -1;
	};

	// Update the handler tracker array.
	_handlerData = [_modName, _actionName, _keybind, _code, _ehID, _keypressType];
	_handlerTracker set [_index, _handlerData];
	GVAR(handlers) = _handlerTracker;

} else {
	// Not yet mapped to a key handler. 

	// Get a fresh event handler ID.
	_ehID = GVAR(ehCounter);

	if (_dikCode != -1 && !isNil {_code}) then {  // A DIK code of -1 signifies "no key set"
		// Increment the event handler ID source.
		GVAR(ehCounter) = _ehID + 1;

		// Add CBA key handler.
		[_dikCode, [_shift, _ctrl, _alt], _code, _keypressType, format ["%1", _ehID]] call cba_fnc_addKeyHandler;

	} else {
		// No key handler will be created, so set ehID to -1 so that no removal will
		// be attempted on update.
		_ehID = -1;
	};

	// Add to handler tracker array.
	_handlerData = [_modName, _actionName, _keybind, _code, _ehID, _keypressType];
	_handlerTracker set [count _handlerTracker, _handlerData];
	GVAR(handlers) = _handlerTracker;
};

_keybind;