// Extra initialization steps for the vanilla RscDisplayConfigure dialog
// needed to support mod keybinding system.

#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;
private ["_addonsGroup", "_fakeKeyboardButton", "_lb", "_text"];
params ["_display"];

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

//if in eden editor, postInit will not run, so there won't be any valid keybinds to modify
if (is3DEN) exitWith {
    _lb = _display displayCtrl 202;
    _lb lnbAddRow [localize LSTRING(canNotEdit)];
};

if (isNil "cba_fnc_registerKeybind") then {
    // XEH PreInit has not run yet, so we need to prepare this function right now.
    FUNC(onButtonClick_configure) = compile preprocessFileLineNumbers "\x\cba\addons\keybinding\gui\fnc_onButtonClick_configure.sqf";
    FUNC(onButtonClick_cancel) = {};

    _lb = _display displayCtrl 202;
    _lb lnbAddRow [localize LSTRING(canNotEdit)];

} else {
    [true] call FUNC(updateGUI); // true means first-run

    // Do this here to avoid automatic uppercasing by BI RscDisplayConfigure.sqf onLoad.
    _text = _display displayCtrl 206;
    _text ctrlSetText "Double click any action to change its binding";

    // Add handler to prevent key passthrough when waiting for input for binding (to block Esc).
    _display displayAddEventHandler ["KeyDown", "_this call cba_keybinding_fnc_onKeyDown"];
    _display displayAddEventHandler ["KeyUp", "_this call cba_keybinding_fnc_onKeyUp"];


};
