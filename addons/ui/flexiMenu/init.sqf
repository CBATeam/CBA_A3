#include "\x\cba\addons\ui\script_component.hpp"

if (isDedicated) exitWith {false};

FUNC(keyDown) = CBA_fnc_flexiMenu_keyDown;
FUNC(keyUp) = CBA_fnc_flexiMenu_keyUp;
FUNC(menu) = CBA_fnc_flexiMenu_menu;
FUNC(list) = CBA_fnc_flexiMenu_list;
FUNC(getMenuDef) = CBA_fnc_flexiMenu_getMenuDef;
FUNC(getMenuOption) = CBA_fnc_flexiMenu_getMenuOption;
FUNC(menuShortcut) = CBA_fnc_flexiMenu_menuShortcut;
FUNC(mouseButtonDown) = CBA_fnc_flexiMenu_mouseButtonDown;
FUNC(highlightCaretKey) = CBA_fnc_flexiMenu_highlightCaretKey;
FUNC(execute) = CBA_fnc_flexiMenu_execute;
FUNC(add) = CBA_fnc_flexiMenu_add;
FUNC(remove) = CBA_fnc_flexiMenu_remove;
FUNC(setObjectMenuSource) = CBA_fnc_flexiMenu_setObjectMenuSource;

// list of all menu activation keys and associated types
GVAR(typeMenuSources) = []; // types, keys and menu sources data
GVAR(target) = objNull; // current object for interaction
GVAR(holdKeyDown) = false; // default global behaviour of requiring holding key down. Can be overriden by menus.
GVAR(hotKeyColor) = ""; // override colour of hotkey. It is set from rsc menu file, upon opening either the "menu" or "list". If not present, a default will be used.

// prevent instant reactivation of menu after selection was made, while key still held down. Value is reset upon key release.
GVAR(optionSelected) = false;
// prevent multiple activations of menu due to key press via keyDown. onLoad can sometimes take a few milliseconds to init.
GVAR(lastAccessCheck) = [0, -1];

GVAR(keyDown_EHID) = ["keyDown", QUOTE(_this call FUNC(keyDown))] call CBA_fnc_addDisplayHandler;
GVAR(keyUp_EHID) = ["keyUp", QUOTE(_this call FUNC(keyUp))] call CBA_fnc_addDisplayHandler;

true;
