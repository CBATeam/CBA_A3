// Extra initialization steps for the vanilla RscDisplayConfigure dialog
// needed to support mod keybinding system.

#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_display = _this select 0;

// Hide addons group on display init.
_addonsGroup = _display displayctrl 4301; 
_addonsGroup ctrlShow false;
_addonsGroup ctrlEnable false;

// Hide fake keyboard button on display init.
_fakeKeyboardButton = _display displayctrl 4303; 
_fakeKeyboardButton ctrlShow false;
_fakeKeyboardButton ctrlEnable false;

// Check if a mission has been started and functions initialized. We can't do anything from this dialog if not,
// because CBA does not (can not) run init scripts until mission start, and CfgFunctions will not run preInit = 1
// scripts until mission start as well.
//
// It could all be hardcoded into the displayInit, but that eliminates modularity and compatibility.
//
// This is a non-issue for most users, who will have a 'mission' loaded by the background of the
// main menu. Only people (devs) using an ocean world load to save time will be affected.

if (isNil "cba_fnc_registerKeybind") then {
	// XEH PreInit has not run yet, so we need to prepare this function right now.
	FUNC(onButtonClick_configure) = compile preprocessFileLineNumbers "\x\cba\addons\keybinding\gui\fnc_onButtonClick_configure.sqf";
	FUNC(onButtonClick_cancel) = {};

	_lb = _display displayCtrl 202;
	_lb lnbAddRow ["You must load an intro/world/mission to view/change."];
	
} else {
	[true] call FUNC(updateGUI); // true means first-run

	// Do this here to avoid automatic uppercasing by BI RscDisplayConfigure.sqf onLoad.
	_text = _display displayCtrl 206;
	_text ctrlSetText "Double click any action to change its binding";

	// Add handler to prevent key passthrough when waiting for input for binding (to block Esc).
	_display displayAddEventHandler ["KeyDown", "_this call cba_keybinding_fnc_onKeyDown"];
	_display displayAddEventHandler ["KeyUp", "_this call cba_keybinding_fnc_onKeyUp"];
	

	// Make copies of the current registry and handlers arrays (for Esc/cancel)
	GVAR(registryBackup) = + (profileNamespace getVariable [QGVAR(registry), []]);
	GVAR(handlersBackup) = + GVAR(handlers)

};