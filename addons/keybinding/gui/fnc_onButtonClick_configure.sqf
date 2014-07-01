#include "\x\cba\addons\keybinding\script_component.hpp"

// This button, when clicked, toggles between vanilla and addon control config in RscDisplayConfigure.
disableSerialization;

// Get button
_ctrl = _this select 0;
// Get dialog
_display = uiNamespace getVariable "RscDisplayConfigure";

_KeyboardGroup = _display displayctrl 2300;
_MouseGroup = _display displayctrl 2301;
_addonsGroup = _display displayctrl 4301; 
_toggleButton = _display displayCtrl 4302;

_keyboardButton = _display displayctrl 2400;
_mouseButton = _display displayCtrl 2401;
_controllerButton = _display displayCtrl 106;
_title = _display displayCtrl 1000;

// Toggle displayed groups and buttons.
if !(ctrlEnabled _addonsGroup) then {
	// Hide keyboard group
	_KeyboardGroup ctrlenable false;
	_KeyboardGroup ctrlshow false;

	// Hide mouse group
	_MouseGroup ctrlenable false;
	_MouseGroup ctrlshow false;

	// Hide Presets button
	_control = _display displayctrl 114;
	_control ctrlenable false;
	_control ctrlshow false;

	// Hide Default button
	_control = _display displayctrl 101;
	_control ctrlenable false;
	_control ctrlshow false;

	// Hide mouse and controllers buttons
	_mouseButton ctrlenable false;
	_mouseButton ctrlshow false;
	_controllerButton ctrlenable false;
	_controllerButton ctrlshow false;

	//--- Set focus to KEYBOARD button

	// Show Addons group
	_addonsGroup ctrlenable true;
	_addonsGroup ctrlshow true;

	// Change button text
	_toggleButton ctrlSetText "Configure Base";
} else {
	// Switch back to vanilla keyboard config.	
	// Hide Addons group
	_addonsGroup ctrlenable false;
	_addonsGroup ctrlshow false;
	_toggleButton ctrlSetText "Configure Addons";

	//--- Enable Keyboard
	_KeyboardGroup ctrlenable true;
	_KeyboardGroup ctrlshow true;

	//--- Disable Mouse
	_MouseGroup ctrlenable false;
	_MouseGroup ctrlshow false;

	// Show mouse and controllers buttons
	_mouseButton ctrlenable true;
	_mouseButton ctrlshow true;
	_controllerButton ctrlenable true;
	_controllerButton ctrlshow true;
	
	//--- Set focus to KEYBOARD button
	
	//--- Show Presets button
	_control = _display displayctrl 114;
	_control ctrlenable true;
	_control ctrlshow true;
	
	//--- Hide Default button
	_control = _display displayctrl 101;
	_control ctrlenable false;
	_control ctrlshow false;
};