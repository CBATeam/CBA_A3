// Extra initialization steps for the vanilla RscDisplayConfigure dialog
// needed to support mod keybinding system.

#include "..\script_component.hpp"
SCRIPT(initDisplay)

disableSerialization;

with uiNamespace do {
	_display = _this select 0;

	// Hide addons group on display init.
	_addonsGroup = _display displayctrl 4301; 
	_addonsGroup ctrlShow false;
	_addonsGroup ctrlEnable false;

	// Initialize globals.
	GVAR(waitingForInput) = false; // Used by display event handler to block keys during input gather.

	// Check if a mission has been started and functions initialized. We can't do anything from this dialog if not,
	// because CBA does not (can not) run init scripts until mission start, and CfgFunctions will not run preInit = 1
	// scripts until mission start as well.
	//
	// It could all be hardcoded into the displayInit, but that eliminates modularity and compatibility.
	//
	// This is a non-issue for most users, who will have a 'mission' loaded by the background of the
	// main menu. Only people (devs) using an ocean world load to save time will be affected.

	_test = missionNamespace getVariable QUOTE(FUNC(registerKeybind));
	if (isNil "_test") then {
		if !(isNull _display) then {
			_lb = _display displayCtrl 202;
			_lb lnbAddRow ["You must load a mission to view/change these controls."];
			_lb lnbAddRow ["Sorry!"];
		};

		// Only initialize the toggle button events.
		FUNC(guiOnKeyDown) = {};
		FUNC(guiOnLBDblClick) = {};
		FUNC(guiOnButtonClick) = COMPILE_FILE(gui\onButtonClick);
		FUNC(guiOnComboChanged) = {};

	} else {
		FUNC(guiUpdate) = COMPILE_FILE(gui\update);
		[true] call FUNC(guiUpdate); // true means first-run

		// Initialize functions for GUI events.
		FUNC(guiOnKeyDown) = COMPILE_FILE(gui\onKeyDown);
		FUNC(guiOnLBDblClick) = COMPILE_FILE(gui\onLBDblClick);
		FUNC(guiOnButtonClick) = COMPILE_FILE(gui\onButtonClick);
		FUNC(guiOnComboChanged) = COMPILE_FILE(gui\onComboChanged);

		// Add handler to prevent key passthrough when waiting for input for binding (to block Esc).
		_display displayAddEventHandler ["KeyDown", format ["with uiNamespace do {_this call %1}", QUOTE(FUNC(guiOnKeyDown)]];
	};
};
