/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerKeybindToFleximenu

Description:
 Adds or updates the keybind handler for a defined Fleximenu and creates that Fleximenu.

Parameters:
 "modName"			String, name of the registering mod.
 "actionName"		String, name of the action to register.
 _fleximenuDef		Array, definition of the Fleximenu in the same format as
 					would be passed to CBA_fnc_flexiMenu_Add, but with the
 					keybind set to [].
 _defaultKeybind	Array, the default keybind in the format
                	[DIK code, shift?, ctrl?, alt?] (? indicates true/false)

 Optional:
 _overwrite			boolean, should this call overwrite existing keybind data?
            		False by default.

 _keypressType		String, open menu on KeyDown or KeyUp event?
					"KeyDown" by default. 

Returns:
 Returns the current keybind for the Fleximenu.

Examples:
 ["your_mod", "your_action", ["player", [], -100, "_this call my_menu_code_array"], [15, true, true, true]] call cba_fnc_registerKeybindToFleximenu;

Author:
 Taosenai
---------------------------------------------------------------------------- */

#include "\x\cba\addons\keybinding\script_component.hpp"

// Clients only.
if (isDedicated) exitWith {};

_nullKeybind = [-1,false,false,false];

PARAMS_3(_modName,_actionName,_fleximenuDef);
DEFAULT_PARAM(3,_defaultKeybind,_nullKeybind);
DEFAULT_PARAM(4,_overwrite,false);
DEFAULT_PARAM(5,_keypressType,"KeyDown");

// Help the user out by always setting the keycode param of the fleximenu
// def array to []. Give them a warning if it wasn't.
if (count (_fleximenuDef select 1) > 0) then {
	_fleximenuDef set [1, []];
	WARNING("Fleximenu definition passed to CBA_fnc_registerKeybindToFleximenu included a keycode. Ignoring it.")
};

// Create the fleximenu.
_fleximenuDef call cba_fnc_flexiMenu_add;

// Create the code to open the fleximenu.
_code = compile format ["%1 call cba_fnc_fleximenu_openMenuByDef;", _fleximenuDef];

// Pass everything to the real cba_fnc_registerKeybind.
_keybind = [_modName, _actionName, _code, _defaultKeybind, _overwrite, _keypressType] call cba_fnc_registerKeybind;

_keybind;
